<?php
class ControllerCoreMedia extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
		$this->load->model("core/media");
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("core/sitemap");
		$this->load->model("core/category");
		$this->load->helper('image');
		
		$this->data['module'] = array(
										
							'module/news'=>'News',
							'module/event' => 'Event',
							'module/banner'=>'Banner',
							'module/album'=>'Album',
							'module/video'=>'Video',
							'module/product'=>'Product',
							'module/download'=>'Download',
							'module/link'=>'Web URL',
							'module/traning'=>'Traning',
							'module/question'=>'Questions',
							'module/location'=>'Location'
							
										);
		$this->load->model('core/user');
		$where = " AND usertypeid <> 'member'";
		$this->data['users'] = $this->model_core_user->getList($where);
	}
	
	
	public function getProduct()
	{
		/*$where = " AND mediatype = 'module/product' ";
		$medias = $this->model_core_media->getList($where);
		$data = array();
		foreach($medias as $media)
		{
			$child = $this->model_core_media->getListByParent($media['mediaid']);
			if(count($child) == 0)
			{
				
				$data[] = $media;
			}
		}*/
		$data = $this->model_core_category->getList($where);
		//$xml = ArrayToXML::toXml($data);
		$this->data['data'] = $data;
		$this->id="media";
		$this->template="common/xmltable.tpl";
		$this->render();
	}
	public function getListDonVi()
	{
		$mediaid = $this->request->get['mediaid'];
		$media = $this->model_core_media->getItem($mediaid);
		$data_donvi = $this->model_quanlykho_donvitinh->getDonViQuyDoi($media['unit']);
		$this->data['output'] = json_encode($data_donvi);
		
		$this->id="donvi";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	
}
?>