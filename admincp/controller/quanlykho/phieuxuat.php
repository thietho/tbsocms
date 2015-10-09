<?php
class ControllerQuanlykhoPhieuxuat extends Controller
{
	private $error = array();
	//private $loaiphieu = array('PBH','XCH','THNCC');
	function __construct() 
	{
		
		@$this->load->model("core/module");
		$moduleid = $_GET['route'];
		@$this->document->title = @$this->model_core_module->getBreadcrumbs($moduleid);
		if(@$this->user->checkPermission($moduleid)==false)
		{
			@$this->response->redirect('?route=page/home');
		}
		
		/*@$this->data['loaiphieu'] = array(
								"PX-PBH" => "Phiếu bán hàng",
								"PX-XCH" => "Phiếu xuất ra cửa hàng",
								"PX-THNCC" => "Phiếu xuất trả nhà cung cấp",
								
								);*/
		@$this->load->model("quanlykho/phieunhapxuat");
		@$this->load->helper('image');
		@$this->load->model("core/category");
		@$this->load->model("core/media");
		@$this->load->model("quanlykho/donvitinh");
		@$this->load->model("sales/shop");
		
		$this->data['loaisanpham'] = array();
		$this->model_core_category->getTree("sanpham",$this->data['loaisanpham']);
		unset($this->data['loaisanpham'][0]);
		
		$this->data['loaiphieu'] = array();
		$this->model_core_category->getTree("export",$this->data['loaiphieu']);
		unset($this->data['loaiphieu'][0]);
		
		
		@$this->data['donvitinh'] = @$this->model_quanlykho_donvitinh->getList();
		$where = " GROUP BY nguoithuchien";
		@$this->data['data_nguoithuchien'] = @$this->model_quanlykho_phieunhapxuat->getList($where);
		
		$where = " ORDER BY shopname";
		@$this->data['data_shop'] = @$this->model_sales_shop->getList($where);
			
		/*$where = " AND mediatype = 'module/product' ORDER BY `title` ASC";
		@$this->data['data_media'] = array();
		$medias = @$this->model_core_media->getList($where);
		foreach($medias as $i => $media)
		{
			$child = @$this->model_core_media->getListByParent($media['mediaid']);
			if(count($child) == 0)
				@$this->data['data_media'][] = $media;
			
		}*/
		//print_r(@$this->data['data_nguoithuchien']);
   	}
	public function index()
	{
		
		@$this->data['insertlist'] = @$this->url->http('quanlykho/phieuxuat/insertlist');
		@$this->data['insert'] = @$this->url->http('quanlykho/phieuxuat/insert');
		@$this->data['delete'] = @$this->url->http('quanlykho/phieuxuat/delete');
		
		@$this->id='content';
		@$this->template="quanlykho/phieuxuat_list.tpl";
		@$this->layout="layout/center";
		
		if(@$this->request->get['opendialog']=='true')
		{
			@$this->layout="";
			@$this->data['dialog'] = true;
			
		}
		@$this->render();
	}
	
	public function insert()
	{
    	@$this->getForm();
	}
	public function insertlist()
	{		
    	@$this->id='content';
		@$this->template='quanlykho/phieuxuat_form_list.tpl';
		@$this->layout="layout/center";
		@$this->render();
	}
	
	public function update()
	{
		@$this->data['haspass'] = false;
		@$this->data['readonly'] = 'readonly="readonly"';
		@$this->getForm();		
  	}
	
