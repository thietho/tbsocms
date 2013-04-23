<?php
class ControllerThongkeThuchi extends Controller
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
		$this->template="thongke/thuchi.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("addon/thuchi");
		$data = $this->request->post;
		$tungay = $this->date->formatViewDate($data['tungay']);
		$denngay = $this->date->formatViewDate($data['denngay']);
		/*$where = " AND qlkphieunhapxuat.loaiphieu = 'PBH'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}*/
		//Thu
		//Thong ke phieu thu
		$where = " AND loaithuchi = 'thu'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_thu = $this->model_addon_thuchi->getList($where);
		print_r($data_thu);
		//Thong ke phieu ban hang
		//End thu
		//Chi
		//Thong ke phieu chi
		//Thong ke pheu nhap hang
		//End chi
		
		
		
			
			
		$this->id='content';
		$this->template="thongke/thuchi_thongke.tpl";
		
		$this->render();
		
	}
	
}
?>