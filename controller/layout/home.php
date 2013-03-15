<?php
class ControllerLayoutHome extends Controller
{
	public function index()
	{
		$this->data['title'] = $this->document->title;
		$this->data['meta_description'] = $this->document->meta_description;
		$this->data['meta_keyword'] = $this->document->meta_keyword;
		//
		$arr = split(',',$this->document->meta_image);
		$this->data['meta_image'] = "";
		
		if(count($arr))
		{
			foreach($arr as $item)
			{
				if($item)
					$this->data['meta_image'] .= '<meta content="'.$item.'" property="og:image">';
			}
		}
		
		$this->template="layout/home.tpl";
		$this->children=array(
			'common/header',
			'common/footer'
		);
		$this->render();
	}
}
?>