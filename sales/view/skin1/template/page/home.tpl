
<div class="section">

	<div class="section-title">Bán hàng</div>
    
    <div class="section-content">
    	<div id="showdanhmuc" class="left" style="width:20%">
        	
        </div>
        <div  class="left" style="width:80%">
        	
        	<div id="search">
            	<label>Từ khóa:</label>
                <input type="text" class="text" id="keyword"/>
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
    $('#showdanhmuc').load('?route=page/home/productCat');
	pro.loadProduct(pro.url+"&"+strurl);
	$('#keyword').keyup(function(e) {
		pro.searchForm();
	});
	
	
});
function Product()
{
	this.url = "?route=page/home/getList";
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