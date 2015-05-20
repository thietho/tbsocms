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
		
		$this->data['loaiphieu'] = array(
											'NK-CH' => 'Trả hàng về kho',
											'CH-BH' => 'Phiếu bán hàng'
										);
		
		$this->load->model("sales/shop");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("core/media");
		$this->load->model("core/category");
		$this->load->model("core/sitemap");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->helper('image');
		
		$where = " ORDER BY shopname";
		$this->data['data_shop'] = $this->model_sales_shop->getList($where);
		
		$this->data['nhanhieu'] = array();
		$this->model_core_category->getTree("nhanhieu",$this->data['nhanhieu']);
		unset($this->data['nhanhieu'][0]);
		
		$this->data['status'] = array();
		$this->model_core_category->getTree("status",$this->data['status']);
		unset($this->data['status'][0]);
		
		$this->data['sitemaps'] = array();
		$this->model_core_sitemap->getTreeSitemap("", $this->data['sitemaps']);
		
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
		$where = " AND shopid = '".$shopid."' AND `loaiphieu` = 'CH-BH' AND trangthai = 'new'";
		$data = $this->model_quanlykho_phieunhapxuat->getList($where);
		
		$this->data['output'] = json_encode($data);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
		
	}
	public function listOrderComplete()
	{
		$shopid = $this->request->get['shopid'];
		$where = " AND shopid = '".$shopid."' AND `loaiphieu` = 'CH-BH' AND trangthai = 'delivered'";
		$this->data['data_order'] = $this->model_quanlykho_phieunhapxuat->getList($where);
		
		
		$this->id='content';
		$this->template='sales/sale_order.tpl';
		$this->render();
		
	}
	public function delOrder() 
	{
		$id=$this->request->get['id'];
		$this->model_quanlykho_phieunhapxuat->destroy($id);
		$this->data['output'] = "Xóa thành công";
		
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	public function getOrder()
	{
		$id = $this->request->get['id'];
		$data = $this->model_quanlykho_phieunhapxuat->getItem($id);
		$data['ngaylap'] = $this->date->formatMySQLDate($data['ngaylap']);
		//Lap chi tiet
		$where = " AND phieuid = '".$id."' ORDER BY `vitri` ASC";
		$data['detail'] = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
		
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
		$sitemapid = urldecode($this->request->get['sitemapid']);
		$this->data['sitemapid'] = $sitemapid;
		$siteid = $this->user->getSiteId();
		if($sitemapid != "")
		{
			$data = array();
			$sitemaps = $this->model_core_sitemap->getTreeSitemap($sitemapid,$data,$siteid);
			$arrsitemapid = $this->string->matrixToArray($data,"sitemapid");
		}
		$arr = array();
		if($sitemapid)
			foreach($arrsitemapid as $sitemapid)
			{
				$arr[] = " refersitemap like '%[".$sitemapid."]%'";
			}
		if(count($arr))
			$where .= "AND (". implode($arr," OR ").")";
		
		$keyword = urldecode($this->request->get['keyword']);
		@$arrkey = split(' ', $keyword);
		
		if($keyword !="")
		{
			$arr = array();
			$arrcode = array();
			$arrbarcode = array();
			$arrref = array();
			$arrcolor = array();
			$arrsizes = array();
			$arrmaterial = array();
			foreach($arrkey as $key)
			{
				$arr[] = "title like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrcode[] = "code like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrbarcode[] = "barcode like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrref[] = "ref like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrref[] = "ref like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrcolor[] = "color like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrsizes[] = "sizes like '%".$key."%'";
			}
			foreach($arrkey as $key)
			{
				$arrmaterial[] = "material like '%".$key."%'";
			}
			$where .= " AND ((". implode(" AND ",$arr). ") 
									OR (". implode(" AND ",$arrcode). ") 
									OR (". implode(" AND ",$arrbarcode). ") 
									OR (". implode(" AND ",$arrref). ") 
									OR (". implode(" AND ",$arrcolor). ") 
									OR (". implode(" AND ",$arrsizes). ") 
									OR (". implode(" AND ",$arrmaterial). ") 
							)";
			
		}
		$brand = urldecode($this->request->get['brand']);
		if($brand !="")
		{
			$where .= " AND brand like '".$brand."'";
		}
		
		$data_product = $this->model_core_media->getList($where);
		$arr_brand = array();
		$this->data['data_product'] = array();
		foreach($data_product as $i => $media)
		{
			$media['Inventory'] = $this->model_core_media->getShopInventory($shopid,$media['mediaid']);
			$media['icon'] = HelperImage::resizePNG($this->data['medias'][$i]['imagepath'], 100, 100);		
			/*if(!in_array($media['brand'],$arr_brand))
				$arr_brand[]=$media['brand'];*/
			$this->data['data_product'][$media['brand']][]=$media;
		}
		
		$cat = array(
					'categoryid'=>'',
					'categoryname' => 'Chưa có nhãn hiệu'
					);
		$this->data['nhanhieu'][] = $cat;
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
						
						$this->model_quanlykho_phieunhapxuat->deletePhieuNhapXuatMedia($nhapkhoid);
						
						
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
		if($data['congno']!=0 && $data['trangthai'] == 'delivered')
		{
			$this->error['trangthai'] = 'Đơn hàng chưa thanh toán!';
		}
		if (count($this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	public function history()
	{
		$shopid = $this->request->get['shopid'];
		$mediaid = $this->request->get['mediaid'];
		//Nhap
		$where = " AND shopid = '".$shopid."' AND mediaid = '".$mediaid."' AND loaiphieu = 'PX-XCH' ORDER BY `ngaylap` DESC";
		$data_nhap = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
		//Xuat
		
		$where = " AND shopid = '".$shopid."' AND mediaid = '".$mediaid."' AND loaiphieu in ('CH-BH','NK-CH') ORDER BY `ngaylap` DESC";
		$data_xuat = $this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
		
		
		$arrdate = array();
		foreach($data_nhap as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		foreach($data_xuat as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		
		sort($arrdate);
		foreach($arrdate as $date)
		{
			foreach($data_nhap as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$this->data['nhapxuat'][$date]['nhap'][] = $item;
				}
			}
			foreach($data_xuat as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$this->data['nhapxuat'][$date]['xuat'][] = $item;
				}
			}
			
		}
		//print_r($this->data['nhapxuat']);
		$this->id='content';
		$this->template="sales/sale_product_history.tpl";
		$this->render();
	}
}
?>