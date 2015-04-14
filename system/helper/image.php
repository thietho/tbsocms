<?php
final class HelperImage {
	static public function resize($filepath, $width, $height, $color = "#FFFFFF") {
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		} 
		
		if ($filepath == "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		}
	
		$old_image = $filepath;
		
		$new_image = eregi_replace('[/]', '_', $filepath);
		$new_image = eregi_replace('\.([a-z]{3,4})', '_' . $width . 'x' . $height . '.png', $new_image);
		$new_image = 'cache/' . $new_image;

		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$old_image = HelperImage::getDefaultCache($filepath);
			$image = new Image(DIR_FILE . $old_image);
			$image->resize($width, $height, $color);
			$image->save(DIR_FILE . $new_image);
			unset($image);
		}
		else{
		
		}
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $new_image;
		} else {
			return HTTPS_IMAGE . $new_image;
		}
		
		return $new_image;
	}
	static private function getFile($filepath)
	{
		$arr =  split('/',$filepath);
		print_r($arr);
		
		$url = IMAGE_SERVER.urldecode($filepath);
		
		$content = file_get_contents(IMAGE_SERVER."?path=".base64_encode($filepath));
		if($content!='')
		{
			$path = DIR_FILE;
			for($i=0;$i<count($arr);$i++);
			{
				echo count($arr);
				if($key < count($arr-1))
				{
					$path .= $val."/";
					if(!is_dir($path))
					{
						mkdir($path,0777);
					}
				}
				else
				{
					file_put_contents($path."/".$val,$content);	
				}
			}
			
		}
	}
	static public function resizePNG($filepath, $width, $height) {
		
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			HelperImage::getFile($filepath);
			$filepath = HelperImage::getDefaultCache($filepath);
		}
		
		if ($filepath == "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		} 
		
		$old_image = $filepath;
		
		@$new_image = eregi_replace('[/]', '_', $filepath);
		@$new_image = eregi_replace('\.([a-z]{3,4})', '_' . $width . 'x' . $height . '.png', $new_image);
		$new_image = str_replace(' ','-',$new_image);
		$new_image = 'cache/' . $new_image;
		
		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$old_image = HelperImage::getDefaultCache($filepath);
			$image = new Image(DIR_FILE . $old_image);
			$image->resizePNG($width, $height, DIR_FILE . $new_image);
			$image->save(DIR_FILE . $new_image);
			unset($image);
		}
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $new_image;
		} else {
			return HTTPS_IMAGE . $new_image;
		}
		
		return $new_image;
	}
	
	static public function getDefaultCache($filepath, $width = 1200, $height = 900) {
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			$filepath = "default/default.png";
		} 
		
		if($filepath == "")
		{
			$filepath = "default/default.png";
		}
		
		$old_image = $filepath;
		
		@$new_image = eregi_replace('[/]', '_', $filepath);
		@$new_image = eregi_replace('\.([a-z]{3,4})', '.png' , $new_image);
		$new_image = 'cache/' . $new_image;

		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$image = new Image(DIR_FILE . $old_image);
			$image->resizePNG($width, $height, DIR_FILE . $new_image);
			$image->save(DIR_FILE . $new_image, false);
			unset($image);
		}
		
		return $new_image;
	}
	
	static public function autosizePNG($filepath, $width, $height) {
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		} 
		
		if ($filepath == "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		}
		
		$old_image = $filepath;
		
		$new_image = eregi_replace('[/]', '_', $filepath);
		$new_image = eregi_replace('\.([a-z]{3,4})', '_auto_' . $width . 'x' . $height . '.png', $new_image);
		$new_image = 'cache/' . $new_image;

		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$old_image = HelperImage::getDefaultCache($filepath);
			$image = new Image(DIR_FILE . $old_image);
			$image->autosizePNG($width, $height, DIR_FILE . $new_image);
			$image->save(DIR_FILE . $new_image);
			unset($image);
		}
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $new_image;
		} else {
			return HTTPS_IMAGE . $new_image;
		}
		
		return $new_image;
	}
	
	static public function fixsize($filepath, $width, $height) {

		
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		} 
		
		if ($filepath == "") {
			$filepath = HelperImage::getDefaultCache($filepath);
		}
		
		
		$old_image = $filepath;
		
		$new_image = eregi_replace('[/]', '_', $filepath);
		$new_image = eregi_replace('\.([a-z]{3,4})', '_fix_' . $width . 'x' . $height . '.png', $new_image);
		$new_image = 'cache/' . $new_image;

		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$old_image = HelperImage::getDefaultCache($filepath);
			$image = new Image(DIR_FILE . $old_image);
			$image->fixsize($width, $height, DIR_FILE . $new_image);
			$image->save(DIR_FILE . $new_image);
			unset($image);
		}
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $new_image;
		} else {
			return HTTPS_IMAGE . $new_image;
		}
		
		return $new_image;
	}
	
	
	static public function resizeEditor($filepath, $width, $height) {
	
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			return;
		} 
	
		$old_image = $filepath;
		
		$new_image = eregi_replace('[/]', '_', $filepath);
		$new_image = eregi_replace('\.([a-z]{3,4})', '_' . $width . 'x' . $height . '.png', $new_image);
		if (!is_dir(DIR_FILE.'editor'))
			mkdir( DIR_FILE.'editor' , 0777 );
		$new_image = 'editor/' . $new_image;

		if (!file_exists(DIR_FILE . $new_image) || (filemtime(DIR_FILE . $old_image) > filemtime(DIR_FILE . $new_image))) {
			$old_image = HelperImage::getDefaultCache($filepath);
			$image = new Image(DIR_FILE . $old_image);
			$image->resize($width, $height, DIR_FILE . $new_image);
			$image->save(DIR_FILE . $new_image);
			unset($image);
		}
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $new_image;
		} else {
			return HTTPS_IMAGE . $new_image;
		}
		
		return $new_image;
	}
	
	
	static public function resize_root($filepath, $width, $height) {
		//$filepath = $this->getDefaultCache($filepath);
		if (!file_exists(DIR_FILE . $filepath) && $filepath != "") {
			return;
		} 
		
		$image = new Image(DIR_FILE . $filepath);
		$image->resize($width, $height, DIR_FILE . $filepath);
		$image->delete(DIR_FILE . $filepath);
		$image->save(DIR_FILE . $filepath);
		unset($image);
		
		if (@$_SERVER['HTTPS'] != 'on') {
			return HTTP_IMAGE . $filepath;
		} else {
			return HTTPS_IMAGE . $filepath;
		}
		
		return $filepath;
	}
}
?>