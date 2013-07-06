<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	<div id="showdanhmuc" class="left" style="width:20%">
        	
        </div>
        <div  class="left" style="width:80%">
        	<h2><?php echo $breadcrumb?></h2>
        	<div id="search">
            	<label>Từ khóa:</label>
                <input type="text" class="text" id="keyword"/>
            </div>
            <div class="right">
                <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                <a class="button" href="?route=module/product/insert&sitemapid=<?php echo $sitemapid?>&page=<?php echo $page?>"><?php echo $button_add?></a>&nbsp;
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
	$('#keyword').keyup(function(e) {
		pro.searchForm();
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
	this.searchForm = function()
	{
		url = this.url;
		if($('#keyword').val()!="")
		{
			url += "&keyword="+encodeURI($('#keyword').val());
		}
		this.loadProduct(url);
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
							alert(data)
							
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