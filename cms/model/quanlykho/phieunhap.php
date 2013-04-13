<?php
class ModelQuanlykhoPhieunhap extends Model
{
	private $arr_col = array(
							'id',
							'maphieu',
							'ngaynhap',
							'nhapboi',
							'nhacungcapid',
							'tennhacungcap',
							'nguoigiao',
							'nguoinhan',
							'hinhthucthanhtoan',
							'tongtien',
							'datra',
							'nolai'
							);
	public function getItem($id, $where="")
	{
		$sql = "Select `qlkphieunhap`.*
									from `qlkphieunhap` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}

	public function getList($where="", $from=0, $to=0,$order="")
	{

		$sql = "Select `qlkphieunhap`.*
									from `qlkphieunhap` 
									where 1=1 " . $where;
		if($order=="")
		{
			$order = " Order by tennhacungcap";
			
		}
		$sql.=$order;
		if($to > 0)
		{
			$sql .= " Limit ".$from.",".$to;
		}
		
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function save($data)
	{
		$id=(int)@$data['id'];
		$maphieu=$this->db->escape(@$data['maphieu']);
		$ngaynhap=$this->db->escape(@$data['ngaynhap']);
		$nhapboi=$this->db->escape(@$data['nhapboi']);
		$nhacungcapid=$this->db->escape(@$data['nhacungcapid']);
		$nguoigiao=$this->db->escape(@$data['nguoigiao']);
		$nguoinhan=$this->db->escape(@$data['nguoinhan']);
		$hinhthucthanhtoan=$this->db->escape(@$data['hinhthucthanhtoan']);
		$tongtien=$this->string->toNumber($this->db->escape(@$data['tongtien']));
		$datra=$this->string->toNumber($this->db->escape(@$data['datra']));
		$nolai=$this->string->toNumber($this->db->escape(@$data['nolai']));
		$trangthai = "active";
		$field=array(
							
						'maphieu',
						'ngaynhap',
						'nhapboi',
						'nhacungcapid',
						'tennhacungcap',
						'nguoigiao',
						'nguoinhan',
						'hinhthucthanhtoan',
						'tongtien',
						'datra',
						'nolai',
						'trangthai'
					);
		$value=array(
						
						$maphieu,
						$ngaynhap,
						$nhapboi,
						$nhacungcapid,
						$tennhacungcap,
						$nguoigiao,
						$nguoinhan,
						$hinhthucthanhtoan,
						$tongtien,
						$datra,
						$nolai,
						$trangthai
						);
		if((int)$data['id'] == 0)
		{
			$data['id'] = $this->db->insertData("qlkphieunhap",$field,$value);
		}
		else
		{
			$where="id = '".$data['id']."'";
			$this->db->updateData("qlkphieunhap",$field,$value,$where);
		}
		return $data['id'];
	}
	
	public function delete($id)
	{
		$field = array('trangthai');
		$value = array('deleted');
		
		$where="id = '".$data['id']."'";
		$this->db->updateData("qlkphieunhap",$field,$value,$where);
		$where="phieunhapid = '".$id."'";
		$this->db->updateData("qlkphieunhap",$field,$value,$where);
	}
	
	public function destroy($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhap",$where);
		$where="phieunhapid = '".$id."'";
		$this->db->deleteData("qlkphieunhap_nguyenlieu",$where);
	}
	//Chi tiet phieu nhap
	public function getPhieuNhapNguyenLieu($id)
	{
		$sql = "Select `qlkphieunhap_nguyenlieu`.*
									from `qlkphieunhap_nguyenlieu` 
									where id ='".$id."' ".$where;
		$query = $this->db->query($sql);
		return $query->row;
	}
	public function getPhieuNhapNguyenLieuList($where)
	{
		$sql = "Select `qlkphieunhap_nguyenlieu`.*
									from `qlkphieunhap_nguyenlieu` 
									where 1=1 " . $where;
		
		$query = $this->db->query($sql);
		return $query->rows;
	}
	public function savePhieuNhapNguyenLieu($data)
	{
		
		$id=(int)@$data['id'];
		$phieunhapid=$this->db->escape(@$data['phieunhapid']);
		$nguyenlieuid=$this->db->escape(@$data['nguyenlieuid']);
		$manguyenlieu=$this->db->escape(@$data['manguyenlieu']);
		$tennguyenlieu=$this->db->escape(@$data['tennguyenlieu']);
		$soluong=$this->string->toNumber($this->db->escape(@$data['soluong']));
		$giatien=$this->string->toNumber($this->db->escape(@$data['giatien']));
		$trangthai = "active";
		$field=array(
					 	
						'phieunhapid',
						'nguyenlieuid',
						'soluong',
						'madonvi'
						);
		$value=array(
						
						$phieunhapid,
						$nguyenlieuid,
						$soluong,
						$madonvi
						);

		if((int)@$data['id'] == 0 )
		{
				
			$this->db->insertData("qlkphieunhap_nguyenlieu",$field,$value);
				
		}
		else
		{
			$where="id = '".$id."'";
			$this->db->updateData("qlkphieunhap_nguyenlieu",$field,$value,$where);
		}
		return $id;
	}
	public function deletePhieuNhapNguyenLieu($id)
	{
		$where="id = '".$id."'";
		$this->db->deleteData("qlkphieunhap_nguyenlieu",$where);
	}
}