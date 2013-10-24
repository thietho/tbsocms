<?php
class ControllerCommonTest extends Controller
{
	
	function sendmail()
	{
		$mail['from'] = "info@chubbykids.us";
		$mail['FromName'] = "chubbykids.us";
		$mail['to'] = "thietho1982@gmail.com";
		$mail['name'] = "Thiet Ho";
		$mail['subject'] =  "Test send mail";
		
		$mail['body'] = "Test send mail";
		$this->mailsmtp->sendMail($mail);
		
		
		$this->id='content';
		$this->template='common/output.tpl';
		$this->layout="layout/center";
		$this->render();
	}
	
	
	
	
}


?>