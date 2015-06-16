<?php
final class Member {
	private $userid;
	private $username;
	private $siteid;
	private $usertypeid;
  	private $permission = array();
	private $Control = array();
	public $data = array();
	public $go_country;
  	
	public function __construct() {
		$this->db = Registry::get('db');
		$this->request = Registry::get('request');
		$this->session  = Registry::get('session');
		$this->json  = Registry::get('json');
		$this->string  = Registry::get('string');
		$this->date  = Registry::get('date');
		
		
		/*switch($this->request->get['lang'])
		{
			case "":
				$this->siteid = SITEID;
				break;
			case "vn":
				$this->siteid = "vietname";
				break;
			case "en":
				$this->siteid = SITEID;
				break;
		}*/
		if(@$this->request->get['lang'])
		{
			
			$this->siteid = $this->request->get['lang'];
		}
		else
		{
			$this->siteid = SITEID;
		}
		
		if(@$this->request->get['contry'])
		{
			$this->go_country = $this->request->get['contry'];
			$this->session->set('country',$this->go_country);
		}
		else
		{
			@$this->go_country = $this->session->data['country'];
		}
		if(@$_COOKIE['username'] != "")
		{
			@$this->login($_COOKIE['username'],$_COOKIE['password']);	
		}
		
		if(count($this->session->data['member']))
		{
			print_r($this->session->data['member']);
			$this->userid = $this->session->data['member']['userid'];
			$this->username = $this->session->data['member']['username'];
			$this->usertypeid = $this->session->data['member']['usertypeid'];
			
			$this->data = $this->session->data['member'];
		}
    	
		//$this->updatelistonline();
		//$this->writelog();
  	}
		
  	
	
  	public function logout() {
		unset($this->session->data['member']);
			
		$this->userid = '';
		$this->username = '';
		$this->safemode = false;
  	}
	
	public function setPermission($strPermission)
	{
		$this->permission = array();
		
		$this->permission = $this->string->referSiteMapToArray($strPermission);
		
	}

	public function setControl($key, $button)
	{
		$arr = array();
		if(!is_array($button)) {array_push($arr,$button);} else {$arr = $button;}
		$this->Control[$key] = array($arr);
	}
	
	public function getControl()
	{
		return $this->Control;
	}

	public function hasPermission($moduleid, $action) 
	{
		$allow = false;
		if (count($this->permission)) 
		{
			$moduleid = trim($moduleid);
			$action = trim($action);
			foreach($this->permission as $item)
			{
				@$arr = split("-",$item);
				if($arr[0] ==$moduleid && $arr[1] == $action )
					$allow = true;
			}
		}
		
		return $allow;
	}
  
  	public function isLogged() {
    	if(count($this->session->data['member'])){	
			return true;
		}
		
		return false;
  	}
  
  	public function getId() {
    	return $this->userid;
  	}
	
	public function getUserTypeId() {
    	return $this->usertypeid;
  	}
	
	public function getSiteId() {
    	return $this->siteid;
  	}
	
  	public function getUserName() {
		
    	return $this->username;
  	}
	
	public function getPermission() {
		return $this->permission;
	}
	
	
	
//BENGIN PERMISSION JSON
	
	
	//return array
	public function _getJSONArray($strJSON)
	{
		//$this->json  = Registry::get('json');
		$arr = array();
		if($strJSON != "") return $this->json->decode($strJSON);
		return $arr;
	}
	
	//return array
	public function _getModules($arrJSON)
	{
		$arr = array();
		if(count($arrJSON) > 0)
		{
			return $arrJSON[0];
		}
		return $arr;
	}


	public function _getModules_Filter($arrJSON)
	{
		$arr = array();
			
		if(count($arrJSON) > 0)
		{
			
			if(count($arrJSON[0]) > 0)
			{
				foreach($arrJSON[0] as $moduleid)
				{
					$arrP = $this->_getPermissions($moduleid, $arrJSON);
					$arrS = $this->_getSitemaps($moduleid, $arrJSON);
					if(count($arrP) > 0 || count($arrS) > 0)
					{
						array_push($arr, $moduleid);
					}
				}
			}
		}
		return $arr;
	}
	
	private function writelog()
	{
		$starttime = $this->date->getToday();
		$sessionid = session_id();
		$username  = $this->username;
		$ip = $_SERVER['REMOTE_ADDR'];
		//kiem tra co id chua
		$sql = "SELECT * 
				FROM `user_stats`
				WHERE sessionid = '".$sessionid."'
				" ;
		$query = $this->db->query($sql);
		if($query->num_rows==0)
		{
			$query = @unserialize(file_get_contents('http://ip-api.com/php/'.$ip));
			$country = $query['country'];
			$city = $query['city'];
			$sql = "INSERT INTO `user_stats` (
								`id` ,
								`starttime` ,
								`sessionid` ,
								`username` ,
								`ip`,
								`country`,
								`city`
								)
								VALUES (
								NULL , 
								'".$starttime."', 
								'".$sessionid."', 
								'".$username."', 
								'".$ip."',
								'".$country."',
								'".$city."'
								);";
			$this->db->query($sql);
		}
		else
		{
			$sql = "UPDATE `user_stats` SET 
					`starttime` = '".$starttime."',
					`username` = '".$username."',
					`ip` = '".$ip."'
					
					WHERE `user_stats`.`sessionid` ='".$sessionid."'";
		}
		
		
	}
	
	public function getHitCounter()
	{
		if(!isset($_SESSION['hitCounter']))
		{
			$sql = "SELECT count(id) as count FROM `user_stats`";
			$query = $this->db->query($sql);
			$_SESSION['hitCounter'] = $query->row['count'];	
		}
		return $_SESSION['hitCounter'];
		
	}
	
	public function getOnline()
	{
		$current_time = $this->date->getToday();
		$session_timelimit = 20; 
		$session_timout = $this->date->addMinutes($current_time,-$session_timelimit) ;
		
		$sql = "SELECT count(id) as count FROM `user_stats` WHERE `user_stats`.`starttime` >= '".$session_timout."'";
		$query = $this->db->query($sql);
		return $query->row['count'];
	}
	
	public function getOnlineInMonth()
	{
		$current_time = $this->date->getToday();
		$year = $this->date->getYear($current_time);
		$mon = $this->date->getMonth($current_time);
		$sql = "SELECT count(id) as count FROM `user_stats`
						WHERE YEAR(`starttime`) =".$year."
						AND MONTH(`starttime`) =".$mon;
		$query = $this->db->query($sql);
		return $query->row['count'];
	}
	
	private function updatelistonline()
	{
		$current_time = $this->date->getToday();
		$session_timelimit = 20; 
		$session_timout = $this->date->addMinutes($current_time,-$session_timelimit) ;
		//$sql="DELETE FROM `user_stats` WHERE `user_stats`.`starttime` <= '".$session_timout."'";
		//$this->db->query($sql);
	}
	
	//return array
	public function _getPermissions($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][0]) > 0)
		{
			return $arrJSON[$index][0];
		}

		return $arr;
	}
	
	//return array
	public function _getSitemaps($moduleid, $arrJSON)
	{
		$arr = array();
		
		$arrModule = $this->_getModules($arrJSON);
		
		$index = $this->string->inArray($moduleid, $arrModule) + 1;
		
		if($index > 0 && count($arrJSON[$index][1]) > 0)
		{
			return $arrJSON[$index][1];
		}

		return $arr;
	}
//END PERMISSION JSON
	
}
?>