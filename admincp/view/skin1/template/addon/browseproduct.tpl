<div id="productseach">
	<p>
		<label>Tên sản phẩm</label>
        <input type="text" class="text" id="keyword" name="keyword"/>
        <label>Danh mục</label>
        <select id="sitemapid" name="sitemapid">
        	<option value=""></option>
            <?php foreach($data_danhmuc as $danhmuc){ ?>
            <?php if($danhmuc['moduleid']== 'module/product'){ ?>
            <option value="<?php echo $danhmuc['sitemapid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$danhmuc['level']) ?><?php echo $danhmuc['sitemapname']?></option>
            <?php } ?>
            <?php } ?>
        </select>
        <input type="button" class="button" id="btnSeachProduct" value="Tìm sản phẩm"/>
        <input type="button" class="button" id="btnAddProduct" value="Thêm"/>
        
    </p>
</div>

<div class="clearer">^&nbsp;</div>
<div id="productlist" class="left">
	
</div>
<div id="productselect" class="right">
	
</div>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
$(document).ready(function(e) {
    //loadData("?route=addon/order/listProduct");
});

$('#btnAddProduct').click(function(e) {
    addQuickProduct();
});
function loadData(url)
{
	$('#productlist').html(loading);
	$('#productlist').load(url,function(){
		$('.price-item').click(function(e) {
				var obj = new Object();
				obj.mediaid = $(this).attr('ref');
				obj.imagepath = $(this).attr('image');
				obj.title = $(this).attr('title');
				obj.code = $(this).attr('code');
				obj.unit = $(this).attr('unit');
				if($(this).attr('pricepromotion') == 0)
					obj.price = $(this).attr('price');
				else
					obj.price = $(this).attr('pricepromotion');
				
				var html = '<div><input type="button" class="button removeselect" value="X"><br><input type="hidden" class="listid" value="'+obj.mediaid+'" image="'+ obj.imagepath +'" code="'+ obj.code +'" unit="'+ obj.unit +'" title="'+ obj.title +'" price="'+obj.price+'">';
				html+='<img src="'+ obj.imagepath +'"><br>'
				html+= obj.title+'<br>'+ formateNumber(obj.price) +'</div>';
				$('#productselect').append(html);
				$('.removeselect').click(function(e) {
					$(this).parent().remove();
				});
				
			});
			$('.product-item').hover(
				function()
				{
					$(this).children('div').show();
					
				},function()
				{
					$(this).children('div').hide();
				});
		
		});
}
function searchForm()
{
	var url ="?route=addon/order/listProduct";
	if($("#keyword").val() != "")
		url += "&keyword=" + encodeURI($('#keyword').val());
	if($("#sitemapid").val() != "")
		url += "&sitemapid=" + $('#sitemapid').val();
    loadData(url);
}
$('#btnSeachProduct').click(function(e) {
    searchForm();
});
$('#keyword').keyup(function(e) {
    if(e.keyCode==13)
	{
		searchForm();
	}
});
/*$('#keyword').keyup(function(e) {
	searchForm();
});
$('#sitemapid').change(function(e) {
    searchForm();
});*/
</script>