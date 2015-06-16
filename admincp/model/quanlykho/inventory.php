<?php
class ModelModuleBaogia extends ModelCoreFile 
{ 
	private $arr_col = array(
							'datecheck',
							'nhanvienid',
							'note'
							);
	
	public function getItem($id)
	{
		$query = $this->db->query("Select `inventory`.* 
									from `inventory` 
									where id ='".$id."'");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `inventory`.* 
									from `inventory` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function save($data)
	{
		$obj = $this->getItem($data['id']);
		$value = array();
		if(count($obj))
		{
			foreach($obj as $col => $val)
			{
				if(isset($data[$col]))
					$obj[$col] = $data[$col];
			}
			$data = $obj;
		}
		
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($obj) == 0)
		{
			$data['id'] = $this->db->insertData("inventory",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("inventory",$field,$value,$where);
		}
		
		return $data;
	}
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("inventory",$where);
		$where="inventoryid = '".$id."'";
		$this->db->deleteData("inventory_media",$where);
	}
	//Detail
	private $arr_coldetail = array(
							
							'inventoryid',
							'mediaid',
							'quantity'
							);
	public function getInventoryDetail($id)
	{
		$query = $this->db->query("Select `inventory_media`.* 
									from `inventory_media` 
									where id ='".$id."'");
		return $query->row;
	}
	
	
	
	public function getInventoryDetailList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `inventory_media`.* 
									from `inventory_media` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveInventoryDetail($data)
	{
		$obj = $this->getInventoryDetail($data['id']);
		$value = array();
		if(count($obj))
		{
			foreach($obj as $col => $val)
			{
				if(isset($data[$col]))
					$obj[$col] = $data[$col];
			}
			$data = $obj;
		}
		
		
		foreach($this->arr_coldetail as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_coldetail;
		
		if(count($obj) == 0)
		{
			$data['id'] = $this->db->insertData("inventory_media",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("inventory_media",$field,$value,$where);
		}
		
		return $data['id'];
	}
	public function deleteInventoryDetail($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("inventory_media",$where);
	}
	
}
?>