<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $heading_title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frmOrder" name="frmOrder" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input class="button" type="button" value="<?php echo $button_save?>" onclick="save()"/>
     	        <a class="button" href="index.php?route=addon/order/view&orderid=<?php echo $order['orderid']?>"><?php echo $button_cancel?></a>
                
            </div>
            <div class="clearer">^&nbsp;</div>
        
        	<div class="left" style="width:50%;">
            	<h3>Thông tin khách hàng</h3>
            	<p>
            		<label>Order id</label><br />
					<?php echo $order['orderid']?>
                    <input type="hidden" name="orderid" value="<?php echo $order['orderid']?>"/>
            	</p>
                <p>
            		<label><?php echo $entry_customername?></label><br />
                    <input type="text" class="text" name="customername" value="<?php echo $order['customername']?>" size="40">
            	</p>
                <p>
            		<label><?php echo $entry_email?></label><br />
                    <input type="text" class="text" name="email" value="<?php echo $order['email']?>" size="40">
					
            	</p><p>
            		<label><?php echo $entry_address?></label><br />
					<input type="text" class="text" name="address" value="<?php echo $order['address']?>" size="40">
            	</p>
                <p>
            		<label><?php echo $entry_phone?></label><br />
					<input type="text" class="text" name="phone" value="<?php echo $order['phone']?>" size="40">
            	</p>
                <p>
            		<label><?php echo $entry_orderdate?></label><br />
					<?php echo $this->date->formatMySQLDate($order['orderdate'])?>
            	</p>
			</div>
            <div class="left">
                <h3>Thông tin giao hàng</h3>
                <p>
            		<label>Người nhận hàng</label><br />
					<input type="text" class="text" name="receiver" value="<?php echo $order['receiver']?>" size="40">
            	</p>
                <p>
            		<label>Số điện thoại</label><br />
					<input type="text" class="text" name="receiverphone" value="<?php echo $order['receiverphone']?>" size="40">
            	</p>
               	<p>
            		<label>Địa chỉ nhận</label><br />
					<input type="text" class="text" name="shipperat" value="<?php echo $order['shipperat']?>" size="40">
            	</p>
                <p>
            		<label>Phương thức thanh toán</label><br />
					<select id="paymenttype" name="paymenttype">
                    	<?php foreach($this->document->paymenttype as $key => $val){ ?>
                        <option value="<?php echo $key?>"><?php echo $val?></option>
                        <?php } ?>
                    </select>
            	</p>
               
                
                <!--
                <p>
            		<label><?php echo $entry_status?></label><br />
					<select id="status<?php echo $order['orderid']?>" onchange="order.updateStatus('<?php echo $order['orderid']?>',this.value)">
                        <?php foreach($this->document->status as $key => $val) { ?>
                        <option value="<?php echo $key?>" <?php echo ($order['status'] == $key)?'selected="selected"':''?>><?php echo $val?></option>
                        <?php } ?>
                    </select>
            	</p>
                <p>
            		<label><?php echo $entry_message?></label><br />
					<?php echo $order['comment']?>
            	</p>-->
            </div>
            <div class="clearer">^&nbsp;</div>
            <div>
            	<input type="button" class="button" value="Chọn sản phẩm" onClick="order.browseProduct()">
                <input type="hidden" id="delid" name="delid">
            	<table>
                	<thead>
                    	<tr>
                            <th><?php echo $column_productname?></th>
                            <th><?php echo $column_productimage?></th>
                            <th><?php echo $column_productqty?></th>
                            <th>Price</th>
                            
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="listproduct">
                   
                    </tbody>
                    
                </table>
            </div>
        </form>
    
    </div>
    
</div>

<script language="javascript">
$(document).ready(function(e) {
    <?php foreach($detail as $item){?>
	var row = order.addRow("<?php echo $item['id']?>","<?php echo $item['mediaid']?>","<?php echo $item['title']?>","<?php echo $item['imagepreview']?>","<?php echo $item['quantity']?>","<?php echo $item['price']?>");
	$('#listproduct').append(row);
	<?php } ?>
	numberReady();
	$('#paymenttype').val("<?php echo $order['paymenttype']?>");
});
function save()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	
	$.post("?route=addon/order/save", $("#frmOrder").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=addon/order/view&orderid=<?php echo $order['orderid']?>";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
</script>