	public function delete() 
	{
		$listid=@$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		
		if(count($listid))
		{
			foreach($listid as $id)
			@$this->model_quanlykho_phieunhapxuat->destroy($id);
			@$this->data['output'] = "Xóa thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
  	}
	private function loadData()
	{
		
		
		@$this->data['datas'] = array();
		$where = " AND loaiphieu like 'PX%'";
		
		$datasearchlike['maphieu'] = urldecode(@$this->request->get['maphieu']);
		$datasearchlike['trangthai'] = urldecode(@$this->request->get['trangthai']);
		
		$datasearchlike['tenkhachhang'] = urldecode(@$this->request->get['tenkhachhang']);
		$datasearchlike['dienthoai'] = urldecode(@$this->request->get['dienthoai']);
		$datasearchlike['diachi'] = urldecode(@$this->request->get['diachi']);
		$datasearchlike['nguoithuchien'] = urldecode(@$this->request->get['nguoithuchien']);
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if(@$item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		$where .= implode("",$arr);
		$tungay = @$this->date->formatViewDate(urldecode(@$this->request->get['tungay']));
		if(@$tungay !="")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		$denngay = @$this->date->formatViewDate(urldecode(@$this->request->get['denngay']));
		if(@$denngay !="")
		{
			$where .= " AND ngaylap <= '".$denngay." 23:59:59'";
		}
		
		$rows = @$this->model_quanlykho_phieunhapxuat->getList($where);
		return $rows;	
	}
	
	public function getList() 
	{	
		@$this->data['datas'] = array();
		$rows = @$this->loadData();
		//Page
		@$page = @$this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		@$this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"#listphieunhap");
		
		$pager  = @$this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
		//for($i=0; $i <= count(@$this->data['datas'])-1 ; $i++)
		{
			@$this->data['datas'][$i] = $rows[$i];
			@$this->data['datas'][$i]['link_edit'] = @$this->url->http('quanlykho/phieuxuat/update&id='.@$this->data['datas'][$i]['id']);
			@$this->data['datas'][$i]['text_edit'] = "Sửa";
			;
			
		}
		@$this->data['refres']=$_SERVER['QUERY_STRING'];
		@$this->id='content';
		@$this->template="quanlykho/phieuxuat_table.tpl";
		
		if(@$this->request->get['opendialog']=='true')
		{
			@$this->layout="";
			@$this->data['dialog'] = true;
			
		}
		@$this->render();
	}
	public function view($id ="")
	{
		if(@$id =="")
			$id = @$this->request->get['id'];
		if(@$id) 
		{
      		@$this->data['item'] = @$this->model_quanlykho_phieunhapxuat->getItem($id);
			
			$where = " AND phieuid = '".$id."' ORDER BY `vitri` ASC";
			@$this->data['data_nhapkho'] = array();
			$data = @$this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
			foreach($data as $key => $item)
			{
				if(@$item['xuattu'] == '')
				{
					@$this->data['data_nhapkho'][]=$item;
					unset($data[$key]);
				}
			}
			if(count($data))
			{
				foreach(@$this->data['data_nhapkho'] as $key => $item)
				{
					
					foreach($data as $k =>$da)
					{
						if(@$da['mediaid'] == $item['mediaid'] && $da['giatien'] == $item['giatien'])
						{
							@$this->data['data_nhapkho'][$key]['soluong'] += $da['soluong'];
							@$this->data['data_nhapkho'][$key]['thanhtien'] += $da['thanhtien'];
							unset($data[$k]);
						}
					}
					
				}
				if(count($data))
					foreach($data as $item)
					{
						@$this->data['data_nhapkho'][]=$item;	
					}
			}
    	}
		
		@$this->id='content';
		@$this->template='quanlykho/phieuxuat_view.tpl';
		if(@$_GET['show']=="giamgia")
			@$this->template='quanlykho/phieuxuat_view1.tpl';
		if(@$_GET['opendialog'] == 'print')
			@$this->layout="layout/print";
		@$this->render();
	}
	public function printlist()
	{
		$listid = @$this->request->get['listid'];
		@$arrid = split("-",$listid);
		
		foreach($arrid as $key => $id)
		{
			$arr = array($id);
			@$this->data['output'].= @$this->loadModule('quanlykho/phieuxuat','view',$arr);
			//if(@$key < count($arrid) - 1)
				//@$this->data['output'] .= '<div style="page-break-after:always">&nbsp;</div>';
		}
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	private function getForm()
	{
		$id = @$this->request->get['id'];
		
		if(@$id) 
		{
      		@$this->data['item'] = @$this->model_quanlykho_phieunhapxuat->getItem($id);
			//@$this->data['item']['imagethumbnail'] = HelperImage::resizePNG(@$this->data['item']['imagepath'], 200, 200);
			$where = " AND phieuid = '".$id."' ORDER BY `vitri` ASC";
			@$this->data['data_nhapkho'] = @$this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
    	}
		else
		{
			
			//@$this->data['item']['ngaylap'] = @$this->date->getToday();
			if(isset($_SESSION['productlist']))
			{
				$medias = $_SESSION['productlist'];
				$i=0;
				foreach($medias as $media)
				{
					@$this->data['data_nhapkho'][$i]['mediaid']=$media['mediaid'];
					@$this->data['data_nhapkho'][$i]['code']=$media['code'];
					@$this->data['data_nhapkho'][$i]['title']=$media['title'];
					if(@$media['color'])
						@$this->data['data_nhapkho'][$i]['title'].= " - ".$media['color'];
					@$this->data['data_nhapkho'][$i]['soluong']=$media['qty'];
					@$this->data['data_nhapkho'][$i]['madonvi']=$media['unit'];
					
					/*if(@$media['pricepromotion'])
						$price = $media['pricepromotion'];*/
					@$this->data['data_nhapkho'][$i]['giatien']=$media['price'];
					@$this->data['data_nhapkho'][$i]['giamgia']=$media['pricepromotion'];
					@$this->data['data_nhapkho'][$i]['phantramgiamgia']=$media['discountpercent'];
					$i++;
				}
			}
		}
		
		@$this->id='content';
		@$this->template='quanlykho/phieuxuat_form.tpl';
		@$this->layout="layout/center";
		
		@$this->render();
	}
	
	public function save()
	{
		$data = @$this->request->post;
		//print_r($data);
		if(@$this->validateForm($data))
		{
			$nhanvien = @$this->user->getNhanVien();
			$data['ngaylap'] = @$this->date->formatViewDate($data['ngaylap']);
			$data['ngaythanhtoan'] = @$this->date->formatViewDate($data['ngaythanhtoan']);
			if(@$data['nguoithuchien']=="")
			{
				$data['nguoithuchienid'] = $nhanvien['id'];
				$data['nguoithuchien'] = $nhanvien['hoten'];
			}
			//$data['loaiphieu'] = @$this->loaiphieu;
			$data['id'] = @$this->model_quanlykho_phieunhapxuat->save($data);
			$phieu = @$this->model_quanlykho_phieunhapxuat->getItem($data['id']);
			
			
			$phieu['error'] = '';
			//@$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'tongtien',$tongtien);
			//@$this->model_quanlykho_phieunhapxuat->updateCol($phieuid,'congno',$tongtien- @$this->string->toNumber($data['thanhtoan']));
			@$this->data['output'] = json_encode($phieu);
			if(isset($_SESSION['productlist']))
			{
				unset($_SESSION['productlist']);	
			}
		}
		else
		{
			foreach(@$this->error as $item)
			{
				$phieu['error'] .= $item."<br>";
			}
			@$this->data['output'] = json_encode($phieu);
		}
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	
	private function validateForm($data)
	{
		if (count(@$this->error)==0) {
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	public function delDetail()
	{
		//Xoa dinh luong
		$data = @$this->request->post;
		$delnhapkho = $data['delnhapkho'];
		if(@$delnhapkho)
		{
			@$arr_nhapkhoid = split(",",$delnhapkho);
			if(count($arr_nhapkhoid))
			{
				
				foreach($arr_nhapkhoid as $nhapkhoid)
				{
					$ph = @$this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMedia($nhapkhoid);
					@$this->model_quanlykho_phieunhapxuat->deletePhieuNhapXuatMedia($nhapkhoid);
					
					$mediaid = $ph['mediaid'];
					//Cap nhat ton kho
					$inventory = @$this->model_core_media->getInventory($mediaid);
					@$this->model_core_media->updateCol($mediaid,'inventory',$inventory);
				}
				
			}
		}
	}
	public function saveDetail()
	{
		//Save chi tiet phieu nhap
		$data = @$this->request->post;
		if(@$data['mediaid'])
		{
			
			$data['id'] = @$this->model_quanlykho_phieunhapxuat->savePhieuNhapXuatMedia($data);
			$data['error'] = '';
			
			//Cap nhat ton kho
			$inventory = @$this->model_core_media->getInventory($data['mediaid']);
			@$this->model_core_media->updateCol($data['mediaid'],'inventory',$inventory);
		}
		else
		{
			$data['error'] = 'false';	
		}
		@$this->data['output'] = json_encode($data);
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	//Cac ham xu ly tren form
	public function export()
	{
		require_once DIR_COMPONENT.'PHPExcel/Classes/PHPExcel.php';
		$objPHPExcel = new PHPExcel();
		$objPHPExcel->getProperties()->setCreator("Ho Lan Solutions")
							 ->setLastModifiedBy("Lư Thiết Hồ")
							 ->setTitle("Export data")
							 ->setSubject("Export data")
							 ->setDescription("")
							 ->setKeywords("Ho Lan Solutions")
							 ->setCategory("Product");
		$objPHPExcel->setActiveSheetIndex(0)
            ->setCellValue('A1', 'STT')
			->setCellValue('B1', 'NGÀY')
			->setCellValue('C1', 'TÊN KH')
            ->setCellValue('D1', 'SP')
			->setCellValue('E1', 'T.TIỀN')
			->setCellValue('F1', 'THANH TOÁN')
			->setCellValue('G1', 'NGÀY THANH TOÁN')
			->setCellValue('H1', 'TTV')
            ->setCellValue('I1', 'SĐT')
			->setCellValue('J1', 'ĐỊA CHỈ')
			;
		$objPHPExcel->getActiveSheet()->getStyle('A1:I1')->getFont()->setBold(true);
		/*$objPHPExcel->getActiveSheet()->getStyle('A8')->getAlignment()->setWrapText(true);
		$objPHPExcel->getActiveSheet()->setCellValue('A8',"Hello\nWorld");
		$objPHPExcel->getActiveSheet()->getRowDimension(8)->setRowHeight(-1);
		$objPHPExcel->getActiveSheet()->getStyle('A8')->getAlignment()->setWrapText(true);*/
		
		
		$key = 2;
		$rows = @$this->loadData();
		foreach($rows as $i=> $item)
		{
			$where = " AND phieuid = '".$item['id']."'";
			$details = @$this->model_quanlykho_phieunhapxuat->getPhieuNhapXuatMediaList($where);
			$arr=array();
			foreach($details as $detail)
			{
				$arr[] = $detail['soluong'].@$this->document->getMedia($detail['mediaid'],"ref");
				
			}
			$sanpham = implode("+",$arr);
			$objPHPExcel->setActiveSheetIndex(0)
				->setCellValue('A'.$key, $i+1)
				->setCellValue('B'.$key, @$this->date->formatMySQLDate($item['ngaylap']))
				->setCellValue('C'.$key, $item['tenkhachhang'])
				->setCellValue('D'.$key, $sanpham)
				->setCellValue('E'.$key, $item['tongtien'])
				->setCellValue('F'.$key, $item['thanhtoan'])
				->setCellValue('G'.$key, @$this->date->formatMySQLDate($item['ngaythanhtoan']))
				->setCellValue('H'.$key, $item['nguoithuchien'])
				->setCellValue('I'.$key, $item['dienthoai'])
				->setCellValue('J'.$key, $item['diachi'])
				
				
				
				;
			$key++;
		}
		$objPHPExcel->getActiveSheet()->setTitle('HoaDonBanHang');
		$objPHPExcel->setActiveSheetIndex(0);
		//
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
		$filename = "HoaDonBanHang".time().".xls";
		$objWriter->save(DIR_CACHE.$filename);
		@$this->data['output'] = HTTP_IMAGE."cache/".$filename;
		
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
}
?>