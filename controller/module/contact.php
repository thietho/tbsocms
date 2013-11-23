<?php
class ControllerModuleContact extends Controller
{
	public function index()
	{
		$this->load->model("core/media");
		
		$sitemapid = $this->document->sitemapid;
		
		$this->data['post'] = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
		
		if(count($this->data['post']) == 0)
		{
			$this->data['post']['description'] = "Updating...";
		}
		
		$this->data['post']['description'] = html_entity_decode($this->data['post']['description']);
		$this->document->title .= " - ".$this->data['post']['title'];
		$arr = array("sododuongdi");
						
		$this->data['sododuongdi'] = $this->loadModule('module/location','loadLocation',$arr);
		
		$this->id="contact";
		$this->template="module/contact.tpl";
		$this->render();
	}
	
	public function sendMessage()
	{
		$data=$this->request->post;
		$error = $this->validate($data);
		if(count($error))
		{
			foreach($error as $item)
				$this->data['output'].=$item."<br>";
		}
		else
		{
			
			$this->load->model("core/media");
			$sitemapid = $data['sitemapid'];
			$media = $this->model_core_media->getItem($this->member->getSiteId().$sitemapid);
			/*$email1 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email1");
			$email2 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email2");
			$email3 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email3");*/
			$email = $this->model_core_media->getInformation("setting", 'EmailContact');
			$email1 = $email;
			$arrmail = array();
			if($email1)
				$arrmail[] = $email1;
			if($email2)
				$arrmail[] = $email2;
			if($email3)
				$arrmail[] = $email3;
			$this->load->model("core/message");
			$message['to']="admin," .implode(",",$arrmail) ;
			$message['from']='"'.$data['fullname'].'" '.$data['email'];
			$message['title'] = $media['title'];
			$message['description']="Họ tên: ".$data['fullname']."<br>";
			$message['description'].="Email: ".$data['email']."<br>";
			$message['description'].="Địa chỉ: ".$data['address']."<br>";
			$message['description'].="Điện thoại: ".$data['phone']."<br>";
			$message['description'].="Nội dung: ".$data['description']."<br>";
			$message['folder']="inbox";
			$this->model_core_message->insert($message);
			
			$mail['from'] = $data['email'];
			$mail['FromName'] = $data['fullname'];
			$mail['to'] = implode(",",$arrmail);
			$mail['name'] = "";
			$mail['subject'] =  $message['title'];
			$arr = array($message['description']);
			$mail['body'] = $this->loadModule('module/contact','createEmailTemplate',$arr);
			$this->mailsmtp->sendMail($mail);
			
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function validate($data)
	{
		$err = array();
		
		if($data['fullname'] == "")
			$err["fullname"] = $this->data['war_fullnamenotnull'];
		if($data['email'] == "")
			$err["email"] = $this->data['war_emailnotnull'];
		else
			if ($this->validation->_checkEmail($data['email']) == false )
				$err["email"] = $this->data['war_emailnotformate'];
		if($data['address'] == "")
			$err["address"] = $this->data['war_addressnotnull'];
		if($data['phone'] == "")
			$err["phone"] = $this->data['war_phonenotnull'];
		if($data['description'] == "")
			$err["description"] = $this->data['war_descriptionnotnull'];
		return $err;
	}
	
	public function registerEvent()
	{
		$data=$this->request->post;
		$error = $this->validateRegister($data);
		if(count($error))
		{
			foreach($error as $item)
				$this->data['output'].=$item."<br>";
		}
		else
		{
			
			$this->load->model("core/media");
			$this->load->model("core/sitemap");
			$sitemapid = $data['khoahoc'];
			$mediaid = $data['mediaid'];
			//$media = $this->model_core_media->getItem($mediaid);
			
			
			/*$email1 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email1");
			$email2 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email2");
			$email3 = $this->model_core_media->getInformation($this->member->getSiteId().$data['sitemapid'], "email3");*/
			$email = $this->model_core_media->getInformation("setting", 'EmailContact');
			/*$email1 = $email;
			$arrmail = array();
			if($email1)
				$arrmail[] = $email1;
			if($email2)
				$arrmail[] = $email2;
			if($email3)
				$arrmail[] = $email3;*/
			
			$this->load->model("core/message");
			$message['to']="admin," .$email ;
			$message['from']='"'.$data['hoten'].'" '.$data['email'];
			if($sitemapid!="")
			{
				$sitemap = $this->model_core_sitemap->getItem($sitemapid,$this->member->getSiteId());
				$message['title'] = "Thong tin dang ky khoa hoc ".$sitemap['sitemapname'];
				$message['description']="Đăng ký chương trình: ".$sitemap['sitemapname']."<br>";
			}
			if($mediaid!="")
			{
				$media = $this->model_core_media->getItem($mediaid);
				$message['title'] = "Thong tin dang ky hoi thao ";
				$message['description']="Đăng ký hội thảo: ".$media['title']."<br>";
			}
			
			$message['description'].="Họ tên: ".$data['hoten']."<br>";
			$message['description'].="Ngày sinh: ".$data['ngaysinh']."<br>";
			$message['description'].="Địa chỉ: ".$data['diachi']."<br>";
			$message['description'].="Tên công ty: ".$data['tencongty']."<br>";
			$message['description'].="Email: ".$data['email']."<br>";
			$message['description'].="Điện thoại: ".$data['didong']."<br>";
			$message['description'].="Ghi chú: ".$data['ghichu']."<br>";
			
			$message['folder']="inbox";
			$this->model_core_message->insert($message);
			
			$mail['from'] = $data['email'];
			$mail['FromName'] = $data['fullname'];
			$mail['to'] = $email;
			$mail['name'] = "";
			$mail['subject'] =  $message['title'];
			$arr = array($message['description']);
			$mail['body'] = $this->loadModule('module/contact','createEmailTemplate',$arr);
			
			$this->mailsmtp->sendMail($mail);
			
			$this->data['output'] = "true";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
	}
	
	private function validateRegister($data)
	{
		$err = array();
		
		if($data['hoten'] == "")
			$err["hoten"] = $this->data['war_fullnamenotnull'];
		if($data['ngaysinh'] == "")
			$err["ngaysinh"] = "Bạn chưa nhập ngày sinh";
		if($data['diachi'] == "")
			$err["diachi"] = "Bạn chưa nhập địa chỉ liên hệ";
		if($data['email'] == "")
			$err["email"] = $this->data['war_emailnotnull'];
		else
			if ($this->validation->_checkEmail($data['email']) == false )
				$err["email"] = $this->data['war_emailnotformate'];
		
		if($data['didong'] == "")
			$err["didong"] = $this->data['war_phonenotnull'];
		
		return $err;
	}
	
	public function createEmailTemplate($description)
	{
		$this->data['description'] = $description;
		$this->id="content";
		$this->template="common/email.tpl";
		$this->render();
	}
}
?>