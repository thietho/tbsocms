<?php
class ControllerCoreNotification extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		
		$this->load->model("core/media");
	}
	public function systemCheck()
	{
		$where = " AND mediatype = 'module/product'";
		$where .= " Order by position, statusdate DESC";
		$medias = $this->model_core_media->getList($where);
		$data_war = array();
		foreach($medias as $key => $media)
		{
			$media['productName'] = $this->document->productName($media);
			//$inventory = $this->model_core_media->getInventory($media['mediaid']);
			//$media['inventory'] = $inventory;
			$data = array();
			$data['productName'] = $media['productName'];
			$data['inventory'] = $media['inventory'];
			if($media['noteprice'] == 'minisize')
			{
				//Cac san pham minisize co ton ma bi an			
				
				
				
				if((int)$inventory > 0 && $media['status'] == 'hide')
				{
					$media['inventory'] = $inventory;
					$data_war['minsizeactive'][]=$data;
					
				}
				//Cac san pham minisize het hang ma chua an
				if((int)$inventory == 0 && $media['status'] == 'active')
				{
					$data_war['minsizehide'][]=$data;
					
				}
			}
			//Cac san pham bi am trong kho
			if((int)$inventory < 0)
			{
				$data_war['productamkho'][]=$data;
			}
			//Cac san pham chua co gia
			$child = $this->model_core_media->getListByParent($media['mediaid']);
			if(count($child) == 0 && $media['status'] == 'active' && $media['price'] == 0)
			{
				$data_war['productprice'][]=$data;
			}
			//Cac san pham dang active ma chua cap nhat hinh
			if($media['status'] == 'active' && $media['imagepath'] == '')
			{
				$data_war['productimage'][]=$data;
			}
		}
		$this->data['output'] = json_encode($data_war);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	public function systemCheckMinSize()
	{
		$where = " AND mediatype = 'module/product' AND noteprice = 'minisize'";
		$where .= " Order by position, statusdate DESC";
		$medias = $this->model_core_media->getList($where);
		$data_war = array();
		$data_war['minsizeactive'] = array();
		$data_war['minsizehide'] = array();
		foreach($medias as $key => $media)
		{
			$media['productName'] = $this->document->productName($media);
			//$inventory = $this->model_core_media->getInventory($media['mediaid']);
			//$media['inventory'] = $inventory;
			$data = array();
			
			$data['productName'] = $media['productName'];
			$data['inventory'] = $media['inventory'];
			if($media['noteprice'] == 'minisize')
			{
				//Cac san pham minisize co ton ma bi an			
				
				
				
				if((int)$media['inventory'] > 0 && $media['status'] == 'hide')
				{
					$media['inventory'] = $inventory;
					$data_war['minsizeactive'][]=$data;
					
				}
				//Cac san pham minisize het hang ma chua an
				if((int)$media['inventory'] == 0 && $media['status'] == 'active')
				{
					$data_war['minsizehide'][]=$data;
					
				}
			}
			
		}
		$this->data['output'] = json_encode($data_war);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	public function systemCheckInventory()
	{
		$where = " AND mediatype = 'module/product' AND `inventory` <>  ''";
		$where .= " Order by position, statusdate DESC";
		$medias = $this->model_core_media->getList($where);
		$data_war = array();
		$data_war['productinventory'] = array();
		$data_war['productprice'] = array();
		$data_war['productimage'] = array();
		foreach($medias as $key => $media)
		{
			if((int)$media['inventory']<0)
			{
				
				//Cac san pham bi am trong kho
				$media['productName'] = $this->document->productName($media);
				$data = array();
				$data['productName'] = $media['productName'];
				$data['inventory'] = $media['inventory'];
				$data_war['productinventory'][]=$data;
				
			}
			if((int)$media['inventory'] > 0 && $media['price']==0 && $media['status'] == 'active')
			{
				$media['productName'] = $this->document->productName($media);
				$data = array();
				$data['productName'] = $media['productName'];
				$data['inventory'] = $media['inventory'];
				$data_war['productprice'][]=$data;
			}
			if((int)$media['inventory'] > 0 && $media['imagepath']=='' && $media['status'] == 'active')
			{
				$media['productName'] = $this->document->productName($media);
				$data = array();
				$data['productName'] = $media['productName'];
				$data['inventory'] = $media['inventory'];
				$data_war['productimage'][]=$data;
			}
		}
		$this->data['output'] = json_encode($data_war);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
}