<div>
<table class="ben-table">
	<thead>
        <tr>
            <th>Hình</th>
            <th>Tên sản phẩm</th>
            <th>Giá</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
           
        </tr>
    </thead>
    <tbody>
	<?php 
    	$sum = 0;
    	foreach($medias as $media) {
        $sum = $media['price'] * $media['qty'];
    ?>
        <tr>
            <td><img src="<?php echo $media['imagethumbnail']?>" class="ben-center"/></td>
            <td><?php echo $media['title']?></td>
            <td class="number"><?php echo $this->string->numberFormate($media['price'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($media['qty'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($media['price'] * $media['qty'])?></td>
            
        </tr>
    <?php } ?>
    </tbody>
    <tfoot>
    	<tr>
        	<td></td>
            <td></td>
            <td></td>
            <td>Tông cộng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
    </tfoot>
</table>
</div>
<div>
	<form id="frmCheckOut" method="post">
    	<div id="error" class="ben-error" style="display:none"></div>
        <h2>Thông tin khách hàng</h2>
    	<table class="ben-form">
        	
            <input type="hidden" id="userid" name="userid" value="<?php echo $member['username']?>" size="40">
            <tr>
            	<td width="200px"><label>Họ và tên</label></td>
                <td><input type="text" id="customername" name="customername" value="<?php echo $member['fullname']?>" class="ben-textbox" size="40" <?php echo $readonly?>></td>
            </tr>
            <tr>
            	<td><label>Email</label></td>
                <td><input type="text" id="email" name="email" value="<?php echo $member['email']?>" class="ben-textbox" size="40" <?php echo $readonly?>></td>
            </tr>
            <tr>
            	<td><label>Địa chỉ</label></td>
                <td><input type="text" id="address" name="address" value="<?php echo $member['address']?>" class="ben-textbox" size="40" <?php echo $readonly?>></td>
            </tr>
            <tr>
            	<td ><label>Điện thoại</label></td>
                <td><input type="text" id="phone" name="phone" value="<?php echo $member['phone']?>" class="ben-textbox" size="40" <?php echo $readonly?>></td>
            </tr>
            
		</table>
        <input id="chk_fillnhanhang" type="checkbox" /> Thông tin nhận hàng như trên
        <h2>Thông tin giao hàng</h2>
        <table class="ben-form">
        	<tr>
            	<td width="200px">Người nhận hàng</td>
                <td><input type="text" id="receiver" name="receiver" class="ben-textbox" size="40" ></td>
            </tr>
            <tr>
            	<td>Số điện thoại</td>
                <td><input type="text" id="receiverphone" name="receiverphone" class="ben-textbox" size="40" <?php echo $readonly?>></td>
            </tr>
            <tr>
            	<td>Địa chỉ giao hàng</td>
                <td><input type="text" id="shipperat" name="shipperat" class="ben-textbox" size="40" ></td>
            </tr>
            <tr>
            	<td>Phương thức thanh toán</td>
                <td>
                	<?php foreach($this->document->paymenttype as $key => $val){ ?>
                    <input type="radio" name="paymenttype" value="<?php echo $key?>" /> <?php echo $val?><br />
                    <?php } ?>
                	
                </td>
            </tr>
            <tr>
            	<td>Ghi chú</td>
                <td><textarea id="comment" name="comment"></textarea></td>
            </tr>
        </table>
        <table>
            
            <tr>
            	<td ></td>
                <td>
                	<input type="button" id="btnCheckout" name="btnCheckout" class="ben-button" value="Đặt hàng">
                </td>
            </tr>
        </table>
        
    </form>
</div>
<div class="clearer">&nbsp;</div>
<script language="javascript">
$("#btnCheckout").click(function(){
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("<?php echo HTTP_SERVER?>?route=addon/checkout/checkout", $("#frmCheckOut").serialize(),
		function(data){
			var arr = data.split("-")
			if(arr[0] == "true")
			{
				window.location = HTTP_SERVER+"checkoutcomplete/"+arr[1]+".html";
			}
			else
			{
				
				$('#error').html(data).show('slow');
				
				
			}
			$.unblockUI();
		}
	);					   
});
$("#chk_fillnhanhang").click(function(e) {
    $('#receiver').val($('#customername').val());
	$('#receiverphone').val($('#phone').val());
	$('#shipperat').val($('#address').val());
});
</script>