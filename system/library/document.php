<?php
final class Document {
	public $title;
	public $description;
	public $base;	
	public $charset = 'utf-8';		
	public $language = 'vi';	
	public $direction = 'ltr';		
	public $links = array();		
	public $styles = array();
	public $scripts = array();
	public $breadcrumbs;
	public $sitemapid = '';
	public $media = array();
	public $meta_description = '';
	public $meta_keyword = '';
	public $meta_image = '';
	public $sitebar =array();
	public $text = array();
	public $setting = array();
	public $setup = array();
	public $productdisplay = array(
						   '' => "Chi tiết",
						   'compact' => "Rút gọn",
						   
						   );
	public $status = array(
						   'new' => "Đơn hàng mới",
						   'wait' => "Đang xử lý",
						   'pending' => "Xát với khách hàng không được",
						   'confirmed' => "Đã xát nhận",
						   'completed' => "Hoàn thành",
						   'cancel' => "Hủy đơn hàng"
						   );
	public $status_phieunhapxuat = array(
						   'new' => "Chưa giao",
						   'delivered' => "Đã giao",
						   
						   );
	public $status_media = array(
						   'active' => "Hiện",
						   'hide' => "Ẩn"
						   
						   );
	public $paymenttype = array(
							'cash'=>'Tiền mặt',
							'bank' =>'Chuyển khoản'
							);
	public $gioitinh = array(
							'male' => "Nam",
							'female' => "Nữ"
							);
	public $status_comment = array(
						   'new' => "Chưa duyệt",
						   'published' => "Duyệt",
						   'denial' => "Không duyệt"
						   );
	public $userstatus = array(
							'active' => "Đang kích hoạt",
							'lock' => "Đã bị khóa"
							);
	public $tiente = array(
						"VND" => "VNĐ",
						"USD" => "USD"
						);
	public $tientechu = array(
						"VND" => "đồng",
						"USD" => "usd"
						);
	public $mediatypes = array(
						'module/product'=>'Product',
						'module/news'=>'News'
						);
	public $shoptype = array(
						'retail' => "Cửa hàng bán lẻ",
						'saleoflot' => "Cửa hàng bán sỉ"
						);
	public function toVND($value,$donvi)
	{
		if($donvi == "VND")
			return $value;
		else
		{
			
			return $value * $this->toNumber($this->setup['Exchange']); 	
		}
			
	}
	private $filepath;
	public function __construct() 
	{
		$this->db = Registry::get('db');
		$this->language = Registry::get('language');
		$this->text = $this->language->getData();
		$this->meta_image = HTTP_IMAGE."default/default.png";
		$this->filepath = DIR_FILE."db/setting.json";
		$this->createDB();
		$this->getData();
		$this->loadSetting();
		$this->title = $this->setup['Title'];
	}
	
	private function loadSetting()
	{
		$sql = "Select `media_information`.* 
									from `media_information` Where mediaid = 'setting'";
		$query = $this->db->query($sql);
		foreach($query->rows as $item)
		{
			$this->setup[$item['fieldname']] = $item['fieldvalue'];
		}
		
	}
	
	private function createDB()
	{
		$arr = array();
		if(!is_dir(DIR_FILE."db"))
			mkdir(DIR_FILE."db");
		
		if(!is_file($this->filepath))
		{
			
			$fp = fopen($this->filepath, 'w');
			fwrite($fp, '');
			fclose($fp);	
		}
	}
	
	private function getData()
	{
		$filename = $this->filepath;
		$handle = fopen($filename, "r");
		@$contents = fread($handle, filesize($filename));
		fclose($handle);
		$this->setting = json_decode($contents);
		
	}
	
	public function setValue($key,$value)
	{
		$this->setting->$key = $value;
		$this->saveData();
	}
	
	private function saveData()
	{
		$str = json_encode($this->setting);
		$fp = fopen($this->filepath, 'w');
		fwrite($fp, $str);
		fclose($fp);
	}
	
