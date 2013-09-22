<table class="data-table">
	<tr>
    	<th>Code</th>
        <th>Tên sản phẩm</th>
        <th>Màu</th>
        <th>Giá</th>
        <th>Giảm</th>
        <th>Giá khuyến mãi</th>
        <th>Hình</th>
    </tr>
    
    <?php 
    if(count($medias))
    	foreach($medias as $media){ ?>
    <tr class="item" mediaid="<?php echo $media['mediaid']?>">
    	<td><?php echo $media['code']?></td>
        <td><?php echo $media['title']?></td>
        <td><?php echo $media['color']?></td>
        
        <td class="number">
            <b><?php echo $this->string->numberFormate($media['price'])?></b>
        </td>
        <td class="number">
            <b><?php echo $this->string->numberFormate($media['discountpercent'])?>%</b>
        </td>
        <td class="number"><b><?php echo $this->string->numberFormate($media['pricepromotion'])?></b></td>
        <td><img src="<?php echo $media['imagepreview']?>"></td>
    </tr>
    <?php } ?>
</table>
<script language="javascript">
$('.item').click(function(e) {
	if($(this).hasClass('itemselected'))
		$(this).removeClass('itemselected');
	else
    	$(this).addClass('itemselected');
});
</script>