<table class="data-table">
	<tr>
    	
        <th>Tên sản phẩm</th>
        
        <th>Giá</th>
        <th>Giảm</th>
        <th>Giá khuyến mãi</th>
        <th>Số lượng</th>
        <th>Hình</th>
    </tr>
    
    <?php 
    if(count($medias))
    	foreach($medias as $media){ ?>
    <tr class="item" mediaid="<?php echo $media['mediaid']?>">
    	
        <td><?php echo $this->document->productName($media)?></td>
        
        
        <td class="number">
            <input id="price" type="text" class="text number short ProductList" name="price[<?php echo $media['mediaid']?>]" value="<?php echo $media['price']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td class="number">
            <input id="discountpercent" type="text" class="text number short ProductList" name="discountpercent[<?php echo $media['mediaid']?>]" value="<?php echo $media['discountpercent']?>" mediaid="<?php echo $media['mediaid']?>"/>%
        </td>
        <td class="number">
            <input id="pricepromotion" type="text" class="text number short ProductList" name="pricepromotion[<?php echo $media['mediaid']?>]" value="<?php echo $this->string->numberFormate($media['pricepromotion'])?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td class="number">
        	<input id="qty" type="text" class="text number short ProductList" name="qty[<?php echo $media['mediaid']?>]" value="<?php echo $media['qty']?>" mediaid="<?php echo $media['mediaid']?>"/>
        </td>
        <td><img src="<?php echo $media['imagepreview']?>"></td>
    </tr>
    <?php } ?>
</table>
<script language="javascript">
$(document).ready(function(e) {
    numberReady();
});
$('.item').click(function(e) {
	if($(this).hasClass('itemselected'))
		$(this).removeClass('itemselected');
	else
    	$(this).addClass('itemselected');
});
$('.ProductList').keyup(function(e) {
    var mediaid = $(this).attr('mediaid');
	var col = this.id
	var val = this.value;
	$.get("?route=module/product/updateProductList",{
		mediaid:mediaid,
		col:col,
		val:val
	});
});
</script>