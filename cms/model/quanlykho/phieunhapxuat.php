<?php
class ModelQuanlykhoPhieunhapxuat extends Model
{
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkphieunhapxuat`.*
									from `qlkphieunhapxuat` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlkphieunhapxuat`.*
									from `qlkphieunhapxuat` 
									where trangthai <> 'deleted' " . $where;
		if($order=="")
		{
			$order = " Order by id DESC";
			
		}
		$sql.=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	
	private function createMaPhieu($prefix="")
	{
		return $this->db->getNextIdVarChar('qlkphieunhapxuat','maphieu',$prefix);
	}
	
	public function save($data)
	{
		$id=(int)@$data['id'];
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$maphieu=$this->createMaPhieu($loaiphieu.$this->date->now['year'].$this->date->numberFormate($this->date->now['mon']));
		$nguoilap=$this->user->getUserName();
		$ngaylap=$this->date->getToday();
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		$nguoithuchien=$this->db->escape(@$data['nguoithuchien']);
		$nhacungcapid=$this->db->escape(@$data['nhacungcapid']);
		$tennhacungcap=$this->db->escape(@$data['tennhacungcap']);
		$nguoigiao=$this->db->escape(@$data['nguoigiao']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		$tongtien=$this->string->toNumber($this->db->escape(@$data['tongtien']));
		$ghichu=$this->db->escape(@$data['ghichu']);
		$trangthai = "active";
		$field=array(
							
						
						'nguoilap',
						'ngaylap',
						'loaiphieu',
						'nguoithuchien',
						'nhacungcapid',
						'tennhacungcap',
						'nguoigiao',
						'nguoinhan',
						'tongtien',
						'ghichu',
						'trangthai'
					);
		$value=array(
						
						
						$nguoilap,
						$ngaylap,
						$loaiphieu,
						$nguoithuchien,
						$nhacungcapid,
						$tennhacungcap,
						$nguoigiao,
						$nguoinhan,
						$tongtien,
						$ghichu,
						$trangthai
						);
		if((int)$data['id'] == 0)
		{
			$data['id'] = $this->db->insertData("qlkphieunhapxuat",$field,$value);
			$this->updateCol($data['id'],'maphieu',$maphieu);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		}
		return $data['id'];
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
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	public function delete($id)
	{
		$field = array('trangthai');
		$value = array('deleted');
		
		$where="id = '".$data['id']."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
		$where="phieuid = '".$id."'";
		$this->db->updateData("qlkphieunhapxuat",$field,$value,$where);
	}
	
	public function destroy($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat",$where);
		$where="phieuid = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat_nguyenlieu",$where);
	}
	//Chi tiet phieu nhap
	public function getPhieuNhapXuatNguyenLieu($id)
	{
		$sql = "Select `qlkphieunhapxuat_nguyenlieu`.*
									from `qlkphieunhapxuat_nguyenlieu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getPhieuNhapXuatNguyenLieuList($where)
	{
		$sql = "Select `qlkphieunhapxuat_nguyenlieu`.*
									from `qlkphieunhapxuat_nguyenlieu` 
									where trangthai <> 'deleted' " . $where;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function savePhieuNhapXuatNguyenLieu($data)
	{
		
		$id=(int)@$data['id'];
		$phieuid=$this->db->escape(@$data['phieuid']);
		$nguyenlieuid=$this->db->escape(@$data['nguyenlieuid']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$madonvi=$this->db->escape(@$data['madonvi']);
		$giatien=$this->string->toNumber($this->db->escape(@$data['giatien']));
		$thanhtien=$soluong*$giatien;
		$trangthai = "active";
		$loaiphieu=$this->db->escape(@$data['loaiphieu']);
		
		$field=array(
						'phieuid',
						'nguyenlieuid',
						'manguyenlieu',
						'tennguyenlieu',
						'soluong',
						'madonvi',
						'giatien',
						'thanhtien',
						'trangthai',
						'loaiphieu'
						);
		$value=array(
						$phieuid,
						$nguyenlieuid,
						$manguyenlieu,
						$tennguyenlieu,
						$soluong,
						$madonvi,
						$giatien,
						$thanhtien,
						$trangthai,
						$loaiphieu
						);

		if((int)@$data['id'] == 0 )
		{
				
			$this->db->insertData("qlkphieunhapxuat_nguyenlieu",$field,$value);
				
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkphieunhapxuat_nguyenlieu",$field,$value,$where);
		}
		return $id;
	}
	public function deletePhieuNhapXuatNguyenLieu($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhapxuat_nguyenlieu",$where);
	}
}