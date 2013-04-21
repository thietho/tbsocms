<?php
class ControllerThongkeBanhang extends Controller
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
		
		$this->id='content';
		$this->template="thongke/banhang.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$data = $this->request->post;
		$tungay = $this->date->formatViewDate($data['tungay']);
		$denngay = $this->date->formatViewDate($data['denngay']);
		$where = "";
		if($tungay != "")
		{
			$where .= " AND ";
		}
		$this->id='content';
		$this->template="thongke/banhang_thongke.tpl";
		
		$this->render();
	}
	
}
?>