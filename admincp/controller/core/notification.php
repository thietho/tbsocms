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
			if($media['noteprice'] == 'minisize')
			{
				//Cac san pham minisize co ton ma bi an			
				$tonkho = $this->model_core_media->getTonKho($media['mediaid']);
				
				$media['tonkho'] = $tonkho;
				if((int)$tonkho > 0 && $media['status'] == 'hide')
				{
					$media['tonkho'] = $tonkho;
					$data_war['minsizeactive'][$key]['productName'] = $media['productName'];
					$data_war['minsizeactive'][$key]['tonkho'] = $media['tonkho'];
				}
				//Cac san pham minisize het hang ma chua an
				if((int)$tonkho == 0 && $media['status'] == 'active')
				{
					$data_war['minsizehide'][$key]['productName'] = $media['productName'];
					$data_war['minsizehide'][$key]['tonkho'] = $media['tonkho'];
				}
			}
			//Cac san pham bi am trong kho
			//Cac san pham chua co gia
			$child = $this->model_core_media->getListByParent($media['mediaid']);
			if(count($child) == 0 && $media['status'] == 'active')
			{
				$data_war['productprice'][$key]['productName'] = $media['productName'];
			}
			//Cac san pham dang active ma chua cap nhat hinh
			if($media['status'] == 'active' && $media['imagepath'] == '')
			{
				$data_war['productimage'][$key]['mediaid'] = $media['mediaid'];
				$data_war['productimage'][$key]['title'] = $media['title'];
				
				$data_war['productimage'][$key]['productName'] = $media['productName'];
			}
		}
		$this->data['output'] = json_encode($data_war);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}