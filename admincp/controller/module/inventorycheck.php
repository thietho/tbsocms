<?php
class ControllerModuleInventorycheck extends Controller
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
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("module/baogia");
		$this->load->model("core/user");
		$this->load->helper('image');
		$this->load->model("core/category");
		$this->load->model("sales/shop");
		
		$where = " ORDER BY shopname";
		$this->data['data_shop'] = $this->model_sales_shop->getList($where);
	}
	
	function index()
	{
		$this->id='content';
		$this->template='module/inventorycheck.tpl';
		$this->layout='layout/center';
		$this->render();
	}
}