<?php
class ModelQuanlykhoHoahong extends Model
{ 
	private $arr_col = array(
							'memberid',
							'ngaytinhhoahong',
							'cachtinh',
							'ghichu'
							);
	public function getItem($id)
	{
		$query = @$this->db->query("Select `qlkhoahong`.* 
									from `qlkhoahong` 
									where id ='".$id."' ");
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `qlkhoahong`.* 
									from `qlkhoahong` 
									where 1=1 " . $where ;
		if(@$to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = @$this->db->query($sql);
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
		@$this->db->updateData('qlkhoahong',$field,$value,$where);
	}
	
	public function save($data)
	{
		$qlkhoahong = @$this->getItem($data['id']);
		
		$value = array();
		if(count($qlkhoahong))
		{
			foreach($qlkhoahong as $col => $val)
			{
				if(isset($data[$col]))
					$qlkhoahong[$col] = $data[$col];
			}
			$data = $qlkhoahong;
		}
		
		foreach(@$this->arr_col as $col)
		{
			$value[] = @$this->db->escape(@$data[$col]);
		}
		

		$field=@$this->arr_col;
		
		if(count($qlkhoahong) == 0)
		{
			$data['id'] = @$this->db->insertData("qlkhoahong",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			@$this->db->updateData("qlkhoahong",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$where="id = '".$id."'";
		@$this->db->deleteData("qlkhoahong",$where);
		
	}
	
}
?>