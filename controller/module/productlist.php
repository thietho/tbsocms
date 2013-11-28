<?php
class ControllerModuleProductlist extends Controller
{
	public function index($sitemapid="", $count = 0,$headername ="", $template = array(),$medias=array())
	{
		
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->data['statuspro'] = array();
		$this->model_core_category->getTree("status",$this->data['statuspro']);
		unset($this->data['statuspro'][0]);
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		
		
		$tp = array(
						'template' => "module/information.tpl",
						);
		$arr = array($this->member->getSiteId().$sitemapid,$tp);
		
		$this->data['content'] = $this->loadModule('module/block','showContent',$arr);
		$siteid = $this->user->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['sitemap']['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
		if($headername!="")
			$this->data['sitemap']['sitemapname'] = $headername;
		
		
		$step = (int)$this->request->get['step'];
		$to = $count;
		//$_GET = $this->document->getPara();
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
		$queryoptions['mediaparent'] = '';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $listsitemap;
		$order = $_GET['order'];
		$orderby = "";
		switch($order)
		{
			case "az":
				$orderby = " ORDER BY `title` ASC";
				break;
			case "gt":
				$orderby = " ORDER BY `price` ASC";
				break;
			case "gg":
				$orderby = " ORDER BY `price` DESC";
				break;
			default:
				$orderby = " ORDER BY `updateddate` DESC";
		}
		
		
		if(count($medias)==0)
		{
			//$medias = $this->model_core_media->getPaginationList($queryoptions, $step, $to);
			$medias = $this->model_core_media->getPaginationList($queryoptions,0,0,$orderby);
		}
		
		
		$this->data['medias'] = array();
		
	
		$index = -1;
		//Page
		
		
		$page = $_GET['page'];
		
		$x=$page;		
		$limit = $to;
		$total = count($medias);
		//$uri = $this->document->createLink($sitemapid);
		$uri = $this->document->getURI();
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutWeb($total, $limit, $page,$uri); 
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($medias[$i])>0;$i++)
		//foreach($medias as $media)
		{
			$index += 1;
			$media = $medias[$i];
			
			$arr = $this->string->referSiteMapToArray($media['refersitemap']);
			$sitemapid = $arr[0];
			
			
			$link = $this->document->createLink($sitemapid,$media['alias']);
			$imagethumbnail = "";
			
			//if($media['imagepath'] != "" )
			{
				$imagethumbnail = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
				$imagetpreview = HelperImage::resizePNG($media['imagepath'], $template['widthpreview'], $template['heightpreview']);
			}
			
			
			$properties = $this->string->referSiteMapToArray($media['groupkeys']);
			$media['summary'] = html_entity_decode($media['summary']);
			$media['link']= $link;
			$media['properties']= $properties;
			$media['imagethumbnail']= $imagethumbnail;
			$media['imagetpreview']= $imagetpreview;
			$media['statusdate']= $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/");
			
			$this->data['medias'][] = $media;
			/*$this->data['medias'][] = array(
				'mediaid' => $media['mediaid'],
				'title' => $media['title'],
				'keyword' => $media['keyword'],
				'summary' => html_entity_decode($media['summary']),
				'price' => $price,
				'volume' => $volume,
				'properties' => $properties,
				'imagethumbnail' => $imagethumbnail,
				'imagetpreview' => $imagetpreview,
				'fileid' => $media['imageid'],
				'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
				'link' => $link
			);*/
			
		}
			
			
		/*$this->data['medias'][$i] =$media;
		$this->data['medias'][$i]['link']= $link;
		$this->data['medias'][$i]['properties']= $properties;
		$this->data['medias'][$i]['imagethumbnail']= $imagethumbnail;
		$this->data['medias'][$i]['imagetpreview']= $imagetpreview;
		$this->data['medias'][$i]['statusdate']= $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/");*/
		
		
		
		$this->data['status'] = $template['status'];
		$this->data['paging'] = $template['paging'];
		$this->data['sorting'] = $template['sorting'];
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	
	}
	
	
	public function getAll($sitemapid="", $count = 0,$headername ="", $template = array(),$medias=array())
	{
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->data['statuspro'] = array();
		$this->model_core_category->getTree("status",$this->data['statuspro']);
		unset($this->data['statuspro'][0]);
		if($sitemapid == "")
			$sitemapid = $this->document->sitemapid;
		
		$siteid = $this->user->getSiteId();
		$this->data['sitemap'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->data['sitemap']['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
		if($headername!="")
			$this->data['sitemap']['sitemapname'] = $headername;
		
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
		$queryoptions['mediaparent'] = '';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $listsitemap;
		
		$order = $_GET['order'];
		$orderby = "";
		switch($order)
		{
			case "az":
				$orderby = " ORDER BY `title` ASC";
				break;
			case "gt":
				$orderby = " ORDER BY `price` ASC";
				break;
			case "gg":
				$orderby = " ORDER BY `price` DESC";
				break;
			default:
				$orderby = " ORDER BY position,`title` DESC";
		}
		if($mediaid == "")
		{
			if(count($medias)==0)
			{
				//$medias = $this->model_core_media->getPaginationList($queryoptions, $step, $to);
				$medias = $this->model_core_media->getPaginationList($queryoptions,0,0,$orderby);
			}
			
			//print_r($medias);
			$this->data['medias'] = array();
			
		
			$index = -1;
			foreach($medias as $i => $media)
			{
				$index += 1;
				//$media = $medias[$i];
				
				$arr = $this->string->referSiteMapToArray($media['refersitemap']);
				$sitemapid = $arr[0];
				
				$link = $this->document->createLink($sitemapid,$media['alias']);
				
				$imagethumbnail = "";
				
				//if($media['imagepath'] != "" )
				{
					$imagethumbnail = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
					$imagetpreview = HelperImage::resizePNG($media['imagepath'], $template['widthpreview'], $template['heightpreview']);
				}
				
				
				
				
				$properties = $this->string->referSiteMapToArray($media['groupkeys']);
				$this->data['medias'][$i] =$media;
				$this->data['medias'][$i]['link']= $link;
				$this->data['medias'][$i]['properties']= $properties;
				$this->data['medias'][$i]['imagethumbnail']= $imagethumbnail;
				$this->data['medias'][$i]['imagetpreview']= $imagetpreview;
				$this->data['medias'][$i]['statusdate']= $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/");
				
				
			}
			
			
			
		}
		$this->data['status'] = $template['status'];
		$this->id="news";
		$this->template=$template['template'];
		$this->render();
	}
}
?>