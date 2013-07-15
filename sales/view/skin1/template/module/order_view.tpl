<h4>Mã đơn hàng: <?php echo $order['code']?></h4>
<table>
    <thead>
        <tr>            
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>ĐVT</th>
            <th>Giá bán</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
    	<?php foreach($data_ct as $ct){ ?>
        <?php $sum += $ct['subtotal']?>
        <tr>
        	<td><?php echo $ct['title']?></td>
            <td class="number">
            	<?php echo $this->string->numberFormate($ct['quantity'])?>
                <input type="button" class="button" value="+">
                <input type="button" class="button" value="-">
            </td>
            <td><?php echo $this->document->getDonViTinh($ct['unit'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['price'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($ct['subtotal'])?></td>
        </tr>
        <?php } ?>
        <tr>
        	<td colspan="4" align="right">Tổng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">Giảm giá%</td>
            <td class="number"><input type="text" class="text short number" id="discountpercent"></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">Số tiền giảm</td>
            <td class="number" id="discount"></td>
        </tr>
        <tr>
        	<td colspan="4" align="right">Tổng tiền</td>
            <td class="number" id="finaltotal"></td>
        </tr>
    </tbody>
</table>
<script language="javascript">
numberReady();
$('#discountpercent').keyup(function(e) {
	var sum = Number("<?php echo $sum?>");
	var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
	var finaltotal = (1 - discountpercent/100)*sum;
	$('#discount').html(formateNumber(discountpercent/100*sum));
	$('#finaltotal').html(formateNumber(finaltotal));
	//Cap nhat don hang
	$.post("")
});


</script>