<?php
class ControllerThongkeCongno extends Controller
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
		$this->load->model("core/user");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("addon/thuchi");
	}
	public function index()
	{
		$this->data['users'] = array();
		$rows = $this->model_core_user->getList(" Order by fullname");
		
		foreach($rows as $i => $row)
		{
			
			$arr = array($row['id']);
			$congno = $this->loadModule("core/member","getCongNo",$arr);
			if($congno!="0")
			{
				$this->data['users'][$i] = $row;
				$this->data['users'][$i]['congno'] = $congno;
			}
		}
		
		
		$this->id='content';
		$this->template="thongke/congno.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	
	
	
}
?>