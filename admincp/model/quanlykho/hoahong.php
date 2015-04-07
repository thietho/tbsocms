<?php
class ModelQuanlykhoHoahong extends Model
{ 
	private $arr_col = array(
							'memberid',
							'ngaytinhhoahong',
							'hoahong',
							'danhthu',
							'congno'
							);
	public function getItem($id)
	{
		$query = $this->db->query("Select `qlk_hoahong`.* 
									from `qlk_hoahong` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlk_hoahong`.* 
									from `qlk_hoahong` 
									where 1=1 " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function updateCol($id,$col,$val)
	{
		$id = $id;
		$col = $col;
		$val = $val;
		
		
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('qlk_hoahong',$field,$value,$where);
	}
	
	public function save($data)
	{
		$qlk_hoahong = $this->getItem($data['id']);
		
		$value = array();
		if(count($qlk_hoahong))
		{
			foreach($qlk_hoahong as $col => $val)
			{
				if(isset($data[$col]))
					$qlk_hoahong[$col] = $data[$col];
			}
			$data = $qlk_hoahong;
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($qlk_hoahong) == 0)
		{
			$data['id'] = $this->db->insertData("qlk_hoahong",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("qlk_hoahong",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlk_hoahong",$where);
		
	}
	
}
?>