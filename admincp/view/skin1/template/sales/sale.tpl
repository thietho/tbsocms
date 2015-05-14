<link rel="stylesheet" type="text/css" href="<?php echo DIR_CSS?>sale.css">
<div class="section">
	<div class="section-title"><?php echo $this->document->title?></div>	
    <div class="section-content">					
        
        
        
        <form id="saleorder">
        	<h3><center>Phiếu Bán Hàng</center></h3>
            <input type="hidden" id="shopid" name="shopid" value="<?php echo $shopid?>">
            <input type="hidden" name="id" value="<?php echo $item['id']?>">
            <input type="hidden" id="khachhangid" name="khachhangid">
            <table>
            	
                        
                <tr>
                	<td><label>Ngày nhập</label></td>
                    <td>
                    	<input type="text" class="text"  id="ngaylap" name="ngaylap" value="<?php echo $this->date->formatMySQLDate($item['ngaylap'])?>"/>
						<script language="javascript">
                            $(function() {
                                $("#ngaylap").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                    </td>
                </tr>
            	<tr>
                	<td width="70px"><label>Khách hàng</label></td>
                    <td><input type="text" class="text" id="tenkhachhang" name="tenkhachhang" value="Khách lẻ"></td>
                </tr>
                <tr>
                	<td><label>Điện thoại</label></td>
                    <td><input type="text" class="text" id="dienthoai" name="dienthoai"></td>
                </tr>
                <tr>
                	<td><label>Địa chỉ</label></td>
                    <td><input type="text" class="text" id="diachi" name="diachi"></td>
                </tr>
            </table>
            <table>
                <thead>
                    <tr>
                        
                        <th>Sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn vị tính</th>
                        <th>Đơn giá</th>
                        <th>Giảm giá%</th>
                        <th>Giảm giá</th>
                        
                        <th>Thành tiền</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="nhapkhonguyenlieu">
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="8">
                            <input type="text" id="txt_ref" class="text" size="100"/>
                            
                        </td>
                    </tr>
                    <tr>
                        
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            
                            <input type="text" id="lydothu" name="lydothu" class="text" value="<?php echo $item['lydothu']?>"/>
                        </td>
                        <td class="number"><input type="text" class="text number"  id="thuphi" name="thuphi" value="<?php echo $this->string->numberFormate($item['thuphi'])?>"/></td>
                        <td></td>
                    </tr>
                    <tr>
                        
                        <td class="number">Tổng số lượng</td>
                        <td id="sumsoluong" class="number"></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="number">
                            Tổng cộng
                            <input type="hidden" id="tongtien" name="tongtien" value="<?php echo $item['tongtien']?>"/>
                        </td>
                        <td class="number" id="tongcong"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
                        <td></td>
                    </tr>
                    
                    <tr>
                        
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="number">Thanh toán</td>
                        <td class="number"><input type="text" class="text number"  id="thanhtoan" name="thanhtoan" value="<?php echo $this->string->numberFormate($item['thanhtoan'])?>"/></td>
                        <td><input type="button" class="button" id="btnTrahet" value="Trả hết"/></td>
                    </tr>
                    <tr>
                        
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="number">Ngày thanh toán</td>
                        <td class="number">
                            <input type="text" class="text"  id="ngaythanhtoan" name="ngaythanhtoan" value="<?php echo $this->date->formatMySQLDate($item['ngaythanhtoan'])?>"/>
                            <script language="javascript">
                                $(function() {
                                    $("#ngaythanhtoan").datepicker({
                                            changeMonth: true,
                                            changeYear: true,
                                            dateFormat: 'dd-mm-yy'
                                            });
                                    });
                             </script>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="number">
                            Công nợ
                            <input type="hidden" id="congno" name="congno" value="<?php echo $item['congno']?>"/>
                        </td>
                        <td class="number" id="lbl-congno"><?php echo $this->string->numberFormate($item['congno'])?></td>
                        <td></td>
                    </tr>
                    
                </tfoot>
            </table>
            <input type="hidden" id="delnhapkho" name="delnhapkho" />
            
        </form>
        <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
        <input type="button" class="button" id="btnSave" value="Lưu phiếu"/>
        <div id="product-content"></div>
        <div class="clearer">&nbsp;</div>
	</div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
	$('#product-content').load('?route=sales/sale/listProduct&shopid=' + $('#shopid').val());
	$("#nhapkhonguyenlieu").sortable();
    if($('#ngaylap').val()=='')
		$('#ngaylap').val(intToDate(Date.now()));
});
$('#btnAddRow').click(function(e) {
	browseProduct();
});
$(function() {
	var cache = {};
	$( "#txt_ref" ).autocomplete({
		minLength: 2,
		select: function( event, ui ) {
			//console.log(ui.item.id);
			objdl.getProbyMediaId(ui.item.id);
			/*var obj = ui.item.data
			var giagiam = 0;
			if(obj.pricepromotion > 0)
			{
				giagiam = obj.price - obj.pricepromotion;
			}
			objdl.addRow('',obj.mediaid,obj.code,obj.productName,1,obj.unit,obj.price,giagiam,obj.discountpercent);
			setTimeout("$('#txt_ref').val('')",1000);*/
		},
		source: function( request, response ) {
		var term = request.term;
		if ( term in cache ) {
			response( cache[ term ] );
			return;
		}
		$.getJSON( "?route=core/media/getProduct", request, function( data, status, xhr ) {
			cache[ term ] = data;
			response( data );
			});
		}
	});
	
});
function save(type)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieuxuat/save", $("#frm").serialize(),
		function(data){
			var arr = data.split("-");
			if(arr[0] == "true")
			{
				switch(type)
				{
					case "":
						window.location = "?route=quanlykho/phieuxuat";
						break;
					case "print":
						$.unblockUI();
						var id = arr[1];
						objdl.viewPX(id,"window.location = '?route=quanlykho/phieuxuat'");
						
				}
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