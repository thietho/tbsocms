<?php
class ModelAddonService extends ModelCoreFile 
{ 
	private $arr_col = array(
							'id',
							'servicename',
							'servicetype',
							'startday',
							'customerid',
							'customername',
							'status',
							
							);
	public function getItem($mediaid, $where="")
	{
		$query = $this->db->query("Select `media`.* 
									from `media` 
									where mediaid ='".$mediaid."' ".$where);
		return $query->row;
	}
	
	
	
	public function getList($where="", $from=0, $to=0)
	{
		
		$sql = "Select `media`.* 
									from `media` 
									where status not like 'delete' AND temp not like 'temp'  " . $where ;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		//echo $sql;
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function updateCol($mediaid,$col,$val)
	{
		$mediaid = $mediaid;
		$col = $col;
		$val = $val;
		
		
		$field=array(
						$col
					);
		$value=array(
						$val
					);
		
		$where="mediaid = '".$mediaid."'";
		$this->db->updateData('media',$field,$value,$where);
	}
	
	public function save($data)
	{
		$media = $this->getItem($data['mediaid']);
		
		$date = getdate();
		if($data['mediaid'] == "")
				$data['mediaid'] = $this->nextID($date['year'].$this->date->numberFormate($date['mon']));
		$data['price']=$this->db->escape(@$this->string->toNumber($data['price']));
		$data['discountpercent']=$this->db->escape(@$this->string->toNumber($data['discountpercent']));
		$data['pricepromotion']=$this->db->escape(@$this->string->toNumber($data['pricepromotion']));
		$data['updateddate'] = $this->date->getToday();
		
		$value = array();
		if(count($media))
		{
			foreach($media as $col => $val)
			{
				if(isset($data[$col]))
					$media[$col] = $data[$col];
			}
			$data = $media;
		}
		else
		{
			$data['statusby']=$this->db->escape(@$data['userid']);
			$data['status']="active";
			$data['statusdate'] = $this->date->getToday();
		}
		
		foreach($this->arr_col as $col)
		{
			$value[] = $this->db->escape(@$data[$col]);
		}
		

		$field=$this->arr_col;
		
		if(count($media) == 0)
		{
			$data['id'] = $this->db->insertData("media",$field,$value);
		}
		else
		{
			$where="mediaid = '".$data['mediaid']."'";
			$this->db->updateData("media",$field,$value,$where);
		}
		return $data['id'];
	}
	
	
}
?>