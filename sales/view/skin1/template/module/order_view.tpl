<h4>Mã đơn hàng: <?php echo $order['code']?></h4>
<input type="button" class="button" id="btnToPending" value="Chờ tính tiền">
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
        <tr class="orderrow" ctid="<?php echo $ct['id']?>">
        	
        	<td><?php echo $ct['title']?></td>
            <td class="number">
            	<table>
                	<tr>
                    	<td><?php echo $this->string->numberFormate($ct['quantity'])?></td>
                        <td><input type="button" class="button btnaddOrder" value="+" mediaid="<?php echo $ct['mediaid']?>" code="<?php echo $ct['code']?>" title="<?php echo $ct['title']?>" price="<?php echo $ct['price']?>" unit="<?php echo $ct['unit']?>"></td>
                        <td><input type="button" class="button btnDecOrder" value="-" mediaid="<?php echo $ct['mediaid']?>" code="<?php echo $ct['code']?>" title="<?php echo $ct['title']?>" price="<?php echo $ct['price']?>" unit="<?php echo $ct['unit']?>"></td>
                    </tr>
                </table>
            	
                
                
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
<input type="hidden" id="customerid" value="<?php echo $order['customerid']?>">
<input type="hidden" id="customername" value="<?php echo $order['customername']?>">
Khách hàng: <span id="customernametext"><?php echo $order['customername']?></span>
<input type="button" class="button" id="btnSelectCustomer" value="Chọn khách hàng">
<div>
    <input type="button" class="button" id="btnRemove" value="Xóa hàng">
    <input type="button" class="button" id="btnPayment" value="Tính tiền">
    <input type="button" class="button" id="btnPrintOrder" value="In hóa đơn">
    
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
			orderid:$('#orderid').val(),
			col:"discountpercent",
			val:$('#discountpercent').val()
		},
		function(data){
		
		});
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
$('#btnToPending').click(function(e) {
    pro.getListOrder();
	$('#orderdetail').html('');
});
$('#btnRemove').click(function(e) {
    $('.selectRow').each(function(index, element) {
		$.get("?route=page/home/delOrderDetail&id="+ $(this).attr('ctid'),
		function()
		{
			$('#orderdetail').load("?route=page/home/orderView&orderid="+$('#orderid').val());	
		});
        
    });
});

$('#btnSelectCustomer').click(function(e) {
    $("#popup").attr('title','Chọn khách hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
		});
	
		
		$("#popup-content").load("?route=core/member&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
function intSelectMember()
{
	$('.item').click(function(e) 
	{
		
        $('#customerid').val($(this).attr('id'));
		$('#customername').val($(this).attr('fullname'));
		$('#customernametext').html($(this).attr('fullname'));
		$("#popup").dialog( "close" );
		
		//Cap nhat customerid
		$.post("?route=page/home/updateOrder",
		{
			orderid:$('#orderid').val(),
			col:"customerid",
			val:$('#customerid').val()
		},
		function(data){
		
		});
		//Cap nhat customername
		$.post("?route=page/home/updateOrder",
		{
			orderid:$('#orderid').val(),
			col:"customername",
			val:$('#customername').val()
		},
		function(data){
		
		});
	});
		
}
</script>