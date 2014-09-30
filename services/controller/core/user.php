<?php
class ControllerCoreUser extends Controller
{
	private $error = array();
	private $route;
	public function __construct() 
	{
		$this->load->model("core/user");
		$this->load->model("quanlykho/nhanvien");
		$this->load->model("sales/shop");
	}
	
	private function check($username,$password)
	{
		$user = $this->model_core_user->getItem($this->db->escape($username));
		if(md5($password) == $user['password'])
			return true;
		else
			return false;
	}
	public function login()
	{
		$data = $this->request->post;
		if($data['username']=="")
			$data['error_warning'] = "Thông tin đăng nhập không đúng";
		else
		{
			if (!$this->check($data['username'],$data['password']))
			{
				$data['error_warning'] = "Thông tin đăng nhập không đúng";
			}
			else
			{
				//Dang nhap thang cong
				$sql = " AND username = '".$data['username']."'";
				$data_nhanvien = $this->model_quanlykho_nhanvien->getList($sql);
				$nhanvien = $data_nhanvien[0];
				
				$data['nhanvienid']	= $nhanvien['id'];
				$data['manhanvien']	= $nhanvien['manhanvien'];
				$data['hoten']	= $nhanvien['hoten'];
				$data['loai']	= $nhanvien['loai'];
				//$sql = " AND staffid = '".$nhanvien['id']."'";
				$arr = $this->model_sales_shop->getShopStaff($nhanvien['id']);
				$shopid = $arr['shopid'];
				$shop = $this->model_sales_shop->getItem($shopid);
				$data['shopid'] = $shop['id'];
				$data['shopname'] = $shop['shopname'];
				$data['shoptype'] = $shop['shoptype'];
				$data['address'] = $shop['address'];
				$data['phone'] = $shop['phone'];
				$data['error_warning'] = "";
			}	
		}
		
		
		$this->data['data'] = $data;
		$this->id="media";
		$this->template="common/xmlarray.tpl";
		$this->render();
	}
	
	
}
?>