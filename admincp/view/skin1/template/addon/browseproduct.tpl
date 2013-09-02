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
<div id="frmAddSanPham" style="display:none"></div>
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
    $("#frmAddSanPham").attr('title','Thêm nhanh sản phẩm');
	$("#frmAddSanPham").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: 500,
		height: 500,
		modal: true,
		buttons: {
			
			
			'Chọn': function() 
			{
				$('#productselect .listid').each(function(index, element) {
					//alert($(this).val());
					var id = 0;
					var mediaid = $(this).val();
					
					
					var code = $(this).attr('code');
					var unit = $(this).attr('unit');
					var title = $(this).attr('title');
					
					objdl.addRow(id,mediaid,code,title,1,unit,0);
				});
				$(this).dialog("close");
			},
			
		}
	});

	
	$("#frmAddSanPham").load("?route=addon/order/showProductForm",function(){
		$("#frmAddSanPham").dialog("open");	
	});
});
function loadData(url)
{
	$('#productlist').html(loading);
	$('#productlist').load(url);
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
/*$('#keyword').keyup(function(e) {
	searchForm();
});
$('#sitemapid').change(function(e) {
    searchForm();
});*/
</script>