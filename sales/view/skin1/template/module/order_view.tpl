<h4>Mã đơn hàng: <?php echo $order['code']?></h4>
<table>
    <thead>
        <tr>      
        	   
            <th>Sản phẩm</th>
            <th width="100px">Số lượng</th>
            <th>ĐVT</th>
            <th>Giá bán</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
    	<?php foreach($data_ct as $ct){ ?>
        <?php $sum += $ct['subtotal']?>
        <tr class="orderrow">
        	
        	<td><?php echo $ct['title']?></td>
            <td class="number">
            	<?php echo $this->string->numberFormate($ct['quantity'])?>
                <input type="button" class="button btnaddOrder" value="+" mediaid="<?php echo $ct['mediaid']?>" code="<?php echo $ct['code']?>" title="<?php echo $ct['title']?>" price="<?php echo $ct['price']?>" unit="<?php echo $ct['unit']?>">
                <input type="button" class="button btnDecOrder" value="-" mediaid="<?php echo $ct['mediaid']?>" code="<?php echo $ct['code']?>" title="<?php echo $ct['title']?>" price="<?php echo $ct['price']?>" unit="<?php echo $ct['unit']?>">
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
            <td class="number"><input type="text" class="text short number" id="discountpercent" value="<?php echo $order['discountpercent']?>"></td>
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
<input type="hidden" id="customerid">
<input type="hidden" id="customername">
Khách hàng: <span id="customernametext">Khách vãn lai</span>
<div>
    <input type="button" class="button" value="Chọn khách hàng">
    <input type="button" class="button" value="Tính tiền">
    <input type="button" class="button" value="In hóa đơn">
</div>
<script language="javascript">
numberReady();
$(document).ready(function(e) {
    tinhtong();
});
function tinhtong()
{
	var sum = Number("<?php echo $sum?>");
	var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
	var finaltotal = (1 - discountpercent/100)*sum;
	$('#discount').html(formateNumber(discountpercent/100*sum));
	$('#finaltotal').html(formateNumber(finaltotal));
}
$('#discountpercent').keyup(function(e) {
	tinhtong();
	//Cap nhat don hang
	$.post("?route=page/home/updateOrder",
		{
			orderid:"<?php echo $order['id']?>",
			col:"discountpercent",
			val:$('#discountpercent').val()
		},
		function(data){
		
		})
});
$('.btnaddOrder').click(function(e) {
     pro.addOrder($('#orderid').val(),$(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),1,$(this).attr('price'));
});
$('.btnDecOrder').click(function(e) {
    pro.addOrder($('#orderid').val(),$(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),-1,$(this).attr('price'));
});
$('.orderrow').click(function(e) {
	if($(this).hasClass('selectRow'))
	    $(this).removeClass('selectRow');
	else
		$(this).addClass('selectRow');
	
});
</script>