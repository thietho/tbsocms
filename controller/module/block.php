<?php
class ControllerModuleBlock extends Controller
{
	public function getList($sitemapid="", $count = 0,$headername = "", $template = array(),$medias=array())
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		$siteid = $this->member->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		//$this->document->title .= " - ".$this->data['sitemap']['sitemapname'];
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
			if(count($medias)==0)
				$medias = $this->model_core_media->getPaginationList($queryoptions, $step, $to);
			
			
			
			$this->data['medias'] = array();
			
		
			$index = 0;
			foreach($medias as $media)
			{
				$index += 1;
				$arr = $this->string->referSiteMapToArray($media['refersitemap']);
				$sitemapid = $arr[0];
				$link = $this->document->createLink($sitemapid,$media['alias']);
				$imagethumbnailpng = "";
				$imagethumbnail = "";
				//if($media['imagepath'] != ""  )
				{
					$imagethumbnailpng = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
					@$imagethumbnail = HelperImage::fixsize($media['imagepath'], $template['width'], $template['height']);
				}
	
				
				$this->data['medias'][] = array(
					'mediaid' => $media['mediaid'],
					'title' => $media['title'],
					'summary' => html_entity_decode( $media['summary']),
					'eventdate' => $media['eventdate'],
					'eventtime' => $media['eventtime'],
					'imagethumbnailpng' => $imagethumbnailpng,
					'imagethumbnail' => $imagethumbnail,
					'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
					'link' => $link
				);
				if($count>0)
					if($index >= $count)
						break;
			}
			
			
			
			
			
		}
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	
	}
	
	public function getLink($sitemapid="", $count = 5,$headername = "", $template = array(),$medias=array())
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		$siteid = $this->member->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		//$this->document->title .= " - ".$this->data['sitemap']['sitemapname'];
		$step = (int)$this->request->get['step'];
		$to = $count;
		
		//Get list
		$queryoptions = array();
		$queryoptions['mediaparent'] = '%';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $sitemapid;
		
		if($mediaid == "")
		{
			$medias = $this->model_core_media->getPaginationList($queryoptions, $step, $to);
			
			if(count($medias) == 1)
			{
				
			}
			
			$this->data['medias'] = array();
			
		
			$index = -1;
			foreach($medias as $media)
			{
				$index += 1;
				
				$link = $this->model_core_media->getInformation($media['mediaid'],"Link");
				
				$imagethumbnail = "";
				if($media['imagepath'] != ""  )
				{
					$imagethumbnailpng = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
					@$imagethumbnail = HelperImage::fixsize($media['imagepath'], $template['width'], $template['height']);
					
				}
	
				
				$this->data['medias'][] = array(
					'mediaid' => $media['mediaid'],
					'title' => $media['title'],
					'summary' => $media['summary'],
					'imagethumbnail' => $imagethumbnail,
					'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
					'link' => $link
				);
				
			}
			
			
		}
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	
	}
	
	public function getSitemaps($sitemapid="",$count = 0,$headername = "", $template = array())
	{
		$this->load->model('core/sitemap');	
		$siteid = $this->member->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['list']=$this->getMenu($sitemapid);
		$this->id="sitemap";
		$this->template="sitebar/catalogue.tpl";
		$this->render();
	}
	
	public function getMenu($parentid)
	{
		
		
		$siteid = $this->member->getSiteId();
		
		$rootid = $this->model_core_sitemap->getRoot($this->document->sitemapid, $siteid);

		if($this->document->sitemapid == "")
			$rootid = 'homepage';
		$str = "";
		
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		
		foreach($sitemaps as $item)
		{
			$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
			
			$currenttab = "";
			if($item['sitemapid'] == $rootid) 
				$currenttab = "class='current-tab'";
			
			$link = "<a ".$currenttab.">".$item['sitemapname']."</a>";
			
			if($item['moduleid'] != "group")
			{
				$link = "<a ".$currenttab." href='".$this->document->createLink($item['sitemapid'])."'>".$item['sitemapname']."</a>";
			}
			if($item['moduleid'] == "homepage"){
				$link = "<a ".$currenttab." href='index.php'>".$item['sitemapname']."</a>";
			}
			
			$str .= "<li>";
			$str .= $link;
			
			if(count($childs) > 0)
			{
				$str .= "<ul>";
				$str .= $this->getMenu($item['sitemapid']);
				$str .= "</ul>";
			}

			$str .= "</li>";
		}
		
		return $str;
		
	}
	
	public function getMenuChild($parentid,$headername = "", $template = array())
	{
		$this->load->model('core/sitemap');	
		$this->load->model('core/media');	
		$this->load->helper('image');
		$siteid = $this->member->getSiteId();
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid);
		$medias = array();
		foreach($sitemaps as $key =>$item)
		{
			$medias[$key] = $this->model_core_media->getItem($this->member->getSiteId().$item['sitemapid']);
			$medias[$key]['headertitle'] = $item['sitemapname'];
			$link = $this->document->createLink($item['sitemapid']);
				
			$imagethumbnailpng = "";
			$imagethumbnail = "";
			if($medias[$key]['imagepath'] != "" && $template['width'] >0 )
			{
				$imagethumbnailpng = HelperImage::resizePNG($medias[$key]['imagepath'], $template['width'], $template['height']);
				@$imagethumbnail = HelperImage::fixsize($medias[$key]['imagepath'], $template['width'], $template['height']);
			}
			$medias[$key]['imagethumbnailpng'] =$imagethumbnailpng;
			$medias[$key]['imagethumbnail'] =$imagethumbnail;
			$medias[$key]['summary'] = html_entity_decode($medias[$key]['summary']);
			$medias[$key]['link'] =$link;
		}
		$this->data['medias'] = $medias;
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
		
	}
	
	public function showMenuContent($arrmenuid,$headername = "", $template = array())
	{
		$this->load->model('core/sitemap');	
		$this->load->model('core/media');	
		$this->load->helper('image');
		$siteid = $this->member->getSiteId();
		
		$where = "AND sitemapid in ('".implode("','",$arrmenuid)."')";
		$sitemaps = $this->model_core_sitemap->getList($siteid,$where);
		
		$medias = array();
		foreach($arrmenuid as $key =>$sitemapid)
		{
			
			$medias[$key] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
			$medias[$key]['headertitle'] = $item['sitemapname'];
			$link = $this->document->createLink($sitemapid);
				
			$imagethumbnail = "";
			if($medias[$key]['imagepath'] != "" && $template['width'] >0 )
			{
				$imagethumbnailpng = HelperImage::resizePNG($medias[$key]['imagepath'], $template['width'], $template['height']);
				@$imagethumbnail = HelperImage::fixsize($medias[$key]['imagepath'], $template['width'], $template['height']);
			}
			$medias[$key]['imagethumbnailpng'] =$imagethumbnailpng;
			$medias[$key]['imagethumbnail'] =$imagethumbnail;
			$medias[$key]['summary'] = html_entity_decode($medias[$key]['summary']);
			$medias[$key]['link'] =$link;
		}
		$this->data['medias'] = $medias;
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
		
	}
	
	public function showContent($mediaid,$template = array())
	{
		$this->load->model("core/media");
		$this->load->helper('image');
		
		$this->data['media'] = $this->model_core_media->getItem($mediaid);
		$this->data['media']['imagethumbnail'] = HelperImage::fixsize($this->data['media']['imagepath'], $template['width'], $template['height']);
		$this->data['media']['description'] = html_entity_decode($this->data['media']['description']);
		$this->data['media']['link'] = $this->document->createLink(str_replace($this->member->getSiteId(),"",$mediaid));
		
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	}
	
	public function showRegisterPage($mediaid,$template = array())
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		$this->data['media'] = $this->model_core_media->getItem($mediaid);
		$this->document->title .= $this->data['media']['title'];
		$this->data['media']['imagethumbnail'] = HelperImage::fixsize($this->data['media']['imagepath'], $template['width'], $template['height']);
		$this->data['media']['description'] = html_entity_decode($this->data['media']['description']);
		$this->data['media']['link'] = $this->document->createLink(str_replace($this->member->getSiteId(),"",$mediaid));
		
		$where = " AND moduleid = 'module/register' AND sitemapid <> 'dangkyonline'";
		$this->data['data_sitemap'] = $this->model_core_sitemap->getList($this->member->getSiteId(),$where);
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	}
	
}
?>