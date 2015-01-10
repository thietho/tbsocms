<?php
class ControllerCoreDb extends Controller
{
	function __construct() 
	{
		$this->load->model("core/db");
   	}
	public function index()
	{
		
		$this->data['output'] = "test";
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();	
	}
	public function select()
	{
		$sql = base64_decode($_POST['sql']);
		//$sql = "SELECT * FROM `sitemap`";
		$data = $this->model_core_db->select($sql);
		$this->data['output'] = json_encode($data);
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	public function insertData()
	{
		$table = $_POST['table'];
		$field = $_POST['field'];
		$value = $_POST['value'];
		$this->data['output'] = $this->db->insertData($table,$field,$value);
		
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	public function updateData()
	{
		$table = $_POST['table'];
		$field = $_POST['field'];
		$value = $_POST['value'];
		$where = base64_decode($_POST['where']);
		$this->data['output'] = $this->db->updateData($table,$field,$value,$where);
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	public function deleteData()
	{
		$table = $_POST['table'];
		$where = base64_decode($_POST['where']);
		$this->data['output'] = $this->db->deleteData($table,$where);
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
}
?>