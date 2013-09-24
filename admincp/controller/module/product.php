<?php
class ControllerModuleProduct extends Controller
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
		$this->template='module/product.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function getList()
	{
		$sitemapid = $this->request->get['sitemapid'];
		$this->data['sitemapid'] = $sitemapid;
		$siteid = $this->user->getSiteId();
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
		$where = " AND mediaparent = '' AND mediatype = 'module/product' ";
		if($sitemapid)
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
			$arrcode = array();
			foreach($arrkey as $key)
			{
				$arr[] = "title like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrcode[] = "code like '%".$key."%'";
			}
			$where .= " AND ((". implode(" AND ",$arr). ") OR (". implode(" AND ",$arrcode). "))";
			//$where .= " AND ( title like '%".$keyword."%' OR summary like '%".$keyword."%' OR description like '%".$keyword."%')";
		}
		
		$where .= " Order by position, statusdate DESC";
		$rows = $this->model_core_media->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"showsanpham");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		$this->data['medias'] = array();
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['medias'][$i] = $rows[$i];
			$user = $this->model_core_user->getItem($this->data['medias'][$i]['userid']);
			$this->data['medias'][$i]['fullname'] =$user['fullname'];
			$arr = $this->string->referSiteMapToArray($this->data['medias'][$i]['refersitemap']);
			$sitemapid = $arr[0];
			$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
			
				$this->data['medias'][$i]['imagepreview'] = "<img src='".HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100)."' >";
				
			
			$this->data['medias'][$i]['saleprice'] = json_decode($this->data['medias'][$i]['saleprice']);
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->getTonKho($mediaid);
			$data_child = $this->model_core_media->getListByParent($mediaid);
			foreach($data_child as $key =>$child)
			{
				$data_child[$key]['imagepreview'] = "<img src='".HelperImage::resizePNG($child['imagepath'], 100, 100)."' >";
				$data_child[$key]['saleprice'] = json_decode($child['saleprice']);
				$data_child[$key]['tonkho'] = $this->model_core_media->getTonKho($child['mediaid']);
				$data_child[$key]['link_edit'] = $this->url->http('module/product/update&sitemapid='.$sitemap['sitemapid'].'&mediaid='.$child['mediaid'].$parapage);
				$data_child[$key]['text_edit'] = "Edit";
			}
			$this->data['medias'][$i]['child'] = $data_child;
			$parapage = "";
			if($page)
				$parapage = "&page=".$page;
			if($page)
				
			$this->data['medias'][$i]['link_edit'] = $this->url->http('module/product/update&sitemapid='.$sitemap['sitemapid'].'&mediaid='.$this->data['medias'][$i]['mediaid'].$parapage);
			$this->data['medias'][$i]['text_edit'] = "Edit";
			
			$this->data['medias'][$i]['link_addchild'] = $this->url->http('module/product/insert&sitemapid='.$sitemap['sitemapid'].'&mediaparent='.$this->data['medias'][$i]['mediaid'].$parapage);
			$this->data['medias'][$i]['text_addchild'] = "Thêm qui cách";	
			
			$this->data['medias'][$i]['type'] = $sitemap['moduleid'];
			$this->data['medias'][$i]['typename'] = $this->model_core_sitemap->getModuleName($sitemap['moduleid']);
			
			
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="module/product_list.tpl";
		
		
		$this->render();
	}
	
	public function insert()
	{
		$this->data['output'] = $this->loadModule('core/postcontent');
		$this->id='content';
		$this->template='common/output.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	
	public function update()
	{
		$this->data['output'] = $this->loadModule('core/postcontent');
		$this->id='content';
		$this->template='common/output.tpl';
		$this->layout='layout/center';
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
				
				$link = "<a href='?route=module/product&sitemapid=".$item['sitemapid']."'>".$item['sitemapname']."</a> ";
				if($this->user->checkPermission("module/product/addcat")==true)
					$link .= "<a class='addcat' cparent='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/add.png' width='19px'></a>";
				if($this->user->checkPermission("module/product/editcat")==true)
					$link .= "<a class='editcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/edit.png' width='19px'></a>";
				if(count($childs) == 0)
				{
					if($this->user->checkPermission("module/product/delcat")==true)
						$link .= "<a class='delcat' sitemapid='".$item['sitemapid']."'><img src='".DIR_IMAGE."icon/del.png' width='19px'></a>";
				}
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
	
	public function addcat()
	{
		$this->data['item']['sitemapparent'] = $this->request->get['parent'];
		
		$this->id='content';
		$this->template='module/product_cat_form.tpl';
		$this->render();
	}
	
	public function editcat()
	{
		$siteid = $this->user->getSiteId();
		$sitemapid = $this->request->get['sitemapid'];
		$this->data['item'] = $this->model_core_sitemap->getItem($sitemapid, $siteid);
		$this->id='content';
		$this->template='module/product_cat_form.tpl';
		$this->render();
	}
	
	public function delcat()
	{
		$id = $this->request->get['id'];
		$this->model_core_sitemap->deleteSitemap($id, $this->user->getSiteId());	
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function addToList()
	{
		$mediaid = $this->request->get['mediaid'];
		$media = $this->model_core_media->getItem($mediaid);
		$media['imagepreview'] =HelperImage::resizePNG($media['imagepath'], 100, 100);
		$media['qty'] = 1;
		if(!isset($_SESSION['productlist']))
		{
			$_SESSION['productlist'] = array();
		}
		if(!isset($_SESSION['productlist'][$mediaid]))
		{
			$_SESSION['productlist'][$mediaid]=$media;
		}
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function updateQty()
	{
		$mediaid = $this->request->get['mediaid'];
		$qty = $this->request->get['qty'];
		$_SESSION['productlist'][$mediaid]['qty'] = $qty;
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function removeListItem()
	{
		$mediaid = $this->request->get['mediaid'];
		unset($_SESSION['productlist'][$mediaid]);
		
		$this->data['output'] = "true";
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
		
	}
	public function listProductSelected()
	{
		$this->data['medias'] = $_SESSION['productlist'];
		$this->id='content';
		$this->template='module/product_selected.tpl';
		$this->render();
	}
}
?>