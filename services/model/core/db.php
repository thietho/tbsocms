<?php
class ModelCoreDb extends Model
{ 
	public function getList($sql)
	{
		$query = $this->db->query($sql);
		return $query->rows;
	}
	pub
}
?>