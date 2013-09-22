<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	<div id="showdanhmuc" class="left" style="width:20%">
        	
        </div>
        <div  class="left" style="width:80%">
        	<h2><?php echo $breadcrumb?></h2>
        	<div id="search">
            	<label>Từ khóa:</label>
                <input type="text" class="text" id="keyword" size="100"/>
                <input type="button" class="button" id="btnSearch" value="Tìm" />
            </div>
            <div class="right">
                <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                <a class="button" href="?route=module/product/insert&sitemapid=<?php echo $sitemapid?>&page=<?php echo $page?>"><?php echo $button_add?></a>
                <a class="button" onclick="pro.viewListSelect()">Xem danh sách</a>
                
                <?php } ?>
                <?php if($this->user->checkPermission("module/product/update")==true){ ?>
                <a class="button" onclick="pro.updatePosition()"><?php echo $button_updateposition?></a>&nbsp;
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
$(document).ready(function(e) {
    $('#showdanhmuc').load('?route=module/product/productCat');
	pro.loadProduct(pro.url+"&page=<?php echo $_GET['page']?>");
	$('#btnSearch').click(function(e) {
		pro.searchForm();
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

function Product()
{
	this.url = "?route=module/product/getList&sitemapid=<?php echo $sitemapid?>";
	this.loadProduct = function(url)
	{
		$('#showsanpham').html(loading);
		$('#showsanpham').load(url);
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
		url = this.url;
		if($('#keyword').val()!="")
		{
			url += "&keyword="+encodeURI($('#keyword').val());
		}
		this.loadProduct(url);
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
				width: 800,
				height: 600,
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
		
			
			$(eid).load("?route=module/product/listProductSelected",function(){
				$(eid).dialog("open");	
			});
	}
	this.enterGroup = function(mediaid)
	{
		$('#selectmediaid').val(mediaid);
		$('#notification').html("Chọn sản phẩm để làm qui cách");
		$('.enterGroup').hide();
		$('.selectGroup').show();
	}
	this.selectGroup = function(mediaid)
	{
		$.post("?route=core/media/updateCol",
			{
				mediaid:$('#selectmediaid').val(),
				col:'mediaparent',
				val:mediaid
			},
			function(data){
				if(data == 'true')	
				{
					alert("Đưa vào nhóm thành công");	
					window.location.reload();
				}
			});
	}
	this.outGroup = function(mediaid)
	{
		$.post("?route=core/media/updateCol",
			{
				mediaid:mediaid,
				col:'mediaparent',
				val:''
			},
			function(data){
				if(data == 'true')	
				{
					alert("Đưa ra nhóm thành công");
					window.location.reload();
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
							window.location.reload();
							
						}
					}
			);
		}
	}
	this.updatePosition = function()
	{
		$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
		$.post("?route=core/postlist/updatePosition", $("#postlist").serialize(), function(data){
			pro.loadProduct(pro.url);
			$.unblockUI();
		});	
	}
}
var pro = new Product();

</script>