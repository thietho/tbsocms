<?php
final class Cache { 
	private $expire = 84600;

  	public function __construct() {
		$files = glob(DIR_CACHE . '*');
    	if(count($files))
		{
			foreach ($files as $file) 
			{
				
				$time = fileatime($file);
				if (time()- $time > $this->expire * 7)
				{
					unlink($file);
				}
				
			}
		}
  	}

	public function get($key) {
    	foreach (glob(DIR_CACHE . 'cache.' . $key . '.*') as $file) {
      		$handle = fopen($file, 'r');
      		$cache  = fread($handle, filesize($file));
	  
      		fclose($handle);

      		return unserialize($cache);
    	}
  	}

  	public function set($key, $value) {
    	$this->delete($key);
		if (!is_dir(DIR_CACHE))
			mkdir( DIR_CACHE , 0777 );
		$file = DIR_CACHE . 'cache.' . $key . '.' . (time() + $this->expire);
    	
		$handle = fopen($file, 'w');

    	fwrite($handle, serialize($value));
		
    	fclose($handle);
  	}
	
  	public function delete($key) {
		
		
		$files = glob(DIR_CACHE . '*'.$key."*");
		
    	if(count($files)>0)
		{
			foreach ($files as $file) 
			{
				@unlink($file);
			}	
		}
  	}
	public function clear()
	{
		$files = glob(DIR_CACHE . '*');
		
    	if(count($files)>0)
		{
			foreach ($files as $file) 
			{
				$time = filemtime($file);
				
				if (time() - $time > $this->expire) {
					@unlink($file);
				}
			}	
		}
	}
}
?>