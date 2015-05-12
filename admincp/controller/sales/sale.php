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
}
?>