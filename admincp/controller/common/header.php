<?php
class ControllerCommonHeader extends Controller
{
	public function index()
	{
		@$this->load->model("core/media");
		@$this->load->helper('image');
		@$this->data['username'] = @$this->session->data['username'];
		@$this->data['sitename'] = @$this->session->data['sitename'];
		@$this->data['language'] = @$this->getLanguageCBX();
		$imagepath = @$this->model_core_media->getInformation("setting","brochure");
		@$this->loadGroup();
		if($imagepath != "")
		{
			@$this->data['imagepreview'] = "<img class='png' src='".HelperImage::resizePNG($imagepath, 150, 70)."' >";
		}
					
		@$this->id="header";
		@$this->template="common/header.tpl";
		@$this->render();
	}
	
	private function loadGroup()
	{
		@$this->load->model("core/module");
		@$this->user->getUserTypeId();
		//Lay cac module thuot usertype do ngoai admin
		if(@$this->user->getUserTypeId() != 'admin')
		{
			
			@$this->data['allow_modules'] = @$this->user->getAllowModule();
		}
		else
		{
			
			@$allow_modules = @$this->model_core_module->getList($where);
			@$this->data['allow_modules'] = @$this->string->matrixToArray($allow_modules,'moduleid');
		}
		
		@$this->data['group'] = @$this->model_core_module->getChild(0);
		
		foreach(@$this->data['group'] as $key => $item)
		{
			@$this->data['group'][$key]['module'] = @$this->model_core_module->getChild($item['id']);
		}
	}
	
	private function getLanguageCBX()
	{
		@$this->load->model("common/control");
		$languages = @$this->language->getLanguageList();
		$data = array();
		foreach($languages as $lang)
		{
			$data[$lang['code']] = $lang['name'];
		}
		
		$selectedvalue = @$this->session->data['language'];
		return @$this->model_common_control->getComboboxData("language", $data, $selectedvalue);
	}
	
}
?>