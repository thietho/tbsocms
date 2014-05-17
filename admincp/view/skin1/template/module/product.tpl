<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <div>
        	
            
        	<div id="search">
            	<label>Từ khóa:</label>
                <input type="text" class="text" id="keyword" size="100"/>
                <select id="brand">
                	<option value="">Tất cả nhản hiệu</option>
                    <?php foreach($nhanhieu as $it){ ?>
                    <option value="<?php echo $it['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['categoryname']?></option>                        
                    <?php } ?>
                </select>
                <select id="sitemapid">
                	<option value="">Tất cả danh mục</option>
                    <?php foreach($sitemaps as $sitemap){ ?>
                    <?php if($sitemap['moduleid'] == 'module/product'){ ?>
                    <option value="<?php echo $sitemap['sitemapid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$sitemap['level']) ?><?php echo $sitemap['sitemapname']?></option>
                    <?php } ?>
                    <?php } ?>
                </select>
                <select id="status">            	
                	<option value=""></option>
                    <?php foreach($status as $it){ ?>
                    <option value="<?php echo $it['categoryid']?>"><?php echo $it['categoryname']?></option>
                    <?php } ?>
                </select>
                <input type="button" class="button" id="btnSearch" value="Tìm" />
                <input type="button" class="button" id="btnViewAll" value="Tất cả" />
                <input type="button" class="button" value="Sắp xếp" onclick="pro.showListSort()"/>
                
            </div>
            <div class="right">
                <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                <a class="button" onclick="showProductForm('','','pro.searchForm()');"><?php echo $button_add?></a>
                <a class="button" id="btnImport" onclick="pro.importData()">Import</a>
                <a class="button" id="btnExport" onclick="pro.exportData()">Export</a>
               
                <?php } ?>
                <a class="button" onclick="pro.viewListSelect()">Xem danh sách</a>
                <?php if($this->user->checkPermission("module/product/update")==true){ ?>
                <a class="button" onclick="pro.updatePosition()"><?php echo $button_updateposition?></a>
                <a class="button" href="?route=module/information&goback=module/product">Biên tập nội dung</a>
                
                <?php } ?>
                <?php if($this->user->checkPermission("module/product/deleted")==true){ ?>
                <a class="button" onclick="pro.deleteProduct()">Xóa</a>&nbsp;
                <?php } ?>
                <a class="button" href="index.php"><?php echo $button_cancel?></a>
            </div>
            <div class="clearer">^&nbsp;</div>
            <form id="postlist" name="postlist" method="post" action="">
            	<input type="hidden" id="selectmediaid" />
                <label id="notification"></label>
        		<div id="showsanpham"></div>
            </form>
        </div>
        <div class="clearer">^&nbsp;</div>
    </div>
</div>
<script language="javascript">
$('#search select').change(function(e) {
    pro.searchForm();
});


