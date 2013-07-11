<?php
class ControllerPageHome extends Controller
{
	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("core/user");
		$this->load->helper('image');
		$this->load->model("core/category");
	}
	
	function index()
	{	
		$siteid = $this->user->getSiteId();
		$this->data['sitemapid'] = $this->request->get['sitemapid'];
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($this->data['sitemapid'], $siteid);
		$this->id='content';
		$this->template='page/home.tpl';
		$this->layout='layout/center';
		$this->render();
		
		
	}
	
	public function getList()
	{
		$sitemapid = $this->request->get['sitemapid'];
		$siteid = $this->user->getSiteId();
		$this->data['breadcrumb'] = $this->model_core_sitemap->getBreadcrumb($sitemapid, $siteid);
		if($sitemapid == "")
		{
			$sitemaps = $this->model_core_sitemap->getListByModule("module/product", $siteid);
			$arrsitemapid = $this->string->matrixToArray($sitemaps,"sitemapid");
		}
		else
		{
			$data = array();
			$sitemaps = $this->model_core_sitemap->getTreeSitemap($sitemapid,$data,$siteid);
			$arrsitemapid = $this->string->matrixToArray($data,"sitemapid");
		}
		$arr = array();
		$where = " AND mediaparent = '' AND mediatype = '' ";
		foreach($arrsitemapid as $sitemapid)
		{
			$arr[] = " refersitemap like '%[".$sitemapid."]%'";
		}
		if(count($arr))
			$where .= "AND (". implode($arr," OR ").")";
		
		$keyword = urldecode($this->request->get['keyword']);
		$arrkey = split(' ', $keyword);
		
		if($keyword !="")
		{
			$arr = array();
			foreach($arrkey as $key)
			{
				$arr[] = "title like '%".$key."%'";
			}
			$where .= " AND (". implode(" AND ",$arr). ")";
			//$where .= " AND ( title like '%".$keyword."%' OR summary like '%".$keyword."%' OR description like '%".$keyword."%')";
		}
		
		$where .= " Order by position, statusdate DESC";
		$this->data['medias'] = array();
		$this->data['medias'] = $this->model_core_media->getList($where);
		
		
		foreach($this->data['medias'] as $i => $media)
		{
			
			
			if($this->data['medias'][$i]['imagepath'] != "")
			{
				$this->data['medias'][$i]['imagepreview'] = "<img src='".HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 130, 130)."' >";
				
			}
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->viewTonKho($mediaid);
			
			
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="module/product_list.tpl";
		
		
		$this->render();
	}
	
	public function productCat()
	{
		$siteid = $this->user->getSiteId();
		//$where = " AND moduleid = 'module/product' AND sitemapparent = ''";
		
		//$data_catroot = $this->model_core_sitemap->getList($siteid,$where);
		//$this->data['catshow'] = "";
		//foreach($data_catroot as $sitemap)
		//{
		$this->data['catshow'] .= $this->showTreeSiteMap("");
		//}
		
		$this->id='content';
		$this->template='module/product_cat.tpl';
		$this->render();
	}
	
	private function showTreeSiteMap($parentid)
	{
		$siteid = $this->user->getSiteId();
		$str = "";
		
		$sitemaps = $this->model_core_sitemap->getListByParent($parentid, $siteid, "Active");
		
		foreach($sitemaps as $item)
		{
			if($item['moduleid'] == "module/product")
			{
				$childs = $this->model_core_sitemap->getListByParent($item['sitemapid'], $siteid);
				
				$link = "<a href='#sitemapid=".$item['sitemapid']."' class='procat' ref='".$item['sitemapid']."'>".$item['sitemapname']."</a> ";
				//if($this->user->checkPermission("module/product/addcat")==true)
					//$link .= "<a class='addcat' cparent='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/add.png' width='19px'></a>";
				//if($this->user->checkPermission("module/product/editcat")==true)
					//$link .= "<a class='editcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/edit.png' width='19px'></a>";
				/*if(count($childs) == 0)
				{
					if($this->user->checkPermission("module/product/delcat")==true)
						$link .= "<a class='delcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/del.png' width='19px'></a>";
				}*/
				$str .= "<li>";
				
				$str .= $link;
				
				if(count($childs) > 0)
				{
					
					
					
					$str .= "<ul>";
					$str .= $this->showTreeSiteMap($item['sitemapid']);
					$str .= "</ul>";
				}
				else
				{
					
					
					
				}
				$str .= "</li>";
				
			}
		}
		
		return $str;
	}
	
	public function viewProduct()
	{
		$mediaid = $this->request->get['mediaid'];
		$this->data['media'] = $this->model_core_media->getItem($mediaid);
		$this->data['media']['saleprice'] = json_decode($this->data['media']['saleprice']);
		$this->id='content';
		$this->template='module/product_view.tpl';
		$this->render();
	}
}
?>