	public function getSiteMap($sitemapid,$siteid,$name="sitemapname")
	{
		$query = $this->db->query("Select `sitemap`.* 
									from `sitemap` 
									where sitemapid ='".$sitemapid."' AND siteid = '".$siteid."'");
		return $query->row[$name];	
	}
	
	public function getCategory($categoryid,$name="categoryname")
	{
		$query = $this->db->query("Select `category`.* 
									from `category` 
									where categoryid ='".$categoryid."' ");
		return $query->row[$name];	
	}
	
	public function getMedia($mediaid,$name="title")
	{
		$query = $this->db->query("Select `media`.* 
									from `media` 
									where mediaid ='".$mediaid."' ");
		return $query->row[$name];	
	}
	public function productName($mediaid)
	{
		if(!is_array( $mediaid))
		{
			$query = $this->db->query("Select `media`.* 
										from `media` 
										where mediaid ='".$mediaid."' ");
			$media = $query->row;
		}
		else
		{
			$media = $mediaid;	
		}
		$productname = $media['title'];
		if($media['code'])
			$productname .= " - ".$media['code'];
		if($media['sizes'])
			$productname .= " ".$media['sizes'];
		if($media['color'])
			$productname .= " ".$media['color'];
		return $productname;
		
	}
	public function getNhanVien($id,$name = 'hoten')
	{
		$sql = "Select `qlknhanvien`.* 
									from `qlknhanvien` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	
	public function getUserType($usertypeid,$name = 'usertypename')
	{
		$sql = "Select `usertype`.* 
									from `usertype` 
									where usertypeid ='".$usertypeid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function getUser($userid,$name = 'fullname')
	{
		$sql = "Select `user`.* 
									from `user` 
									where userid ='".$userid."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getCustomer($id,$name = 'fullname')
	{
		$sql = "Select `user`.* 
									from `user` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getModule($id,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where id ='".$id."' ");
		return $query->row[$name];	
	}
	public function getModuleId($moduleid,$name = 'modulename')
	{
		$query = $this->db->query("Select `module`.* 
									from `module` 
									where moduleid ='".$moduleid."' ");
		return $query->row[$name];	
	}
	
	public function getDonViTinh($madonvi,$name="tendonvitinh")
	{
		$query = $this->db->query("Select `qlkdonvitinh`.* 
									from `qlkdonvitinh` 
									where madonvi ='".$madonvi."' ");
		return $query->row[$name];	
	}
	
	public function getNguyenLieu($id,$name = 'tennguyenlieu')
	{
		$sql = "Select `qlknguyenlieu`.* 
									from `qlknguyenlieu` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getNhaCungCap($id,$name = 'tennhacungcap')
	{
		$sql = "Select `qlknhacungcap`.* 
									from `qlknhacungcap` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	public function getSanPham($id,$name = 'tensanpham')
	{
		$sql = "Select `qlksanpham`.* 
									from `qlksanpham` 
									where id ='".$id."' ";
		$query = $this->db->query($sql);
		return $query->row[$name];
	}
	
	public function createLink($sitemap="",$id="",$key = "",$val = "")
	{
		$link = HTTP_SERVER;
		if($sitemap)
			$link.= $sitemap;
		if($id)
			$link.= '/'.$id;
		if($key)
			$link.= '/'.$key;
		if($val)
			$link.= '/'.$val;
		return $link.'.html';
	}
	
	public function createLinkShare($sitemap="",$id="",$key = "",$val = "")
	{
		$link = HTTP_SERVER;
		if($sitemap)
			$link.= $sitemap;
		if($id)
			$link.= '/'.$id;
		if($key)
			$link.= '/'.$key;
		if($val)
			$link.= '/'.$val;
		return $link.'_'.time().'.html';
	}
	
	public function getPara()
	{
		$uri = $_SERVER['REQUEST_URI'];
		@$arr = split("\?",$uri);
		
		@$listpara = split("&",$arr[1]);
		$para = array();
		foreach($listpara as $val)
		{
			@$ar = split("=",$val);	
			$para[$ar[0]] = $ar[1];
		}
		return $para;
	}
	public function getURI()
	{
		$uri = $_SERVER['REQUEST_URI'];
		
		
		
		return $uri;
	}
	public function httppost($url,$data)
	{
		$options = array(
			'http' => array(
				'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
				'method'  => 'POST',
				'content' => http_build_query($data),
			),
		);
		//print_r($options);
		$context  = stream_context_create($options);
		$result = file_get_contents($url, false, $context);
		return $result;
	}
	
	public function httpget($url,$data)
	{
		$options = array(
			'http' => array(
				'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
				'method'  => 'GET',
				'content' => http_build_query($data),
			),
		);
		$context  = stream_context_create($options);
		$result = file_get_contents($url, false, $context);
		return $result;
	}
	public function objectToArray(&$obj)
	{
		
		
		foreach($obj as $key => $item)
		{
			
			if(is_object($item))
			{	
				$obj[$key] = (array)$item;
				$this->objectToArray($item);
			}
		}
	}
	public function select($sql)
	{
		$url = HTTP_SERVICE.'?route=core/db/select';
		$data = array('sql' => base64_encode($sql));
		$str = $this->httppost($url,$data);
		$tb = json_decode($str);
		$this->objectToArray($tb);
		return $tb;
	}
	public function insertData($table,$field,$value)
	{
		$url = HTTP_SERVICE.'?route=core/db/insertData';
		$da = array(
						'table'=>$table,
						'field'=>$field,
						'value'=>$value
					);
		
		$id = $this->httppost($url,$da);
		return $id;
	}
	public function updateData($table,$field,$value,$where)
	{
		$url = HTTP_SERVICE.'?route=core/db/updateData';
		$da = array(
						'table'=>$table,
						'field'=>$field,
						'value'=>$value,
						'where'=> base64_encode($where)
					);
		
		$id = $this->httppost($url,$da);
	}
	public function deleteData($table,$where)
	{
		$url = HTTP_SERVICE.'?route=core/db/deleteData';
		$da = array(
						'table'=>$table,
						'where'=> base64_encode($where)
					);
		
		$id = $this->httppost($url,$da);
	}
	
	public function getNextIdVarChar($tablename,$tableid,$temp)
	{
	 	//echo $temp;
		$sql="SELECT $tableid FROM `$tablename` WHERE $tableid LIKE '$temp%'";
		$mid=$this->select($sql);
		
		//echo count($mid);
		if(count($mid)==0)
			return $temp."1";
		
		$mnum=array();
		for($i=0; $i<count($mid); $i++)
		{
			//echo $mid[$i][$tableid];
			//echo substr($mid[$i][$tableid],strlen($temp));
			array_push($mnum,substr($mid[$i][$tableid],strlen($temp)));
		}
		$max=0;
		//print_r($mnum);
		for($i=0; $i<count($mnum); $i++)
			if($max<intval($mnum[$i]))
				$max=intval($mnum[$i]);
		$nextid=$max+1;
		return $temp.$nextid;
	}
}
?>