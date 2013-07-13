<?php
class ModelSalesOrder extends Model 
{
	private $columns = array(
								'code',
								'sessionid',
								'customerid',
								'customername',
								'createby',
								'createtime',
								'status',
								'cashier',
								'paymenttime',
								'total',
								'payment',
								'remain',
								'discount',
								'discountpercent'
							);
	public function getList($where = "")
	{
		$sql = "Select `salesorder`.* from `salesorder` where 1=1 ".$where;
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getItem($id)
	{
		$sql = "Select * from `salesorder` where id = '".$id."'";
		$query = $this->db->query($sql);
		return $query->row;
	}
	
	private function creatCode($prefix)
	{
		$mun = $this->db->getNextIdVarCharNumber('salesorder','code',$prefix);
		return $mun.$prefix;
	}
	
	public function insert($data)
	{
		$curtime = $this->date->getToday();
		
		$data['code'] = $this->creatCode($this->date->getYear($curtime).$this->date->getMonth($curtime).$this->date->getDay($curtime));
		$data['createtime'] = $curtime;
		$nhanvien = $this->user->getNhanVien();
		$data['createby'] = $nhanvien['id'];
		foreach($this->columns as $val)
		{			
			$field[] = $val;
			$value[] = $this->db->escape($data[$val]);	
		}
		
		$getLastId = $this->db->insertData("salesorder",$field,$value);
		return $getLastId;
	}
	
	
	public function update($data)
	{	
		$data['createtime']=$this->db->escape(@$this->date->formatViewDate($data['createtime']));
		$data['paymenttime']=$this->db->escape(@$this->date->formatViewDate($data['paymenttime']));
		foreach($this->columns as $val)
		{
	
			if(isset($data[$val]))
			{
				$field[] = $val;
				$value[] = $this->db->escape($data[$val]);	
			}
		}
					
		$where="id = '".$data['id']."'";
		$this->db->updateData("salesorder",$field,$value,$where);
	}	
		
	public function updateCol($id,$col,$val)
	{
		$id=$this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		$field=array(
						$col
					);
		$value=array(
						$val
					);
					
		$where="id = '".$id."'";
		$this->db->updateData("salesorder",$field,$value,$where);
	}
	
	//Xóa phieu
	public function delete($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData('salesorder',$where);
		$where="salesorderid = '".$id."'";
		$this->db->updateData('salesorder_chitiet',$field,$value,$where);
		
	}
	//chi tiet phieu
	public function getOrderDetail($id)
	{
		$sql = "Select * 
						from `salesorder_chitiet` 
						where id ='".$id."'";
		$query = $this->db->query($sql);
		return $query->row;	
	}
	
	public function getOrderDetailList($where)
	{
		$sql = "Select `salesorder_chitiet`.* 
									from `salesorder_chitiet` 
									where 1=1 " . $where ;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	public function saveOrderDetail($data)
	{
		$obj = array();
		
		$obj['orderid'] = $this->db->escape(@$data['orderid']);
		$obj['mediaid'] = $this->db->escape(@$data['mediaid']);
		$obj['code'] = $this->db->escape(@$data['code']);
		$obj['title'] = $this->db->escape(@$data['title']);
		$obj['unit'] = $this->db->escape(@$data['unit']);
		$obj['quantity']=$this->db->escape(@$this->string->toNumber($data['quantity']));
		$obj['price']=$this->db->escape(@$this->string->toNumber($data['price']));
		$obj['subtotal']=$this->db->escape(@$this->string->toNumber($data['subtotal']));
		
		foreach($data as $key => $val)
		{
			if(isset($val))
			{
				$field[] = $key;
				$value[] = $this->db->escape($val);	
			}
		}		
		
		if((int)$data['id']==0)
		{
			
			$this->db->insertData("salesorder_chitiet",$field,$value);
			$id = $this->db->getLastId();
		}
		else
		{			
			$where="id = '".$data['id']."'";
			$this->db->updateData('salesorder_chitiet',$field,$value,$where);
		}
		return $id;
	}
	
	public function updateOrderDetail($id,$col,$val)
	{
		$id = $this->db->escape(@$id);
		$col=$this->db->escape(@$col);
		$val=$this->db->escape(@$val);
		
		$field=array(
						$col
						
					);
		$value=array(
						$val
					);
		
		$where="id = '".$id."'";
		$this->db->updateData('salesorder_chitiet',$field,$value,$where);
	}
		
	public function deleteOrderDetail($id)
	{
		$id = $this->db->escape(@$id);		
		$where="id = '".$id."'";
		$this->db->deleteData('salesorder_chitiet',$where);
	}
}
?>