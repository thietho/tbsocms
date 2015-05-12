<link rel="stylesheet" type="text/css" href="<?php echo DIR_CSS?>sale.css">
<div class="section">
	<div class="section-title"><?php echo $this->document->title?></div>	
    <div class="section-content">					
        
        
        
        <form id="saleorder">
        	<h3><center>Phiếu Bán Hàng</center></h3>
            <input type="hidden" id="shopid" name="shopid" value="<?php echo $shopid?>">
            <input type="hidden" id="customerid" name="customerid">
            <table>
            	<tr>
                	<td width="70px"><label>Khách hàng</label></td>
                    <td><input type="text" class="text" id="customername" name="customername" value="Khách lẻ"></td>
                </tr>
                <tr>
                	<td><label>Điện thoại</label></td>
                    <td><input type="text" class="text" id="phone" name="phone"></td>
                </tr>
                <tr>
                	<td><label>Địa chỉ</label></td>
                    <td><input type="text" class="text" id="address" name="address"></td>
                </tr>
            </table>
            <table class="data-table">
            	<tr>
                	<thead>
                    	<th>Sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Giá</th>
                        <th>Giảm(%)</th>
                        <th>Giảm</th>
                        <th>Giá đã giảm</th>
                        <th>Thành tiền</th>
                    </thead>
                </tr>
                <tbody id="saleorderdetail"></tbody>
            </table>
        </form>
        <div id="product-content"></div>
        <div class="clearer">&nbsp;</div>
	</div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
	$('#product-content').load('?route=sales/sale/listProduct&shopid=' + $('#shopid').val());
    
});
</script>