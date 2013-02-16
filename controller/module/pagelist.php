<?php
class ControllerModulePagelist extends Controller
{
	public function getList($sitemapid="", $count = 0,$headername ="", $template = array(),$medias=array())
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		$siteid = $this->member->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->document->title .= " - ".$this->data['sitemap']['sitemapname'];
		$step = (int)$this->request->get['step'];
		$to = $count;
		
		//Get list
		$child = array();
		$this->model_core_sitemap->getTreeSitemap($sitemapid,$child,$this->member->getSiteId());
		$listsitemap = array();
		if(count($child))
		{
			foreach($child as $item)
				$listsitemap[] = $item['sitemapid'];
		}
		
		$queryoptions = array();
		$queryoptions['mediaparent'] = '%';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $listsitemap;
		
		if($mediaid == "")
		{
			
			
			if(count($medias) == 0)
			{
				$medias = $this->model_core_media->getPaginationList($queryoptions, $step, $to);
			}
			
			$this->data['medias'] = array();
			
		
			$index = -1;
			foreach($medias as $media)
			{
				$index += 1;
				$arr = $this->string->referSiteMapToArray($media['refersitemap']);
				$sitemapid = $arr[0];
				$link = $this->document->createLink($sitemapid,$media['alias']);
				
				$imagethumbnail = "";
				//if($media['imagepath'] != "" && $template['width'] >0 )
				{
					$imagethumbnailpng = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
					@$imagethumbnail = HelperImage::fixsize($media['imagepath'], $template['width'], $template['height']);
				}
	
				$startdate = $this->model_core_media->getInformation($media['mediaid'],"startdate");
				$this->data['medias'][] = array(
					'mediaid' => $media['mediaid'],
					'title' => $media['title'],
					'summary' => html_entity_decode($media['summary']),
					'startdate' => $this->date->formatMySQLDate($startdate),
					'eventdate' => $this->date->formatMySQLDate($media['eventdate']),
					'eventtime' => $media['eventtime'],
					'imagethumbnailpng' => $imagethumbnailpng,
					'imagethumbnail' => $imagethumbnail,
					'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
					'link' => $link
				);
				
			}
			
			$querystring = "?route=page/detail&sitemapid=".$sitemapid;
			
			$pagelinks = $this->model_core_media->getPaginationLinks($index, $queryoptions, $querystring, $step, $to);
			
			$this->data['nextlink'] = $pagelinks['nextlink'];
			$this->data['prevlink'] = $pagelinks['prevlink'];
			
			//Other news
			$this->data['othernews'] = $this->model_core_media->getPaginationList($queryoptions, $step+1, $to);
			for($i=0;$i<count($this->data['othernews']);$i++)
			{
				$this->data['othernews'][$i]['statusdate'] = $this->date->formatMySQLDate($this->data['othernews'][$i]['statusdate'], 'longdate', "/");
				$link = $this->document->createLink($sitemapid,$this->data['othernews'][$i]['alias']);
				$this->data['othernews'][$i]['link'] = $link;
			}
			
		}
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	
	}
	
	
}
?>