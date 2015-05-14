<?php
class ControllerSalesSale extends Controller
{
	private $error = array();
	function __construct()
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
			
		$this->load->model("sales/shop");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("core/media");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->helper('image');
		
		$where = " ORDER BY shopname";
		$this->data['data_shop'] = $this->model_sales_shop->getList($where);
		
	}
	public function index()
	{
		$nhanvien = $this->user->getNhanVien();
		$staffshop = $this->model_sales_shop->getShopStaff($nhanvien['id']);
		$this->data['shopid'] = $staffshop['shopid'];
		$this->id='content';
		$this->template="sales/sale.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function listOrder()
	{
		$shopid = $this->request->get['shopid'];
		$where = " AND shopid = '".$shopid."' AND `loaiphieu` = 'CH-BH'";
		$data = $this->model_quanlykho_phieunhapxuat->getList($where);
		
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
		
	}
	public function getOrder()
	{
		$id = $this->request->get['id'];
		$data = $this->model_quanlykho_phieunhapxuat->getItem($id);
		$data['ngaylap'] = $this->date->formatMySQLDate($data['ngaylap']);
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function listProduct()
	{
		$shopid = $this->request->get['shopid'];
		//Lay cac san pham co nhap cho shop
		$where = " AND shopid = '".$shopid."' Group by mediaid ";
		$data_nhapxuatmedia = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
		$arr_mediaid = $this->string->matrixToArray($data_nhapxuatmedia,'mediaid');
		$where = " AND mediatype = 'module/product' AND mediaid in ('".implode("','",$arr_mediaid)."')";
		$this->data['data_product'] = $this->model_core_media->getList($where);
		foreach($this->data['data_product'] as $i => $media)
		{
			$this->data['data_product'][$i]['icon'] = HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100);		
		}

		$this->id='content';
		$this->template="sales/sale_product.tpl";
		$this->render();	
	}
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			$nhanvien = $this->user->getNhanVien();
			$data['ngaylap'] = $this->date->formatViewDate($data['ngaylap']);
			$data['ngaythanhtoan'] = $this->date->formatViewDate($data['ngaythanhtoan']);
			if($data['nguoithuchien']=="")
			{
				$data['nguoithuchienid'] = $nhanvien['id'];
				$data['nguoithuchien'] = $nhanvien['hoten'];
			}
			//$data['loaiphieu'] = $this->loaiphieu;
			$data['id'] = $this->model_quanlykho_phieunhapxuat->save($data);
			$phieu = $this->model_quanlykho_phieunhapxuat->getItem($data['id']);
			
			//Xoa dinh luong
			$delnhapkho = $data['delnhapkho'];
			if($delnhapkho)
			{
				@$arr_nhapkhoid = split(",",$delnhapkho);
				if(count($arr_nhapkhoid))
				{
					
					foreach($arr_nhapkhoid as $nhapkhoid)
					{
						$phieu = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMedia($nhapkhoid);
						$this->model_quanlykho_phieunhapxuat->deletePhieuNhapXuatMedia($nhapkhoid);
						
						$mediaid = $phieu['mediaid'];
						//Cap nhat ton kho
						$inventory = $this->model_core_media->getInventory($mediaid);
						$this->model_core_media->updateCol($mediaid,'inventory',$inventory);
					}
					
				}
			}
			//Save chi tiet phieu nhap
			$tongtien = 0;
			$nhapkhoid = $data['nhapkhoid'];
			$phieuid = $data['id'];
			$arr_mediaid = $data['mediaid'];
			$arr_code = $data['code'];
			$arr_title = $data['title'];
			$arr_soluong = $data['soluong'];
			$arr_madonvi = $data['dlmadonvi'];
			$arr_giatien = $data['giatien'];
			$arr_giamgia = $data['giamgia'];
			$arr_phantramgiamgia = $data['phantramgiamgia'];
			$index = 0;
			foreach($arr_mediaid as $i => $mediaid)
			{
				$dl['id'] = $nhapkhoid[$i];
				$dl['phieuid'] = $phieuid;
				$dl['mediaid'] = $mediaid;
				$dl['code'] = $arr_code[$i];
				$dl['title'] = $arr_title[$i];
				$dl['soluong'] = $arr_soluong[$i];
				$dl['madonvi'] = $arr_madonvi[$i];
				$dl['giatien'] = $arr_giatien[$i];
				$dl['giamgia'] = $arr_giamgia[$i];
				$dl['phantramgiamgia'] = $arr_phantramgiamgia[$i];
				$dl['loaiphieu'] = $phieu['loaiphieu'];
				
				$dl['maphieu'] = $phieu['maphieu'];
				$dl['ngaylap'] = $phieu['ngaylap'];
				$dl['nguoilap'] = $phieu['nguoilap'];
				$dl['nhacungcapid'] = $phieu['nhacungcapid'];
				$dl['tennhacungcap'] = $phieu['tennhacungcap'];
				$dl['khachhangid'] = $phieu['khachhangid'];
				$dl['tenkhachhang'] = $phieu['tenkhachhang'];
				$dl['shopid'] = $phieu['shopid'];
				$dl['nguoigiao'] = $phieu['nguoigiao'];
				$dl['nguoinhanid'] = $phieu['nguoinhanid'];
				$dl['nguoinhan'] = $phieu['nguoinhan'];
				$dl['vitri'] = $index;
				$this->model_quanlykho_phieunhapxuat->savePhieuNhapXuatMedia($dl);
				$tongtien += $this->string->toNumber($dl['soluong'])*$this->string->toNumber($dl['giatien']);
				$index++;
				//Cap nhat ton kho
				$inventory = $this->model_core_media->getInventory($mediaid);
				$this->model_core_media->updateCol($mediaid,'inventory',$inventory);
				
			}
			//$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'tongtien',$tongtien);
			//$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'congno',$tongtien- $this->string->toNumber($data['thanhtoan']));
			$phieu['error'] ='';
			$this->data['output'] = json_encode($phieu);
			if(isset($_SESSION['productlist']))
			{
				unset($_SESSION['productlist']);	
			}
		}
		else
		{
			$phieu['error'] ='';
			foreach($this->error as $item)
			{
				$phieu['error'] .= $item."<br>";
			}
			$this->data['output'] = json_encode($phieu);
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}
?>