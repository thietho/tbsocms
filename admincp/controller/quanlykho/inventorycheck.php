<?php
class ControllerQuanlykhoInventorycheck extends Controller
{
	private $error = array();
	function __construct() 
	{
		@$this->load->model("core/module");
		$moduleid = $_GET['route'];
		@$this->document->title = @$this->model_core_module->getBreadcrumbs($moduleid);
		if(@$this->user->checkPermission($moduleid)==false)
		{
			@$this->response->redirect('?route=page/home');
		}
		@$this->load->model("quanlykho/donvitinh");
		@$this->load->model("quanlykho/inventory");
		@$this->load->model("core/sitemap");
		@$this->load->model("core/media");
		
		@$this->load->model("core/user");
		@$this->load->helper('image');
		@$this->load->model("core/category");
		@$this->load->model("sales/shop");
		
		$where = " ORDER BY shopname";
		@$this->data['data_shop'] = @$this->model_sales_shop->getList($where);
	}
	
	function index()
	{
		@$this->id='content';
		@$this->template='quanlykho/inventorycheck.tpl';
		@$this->layout='layout/center';
		@$this->render();
	}
	public function insert()
	{	
    	@$this->getForm();
	}
	
	public function update()
	{
		@$this->load->model("sales/shop");
		@$this->data['haspass'] = false;
		@$this->data['readonly'] = 'readonly="readonly"';
		
		@$this->getForm();
		
  	}
	
	public function delete() 
	{
		$listid=@$this->request->post['delete'];
		if(count($listid))
		{
			foreach($listid as $id)
			{
				@$this->model_quanlykho_inventory->delete($id);	
			}
			
			@$this->data['output'] = "Xóa thành công";
		}
		@$this->id="content";
		@$this->template="common/output.tpl";
		@$this->render();
  	}
	
	public function getList() 
	{
		
		@$this->data['datas'] = array();
		$where = "";
		
		$rows = @$this->model_quanlykho_inventory->getList($where.'ORDER BY `datecheck` DESC');
		//Page
		@$page = @$this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		@$this->data['pager']  = @$this->pager->pageLayoutAjax($total, $limit, $page,"#listinventory");
		
		$pager  = @$this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && @count(@$rows[$i])>0;$i++)
		{
			@$this->data['datas'][$i] = $rows[$i];
			@$this->data['datas'][$i]['link_edit'] = @$this->url->http('quanlykho/inventorycheck/update&id='.@$this->data['datas'][$i]['id']);
			@$this->data['datas'][$i]['text_edit'] = "Sửa";
			
		}
		@$this->data['refres']=$_SERVER['QUERY_STRING'];
		@$this->id='content';
		@$this->template="quanlykho/inventorycheck_table.tpl";
		@$this->render();
	}
	
	private function getForm()
	{
		@$this->load->helper('image');
		
		if ((isset($this->request->get['id'])) ) 
		{
			$id = @$this->request->get['id'];
      		@$this->data['item'] = @$this->model_quanlykho_inventory->getItem($id);
			$where = " AND inventoryid = '".$id."' ORDER BY `position` ASC";
			@$this->data['data_detail'] = @$this->model_quanlykho_inventory->getInventoryDetailList($where);
			
    	}
		else
		{
			@$this->data['item']['nhanvienid'] = @$this->user->nhanvien['id'];
		}
		
		@$this->id='content';
		@$this->template='quanlykho/inventorycheck_form.tpl';
		@$this->layout="layout/center";
		
		@$this->render();
	}
	
	public function save()
	{
		$data = @$this->request->post;
		
		if(@$this->validateForm($data))
		{
			$data['datecheck'] = @$this->date->formatViewDate($data['datecheck']);
			$data = @$this->model_quanlykho_inventory->save($data);
			$data['error'] = "";
		}
		else
		{
			foreach(@$this->error as $item)
			{
				$data['error'] .= $item."<br>";
			}
		}
		@$this->data['output'] = json_encode($data);
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	public function delDetail()
	{
		//Xoa dinh luong
		$data = @$this->request->post;
		$delid = $data['delinventoryid'];
		if(@$delid)
		{
			@$arr_id = split(",",$delid);
			print_r($arr_id);
			if(count($arr_id))
			{
				
				foreach($arr_id as $id)
				{
					if(@$id)
						@$this->model_quanlykho_inventory->deleteInventoryDetail($id);
				}
				
			}
		}
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	public function saveDetail()
	{
		//Save chi tiet phieu nhap
		$data = @$this->request->post;
		if(@$data['mediaid'])
		{
			$data['quantity'] = @$this->string->toNumber($data['quantity']);
			$data = @$this->model_quanlykho_inventory->saveInventoryDetail($data);
			$data['error'] = '';
		}
		else
		{
			$data['error'] = 'false';	
		}
		@$this->data['output'] = json_encode($data);
		@$this->id='content';
		@$this->template='common/output.tpl';
		@$this->render();
	}
	private function validateForm($data)
	{
    	
		
		if(@$data['datecheck'] == "") 
		{
      		@$this->error['datecheck'] = "Bạn chưa chọn ngày";
    	}
		
		
		
		
		
		if (count(@$this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
	public function check()
	{
		$where = " ORDER BY `datecheck` DESC";
		$data = @$this->model_quanlykho_inventory->getList($where);
		$id = $data[0]['id'];
		@$this->data['item'] = @$this->model_quanlykho_inventory->getItem($id);
		$where = " AND inventoryid = '".$id."' ORDER BY `position` ASC";
		@$this->data['data_detail'] = @$this->model_quanlykho_inventory->getInventoryDetailList($where);
		
		$where = " AND mediatype = 'module/product' AND inventory <> 0";
		$where .= " Order by code";
		$rows = @$this->model_core_media->getList($where);
		@$this->data['inlist'] = array();
		@$this->data['outlist'] = array();
		//echo count($rows);
		foreach($rows as $key => $media)
		{
			$flag = false;
			foreach(@$this->data['data_detail'] as $detail)
			{
				//Cac san pham trong list khiem kho ma so luong ton khong khop
				if(@$media['mediaid'] == $detail['mediaid'] && $media['inventory']!=$detail['quantity'])
				{
					@$this->data['inlist'][$key] = $media;
					@$this->data['inlist'][$key]['quantity'] = $detail['quantity'];
					@$this->data['inlist'][$key]['unitdetail'] = $detail['unit'];
				}
				if(@$media['mediaid'] == $detail['mediaid'])
					$flag = true;
			}
			//Cac san pham co ton ma ko co trong list kiem kho
			
			if(@$flag == false)
			{
				@$this->data['outlist'][$key] = $media;	
			}
		}
		
		@$this->id='content';
		@$this->template='quanlykho/inventorycheck_check.tpl';
		@$this->layout='layout/center';
		@$this->render();
	}
}