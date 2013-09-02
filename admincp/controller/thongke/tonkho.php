<?php
class ControllerThongkeTonkho extends Controller
{
	private $error = array();
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
	}
	public function index()
	{
		$this->thongke();
		$this->id='content';
		$this->template="thongke/tonkho.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$siteid = $this->user->getSiteId();
		$sitemaps = $this->model_core_sitemap->getListByModule("module/product", $siteid);
		
		$arrsitemapid = $this->string->matrixToArray($sitemaps,"sitemapid");
		$arr = array();
		$where = " AND mediaparent = '' AND mediatype = 'module/product' ";
		
		foreach($arrsitemapid as $sitemapid)
		{
			$arr[] = " refersitemap like '%[".$sitemapid."]%'";
		}
		if(count($arr))
			$where .= "AND (". implode($arr," OR ").")";
		$where .= " Order by title";
		$rows = $this->model_core_media->getList($where);
		for($i=0;$i<count($rows);$i++)
		{
			$this->data['medias'][$i] = $rows[$i];
			
			$this->data['medias'][$i]['fullname'] =$user['fullname'];
			$arr = $this->string->referSiteMapToArray($this->data['medias'][$i]['refersitemap']);
			$sitemapid = $arr[0];
			$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->user->getSiteId());
			
			$mediaid = $this->data['medias'][$i]['mediaid'];
			$this->data['medias'][$i]['tonkho'] = $this->model_core_media->getTonKho($mediaid);
			$data_child = $this->model_core_media->getListByParent($mediaid);
			foreach($data_child as $key =>$child)
			{
				
				
				$data_child[$key]['tonkho'] = $this->model_core_media->getTonKho($child['mediaid']);
				
			}
			$this->data['medias'][$i]['child'] = $data_child;
		}
	}
	
}
?>