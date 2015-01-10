<?php
class ModelCoreDb extends Model
{ 
	public function select($sql)
	{
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function insertData($table,$field,$value)
	{
		return $this->db->insertData($table,$field,$value);
	}
	public function updateData($table,$field,$value,$where)
	{
		return $this->db->updateData($table,$field,$value,$where);
	}
	public function deleteData($table,$where)
	{
		return $this->db->deleteData($table,$where);
	}
}
?>