function Product()
{
	this.open = "<?php echo $this->request->get['open']?>";
	console.log(this.open);
	this.url = "?route=module/product/getList";
	this.page = 0;
	this.loadProduct = function(url)
	{
		//$('#showsanpham').html(loading);
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		$('#showsanpham').load(url,function(){$.unblockUI();});
	}
	this.add = function(parent,sitemapid)
	{
		addProduct(parent,sitemapid);
		
	}
	this.edit = function(mediaid)
	{
		editProduct(mediaid);
	}
	this.searchForm = function()
	{
		
		this.loadProduct(this.url+this.getUrl());
	}
	this.getUrl = function()
	{
		url = "";
		if($('#search #keyword').val()!="")
		{
			url += "&keyword="+encodeURI($('#search #keyword').val());
		}
		if($('#search #brand').val()!="")
		{
			url += "&brand="+encodeURI($('#search #brand').val());
		}
		if($('#search #sitemapid').val()!="")
		{
			url += "&sitemapid="+encodeURI($('#search #sitemapid').val());
		}
		if($('#search #status').val()!="")
		{
			url += "&status="+encodeURI($('#search #status').val());
		}
		
		url += "&page=" + Number(control.getParam("page",control.getUrl()));
		return url
	}
	this.addToList = function(mediaid)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		$.get("?route=module/product/addToList&mediaid="+mediaid,function(){
			$.unblockUI();	
		});
		/*$('.inputchk').each(function(index, element) {
            if(this.checked)
			{
				var mediaid = this.value;
				$.get("?route=module/product/addToList&mediaid="+mediaid);
			}
        });*/
	}
	this.removeListItem = function(mediaid)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		$.get("?route=module/product/removeListItem&mediaid="+mediaid,function(){
			$.unblockUI();	
		});	
	}
	this.viewListSelect = function()
	{
		$('body').append('<div id="listproduct" style="display:none"></div>');
		var eid = "#listproduct";
		$(eid).attr('title','Danh sách sản phẩm đươc chọn');
			$(eid).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				buttons: {
					'Xóa khỏi danh sách':function()
					{
						$('.itemselected').each(function(index, element) {
							var meidaid = $(this).attr('mediaid');
                            pro.removeListItem(meidaid);
                        });
						pro.viewListSelect();
					},
					'Lập phiếu nhập kho':function()
					{
						window.location = "?route=quanlykho/phieunhap/insert";
					},
					'Lập phiếu bán hàng':function()
					{
						window.location = "?route=quanlykho/phieuxuat/insert";
					},
					
					'Đóng': function() 
					{
						
						$( eid ).dialog( "close" );
					},
				}
			});
		
			$(eid).dialog("open");
			$(eid).html(loading);
			$(eid).load("?route=module/product/listProductSelected",function(){
				
			});
	}
	this.enterGroup = function(mediaid)
	{
		$('#selectmediaid').val(mediaid);
		$('#notification').html("Chọn sản phẩm để làm qui cách");
		$('.enterGroup').hide();
		$('.selectGroup').show();
	}
	this.selectGroup = function(des,sou)
	{
		
		$.post("?route=core/media/enterGroup",
			{
				mediaid:des,
				col:'mediaparent',
				val:sou
			},
			function(data){
				if(data == 'true')	
				{
					alert("Đưa vào nhóm thành công");	
					//window.location.reload();
					pro.searchForm();
					
				}
			});
	}
	this.outGroup = function(mediaid)
	{
		$.post("?route=core/media/outGroup",
			{
				mediaid:mediaid,
				col:'mediaparent',
				val:''
			},
			function(data){
				if(data == 'true')	
				{
					alert("Đưa ra nhóm thành công");
					//window.location.reload();
					pro.searchForm();
				}
			});
	}
	this.deleteProduct = function()
	{
		var answer = confirm("Bạn có chắc xóa không?")
		if (answer)
		{
			$.post("?route=core/media/delete", 
					$("#postlist").serialize(), 
					function(data)
					{
						if(data!="")
						{
							alert(data);
							//window.location.reload();
							pro.searchForm();
						}
					}
			);
		}
	}
	this.delete = function(mediaid)
	{
		var answer = confirm("Bạn có chắc xóa không?")
		if (answer)
		{
			$.post("?route=core/media/delete", 
					{delete:Array(mediaid)}, 
					function(data)
					{
						if(data!="")
						{
							alert(data);
							//window.location.reload();
							pro.searchForm();
						}
					}
			);
		}
	}
	this.updatePosition = function()
	{
		$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
		$.post("?route=core/postlist/updatePosition", $("#postlist").serialize(), function(data){
			pro.searchForm();
			$.unblockUI();
		});	
	}
	
	this.history = function(mediaid)
	{
		$('body').append('<div id="history_form" style="display:none"></div>');
		var eid = "#history_form";
		
		
		$(eid).attr('title','Lịch sử xuất nhập');
			$( eid ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close:function()
					{
						$(eid).remove();
					},
				
			});
		
			$(eid).dialog("open");
			$(eid).html(loading);
			$(eid).load("?route=module/product/history&mediaid="+mediaid+"&dialog=true",function(){
				
			});
		
		
	}
	this.importData = function()
	{
		$('body').append('<div id="history_form" style="display:none"></div>');
		var eid = "#history_form";
		
		
		$(eid).attr('title','Import dữ liệu');
			$( eid ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close:function()
					{
						$(eid).remove();
					},
				buttons: {
				
					'Import':function()
					{
						//$('#history_form').scrollTop(500);
						$('.item').removeClass('itemselected');
						$('#history_form').scrollTop(0)
						//alert(i)
						var k = 2;
						pro.postProduct(k);
						
					},
					'Đóng': function() 
					{
						
						$(eid).dialog( "close" );
						window.location.reload();
					},
				}
				
			});
		
			$(eid).dialog("open");	
			$(eid).html(loading);
			$(eid).load("?route=module/product/import&dialog=true",function(){
				
			});
	}
	this.postProduct = function(k)
	{
		$.post("?route=core/media/importProduct",
			{
				mediaid:$('#item'+k+' #A').html(),
				mediaparent:$('#item'+k+' #B').html(),
				code:$('#item'+k+' #C').html(),
				title:$('#item'+k+' #D').html(),
				color:$('#item'+k+' #E').html(),
				unit:$('#item'+k+' #F').html(),
				brand:$('#item'+k+' #G').html(),
				refersitemap:$('#item'+k+' #H').html(),
				price:$('#item'+k+' #I').html(),
				saleprice:$('#item'+k+' #J').html(),
				discountpercent:$('#item'+k+' #K').html(),
				pricepromotion:$('#item'+k+' #L').html(),
				summary:$('#item'+k+' #M').html(),
				
			},
			function(data)
			{
				
				$('#item'+k).addClass('itemselected');
				
				$('#history_form').scrollTop($('#history_form').scrollTop()+$('#item'+k).height());
				if(k<=i)
					pro.postProduct(k+1);
				else
					alert("Import dữ liệu thành công!");
			});
	}
	this.exportData = function()
	{
		$.get("?route=module/product/export",function(data){
			window.location = "download.php?url="+ encodeURI(data);
		});	
	}
	this.showListSort = function()
	{
		var eid = "listsort";
		$('body').append('<div id="'+eid+'" style="display:none"></div>');
		$('body').css('overflow','hidden');
		$("#"+eid).attr('title','Danh sách sản phẩm');
			$("#"+eid).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				close:function()
					{
						$("#"+eid).remove();
						$('body').css('overflow','auto');
					},
				buttons: {
					
					'Lưu':function()
					{
						$.post("?route=module/product/savesort",$('#frm_sortproduct').serialize(),
						function(data)
						{
							$("#"+eid).dialog( "close" );
							pro.searchForm();
						});
					},
					'Đóng': function() 
					{
						
						$("#"+eid).dialog( "close" );
						
					},
				}
			});
			
			$("#"+eid).dialog("open");
			$("#"+eid).html(loading);
			$("#"+eid).load("?route=module/product/listsort"+pro.getUrl()+"&dialog=true",function(){
				
			});
		}
}
var pro = new Product();
$(document).ready(function(e) {
    //$('#showdanhmuc').load('?route=module/product/productCat');
	pro.page = Number(control.getParam("page",control.getUrl()));
	
	pro.searchForm();
	//console.log("aa");
	$('#btnSearch').click(function(e) {
		
		pro.searchForm();
	});
	$('#btnViewAll').click(function(e) {
        $('#search #keyword').val('');
		$('#search #brand').val('');
		$('#search #sitemapid').val('');
		$('#search #status').val('');
		pro.searchForm();
		//window.location = "?route=module/product";
    });
	$('#keyword').keyup(function(e) {
        if(e.keyCode == 13)
			pro.searchForm();
    });
	
	$(document).ajaxComplete(function() {
		//alert($('#selectmediaid').val())
		if($('#selectmediaid').val()!="")
		{
			$('.enterGroup').hide();
			$('.selectGroup').show();
		}
		else
		{
			$('.enterGroup').show();
			$('.selectGroup').hide();
		}
	});
});
</script>