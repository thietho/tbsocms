<?php
class ControllerCoreNotification extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
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
			if($media['noteprice'] == 'minisize')
			{
				//Cac san pham minisize co ton ma bi an			
				$tonkho = $this->model_core_media->getTonKho($media['mediaid']);
				$media['productName'] = $this->document->productName($media);
				$media['tonkho'] = $tonkho;
				if((int)$tonkho > 0 && $media['status'] == 'hide')
				{
					$media['tonkho'] = $tonkho;
					$data_war['minsizeactive'][$key] = $media;
				}
				//Cac san pham minisize het hang ma chua an
				if((int)$tonkho == 0 && $media['status'] == 'active')
				{
					$data_war['minsizehide'][$key] = $media;
				}
			}
			//Cac san pham chua co gia
			$child = $this->model_core_media->getListByParent($media['mediaid']);
			if(count($child) == 0)
			{
				$data_war['productprice'][$key] = $media;
			}
			//Cac san pham dang active ma chua cap nhat hinh
			if($media['status'] == 'active' && $media['imagepath'] == '')
			{
				$data_war['productimage'][$key] = $media;
			}
		}
		$this->data['output'] = json_encode($data_war);
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
}