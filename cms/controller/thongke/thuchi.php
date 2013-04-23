<?php
class ControllerThongkeThuchi extends Controller
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
		$this->load->model("quanlykho/donvitinh");
	}
	public function index()
	{
		
		$this->id='content';
		$this->template="thongke/thuchi.tpl";
		$this->layout="layout/center";
		$this->render();
	}
	public function thongke()
	{
		$data = $this->request->post;
		
		$tungay = $this->date->formatViewDate($data['tungay']);
		$denngay = $this->date->formatViewDate($data['denngay']);
		
		$data_kytruoc = $this->xuly("",$tungay);
		$this->data['tonkytruoc'] = $data_kytruoc['tontrongky'];
		
		$data_trongky = $this->xuly($tungay,$denngay);
		$this->data['data_thuchi'] = $data_trongky['data_thuchi'];
		$this->data['tongthu'] = $data_trongky['tongthu'];
		$this->data['tongchi'] = $data_trongky['tongchi'];
		$this->data['tontrongky'] = $data_trongky['tontrongky'];
		$this->id='content';
		$this->template="thongke/thuchi_thongke.tpl";
		
		$this->render();
			
	}
	public function xuly($tungay,$denngay)
	{
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("addon/thuchi");
		
		$arrdate = array();
		/*$where = " AND qlkphieunhapxuat.loaiphieu = 'PBH'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}*/
		//Thu
		//Thong ke phieu thu
		$where = " AND loaithuchi = 'thu'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_thu = $this->model_addon_thuchi->getList($where);
		foreach($data_thu as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		
		
		//Thong ke phieu ban hang
		$where = " AND loaiphieu = 'PBH'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_banhang = $this->model_quanlykho_phieunhapxuat->getList($where);
		
		
		foreach($data_banhang as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		//End thu
		//Chi
		//Thong ke phieu chi
		$where = " AND loaithuchi = 'chi'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_chi = $this->model_addon_thuchi->getList($where);
		foreach($data_chi as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		//Thong ke pheu nhap hang
		$where = " AND loaiphieu = 'NK'";
		if($tungay != "")
		{
			$where .= " AND ngaylap >= '".$tungay."'";
		}
		if($denngay != "")
		{
			$where .= " AND ngaylap < '".$denngay." 24:00:00'";
		}
		$data_nhaphang = $this->model_quanlykho_phieunhapxuat->getList($where);
		foreach($data_chi as $item)
		{
			$ngaylap = $this->date->getDate($item['ngaylap']);
			if(!in_array($ngaylap,$arrdate))
			{
				$arrdate[] = $this->date->getDate($item['ngaylap']);
			}
		}
		//End chi
		sort(&$arrdate);
		$tongthu = 0;
		$tongchi = 0;
		$data_thuchi = array();
		foreach($arrdate as $date)
		{
			//Thu
			foreach($data_thu as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$arr = array(
								'maphieu' => $item['sophieu'],
								'loai' => "Phiếu thu",
								'sotien' => $item['sotien']
								);
					$tongthu += $item['sotien'];
					$data_thuchi[$date]['thu'][] = $arr;
				}
			}
			//Ban hang
			foreach($data_banhang as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$arr = array(
								'maphieu' => $item['maphieu'],
								'loai' => "Phiếu bán hàng",
								'sotien' => $item['tongtien']
								);
					$tongthu += $item['tongtien'];
					$data_thuchi[$date]['thu'][] = $arr;
				}
			}
			
			//Chi
			foreach($data_chi as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$arr = array(
								'maphieu' => $item['sophieu'],
								'loai' => "Phiếu chi",
								'sotien' => $item['sotien']
								);
					$tongchi += $item['sotien'];
					$data_thuchi[$date]['chi'][] = $arr;
				}
			}
			//Nhap hang
			foreach($data_nhaphang as $item)
			{
				$ngaylap = $this->date->getDate($item['ngaylap']);
				if($ngaylap == $date)
				{
					$arr = array(
								'maphieu' => $item['maphieu'],
								'loai' => "Phiếu phập hàng",
								'sotien' => $item['tongtien']
								);
					$tongchi += $item['tongtien'];
					$data_thuchi[$date]['chi'][] = $arr;
				}
			}
		}
		
		$datakq = array(
						'data_thuchi' => $data_thuchi,
						'tongthu' => $tongthu,
						'tongchi' => $tongchi,
						'tontrongky' => $tongthu - $tongchi
						);
		return $datakq;
		
	}
	
}
?>