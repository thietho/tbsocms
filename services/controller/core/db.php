<?php
class ControllerCoreDb extends Controller
{
	public function index()
	{
		
		$this->data['output'] = "test";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();	
	}
}
?>