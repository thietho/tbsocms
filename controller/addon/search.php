<?php
class ControllerAddonSearch extends Controller
{
	private $error = array();
	public function index()
	{
		$keyword = $this->request->get['keyword'];
		$this->document->breadcrumb .= "Tìm kiếm";
		$this->data['title'] = "Kết quả tìm kiếm với từ khóa: ".$keyword;
		$this->getList($keyword);
		$this->id="content";
		$this->template="addon/search.tpl";
		$this->render();
	}
	
	private function getList($keyword)
	{
		
		$this->load->model("core/media");
		$this->load->model("core/sitemap");
		$this->load->helper('image');
		
		$siteid = $this->member->getSiteId();
		
		$listsitemapid = array();
		$arrsitemap = $this->model_core_sitemap->getListByModule('module/news', $siteid);
		foreach($arrsitemap as $item){
			$listsitemapid[] = $item['sitemapid'];
		}
		
		/*$arrsitemap = $this->model_core_sitemap->getListByModule('module/register', $siteid);
		foreach($arrsitemap as $item){
			$listsitemapid[] = $item['sitemapid'];
		}*/
		//$this->document->title .= " - ".$this->data['sitemap']['sitemapname'];
		$step = (int)$this->request->get['step'];
		$to = 10;
		//
		//Get list
		$queryoptions = array();
		$queryoptions['keyword'] = $keyword;
		$queryoptions['mediaparent'] = '%';
		$queryoptions['mediatype'] = '%';
		$queryoptions['refersitemap'] = $listsitemapid;
		
		if($mediaid == "")
		{
			$medias = $this->model_core_media->getPaginationList($queryoptions,$step,0);

			$this->data['medias'] = array();
			
			
			$index = -1;
			
			
			
			
			
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
				$media=$medias[$i];
				
				$arr = $this->string->referSiteMapToArray($media['refersitemap']);
				$sitemapid = $arr[0];
				
				
				$link = $this->document->createLink($sitemapid,$media['alias']);
				$imagethumbnail = "";
				$imagethumbnail = HelperImage::resizePNG($media['imagepath'], 150, 0);
				
				$this->data['medias'][] = array(
					'mediaid' => $media['mediaid'],
					'title' => $media['title'],
					'summary' => html_entity_decode($media['summary']),
					'imagethumbnail' =>$imagethumbnail,
					'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
					'link' => $link
				);
					
			
				
			}
		
			
			
		}
			
			
			
			
			
			
			
			
			
			
			
			
			/*
			
					
					foreach($medias as $media)
					{
						$index += 1;
						if($sitemapid == "")
						{
							$arr = $this->string->referSiteMapToArray($media['refersitemap']);
							$sitemapid = $arr[0];
						}
						$link = $this->document->createLink($sitemapid,$media['alias']);
						
						
						if($media['imagepath'] != "" && $template['width'] >0 )
						{
							$imagethumbnail = HelperImage::resizePNG($media['imagepath'], $template['width'], $template['height']);
						}
			
						
						$this->data['medias'][] = array(
							'mediaid' => $media['mediaid'],
							'title' => $media['title'],
							'summary' => html_entity_decode($media['summary']),
							'imagethumbnail' =>$media['imagepath'],
							'statusdate' => $this->date->formatMySQLDate($media['statusdate'], 'longdate', "/"),
							'link' => $link
						);
						
					}
					
			}*/
			
		}
	}

?>