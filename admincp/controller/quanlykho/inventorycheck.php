<?php
class ControllerQuanlykhoInventorycheck extends Controller
{
	private $error = array();
	function __construct() 
	{
		$this->load->model("core/module");
		$moduleid = $_GET['route'];
		$this->document->title = $this->model_core_module->getBreadcrumbs($moduleid);
		if($this->user->checkPermission($moduleid)==false)
		{
			$this->response->redirect('?route=page/home');
		}
		$this->load->model("quanlykho/donvitinh");
		$this->load->model("quanlykho/phieunhapxuat");
		$this->load->model("core/sitemap");
		$this->load->model("core/media");
		$this->load->model("module/baogia");
		$this->load->model("core/user");
		$this->load->helper('image');
		$this->load->model("core/category");
		$this->load->model("sales/shop");
		
		$where = " ORDER BY shopname";
		$this->data['data_shop'] = $this->model_sales_shop->getList($where);
	}
	
	function index()
	{
		$this->id='content';
		$this->template='quanlykho/inventorycheck.tpl';
		$this->layout='layout/center';
		$this->render();
	}
	public function insert()
	{	
    	$this->getForm();
	}
	
	public function update()
	{
		$this->load->model("sales/shop");
		$this->data['haspass'] = false;
		$this->data['readonly'] = 'readonly="readonly"';
		
		$this->getForm();
		
  	}
	
	public function delete() 
	{
		$listid=$this->request->post['delete'];
		//$listmadonvi=$_POST['delete'];
		$this->load->model("sales/shop");
		if(count($listid))
		{
			foreach($listid as $id)
			{
				$this->model_sales_shop->delete($id);	
			}
			
			$this->data['output'] = "Xóa thành công";
		}
		$this->id="content";
		$this->template="common/output.tpl";
		$this->render();
  	}
	
	public function getList() 
	{
		
		$this->load->model("core/user");
		
		$this->data['insert'] = $this->url->http('sales/shop/insert');
		$this->data['delete'] = $this->url->http('sales/shop/delete');		
		
		$this->data['datas'] = array();
		$where = "";
		
		
		$datasearchlike['shopname'] = urldecode($this->request->get['shopname']);
		
		$arr = array();
		foreach($datasearchlike as $key => $item)
		{
			if($item !="")
				$arr[] = " AND " . $key ." like '%".$item."%'";
		}
		
		
		
		$where = implode("",$arr);
		
		$rows = $this->model_sales_shop->getList($where);
		//Page
		$page = $this->request->get['page'];		
		$x=$page;		
		$limit = 20;
		$total = count($rows); 
		// work out the pager values 
		$this->data['pager']  = $this->pager->pageLayoutAjax($total, $limit, $page,"#listshop");
		
		$pager  = $this->pager->getPagerData($total, $limit, $page); 
		$offset = $pager->offset; 
		$limit  = $pager->limit; 
		$page   = $pager->page;
		for($i=$offset;$i < $offset + $limit && count($rows[$i])>0;$i++)
		{
			$this->data['datas'][$i] = $rows[$i];
			
			$this->data['datas'][$i]['link_edit'] = $this->url->http('sales/shop/update&id='.$this->data['datas'][$i]['id']);
			$this->data['datas'][$i]['text_edit'] = "Sửa";
			//Lay nhan vien cua của hang
			$where = " AND shopid =". $this->data['datas'][$i]['id'];
			$data_shopstaff = $this->model_sales_shop->getShopStaffList($where);
			$arr_staffid = $this->string->matrixToArray($data_shopstaff,'staffid');
			
			$this->data['datas'][$i]['arr_staffid'] =$arr_staffid;
			
		}
		$this->data['refres']=$_SERVER['QUERY_STRING'];
		$this->id='content';
		$this->template="sales/shop_table.tpl";
		
		if($this->request->get['opendialog']=='true')
		{
			$this->layout="";
			$this->data['dialog'] = true;
			
		}
		$this->render();
	}
	
	private function getForm()
	{
		$this->load->helper('image');
		
		if ((isset($this->request->get['id'])) ) 
		{
      		$this->data['item'] = $this->model_quanlykho_inventory->getItem($this->request->get['id']);
			
    	}
		
		$this->id='content';
		$this->template='quanlykho/inventorycheck_form.tpl';
		$this->layout="layout/center";
		
		$this->render();
	}
	
	public function save()
	{
		$data = $this->request->post;
		
		if($this->validateForm($data))
		{
			
			if($data['id']=="")
			{
				$data['id']=$this->model_sales_shop->insert($data);
			}
			else
			{
				$this->model_sales_shop->update($data);
			}
			
			$this->data['output'] = "true";
		}
		else
		{
			foreach($this->error as $item)
			{
				$this->data['output'] .= $item."<br>";
			}
		}
		$this->id='content';
		$this->template='common/output.tpl';
		$this->render();
	}
	
	private function validateForm($data)
	{
    	
		
		if ($data['shopname'] == "") 
		{
      		$this->error['shopname'] = "Bạn chưa nhập tên của hàng";
    	}
		
		
		
		
		
		if (count($this->error)==0) 
		{
	  		return TRUE;
		} else {
	  		return FALSE;
		}
	}
}