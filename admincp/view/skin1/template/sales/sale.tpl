<link rel="stylesheet" type="text/css" href="<?php echo DIR_CSS?>sale.css">
<div class="section">
	<div class="section-title"><?php echo $this->document->title?></div>	
    <div class="section-content">					
        
        
        
        <form id="saleorder">
        	<h3><center>Phiếu Bán Hàng</center></h3>
            <input type="hidden" id="shopid" name="shopid" value="<?php echo $shopid?>">
            <input type="hidden" id="id" name="id" value="<?php echo $item['id']?>">
            <input type="hidden" id="khachhangid" name="khachhangid">
            <input type="hidden" id="loaiphieu" name="loaiphieu" value="CH-BH">
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
        <input type="button" class="button" id="btnSave" value="Lưu phiếu" onClick="saleOrder.save('')"/>
        <div id="listorder"></div>
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
	saleOrder.listOrder();
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
function SaleOrder()
{
	this.save = function(type)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
		
		$.post("?route=sales/sale/save", $("#saleorder").serialize(),
			function(data){
				var obj = $.parseJSON(data);
				if(obj.error == "")
				{
					switch(type)
					{
						case "":
							//window.location = "?route=quanlykho/phieuxuat";
							$('#saleorder #id').val(obj.id);
							
							break;
						case "print":
							
							//var id = arr[1];
							//objdl.viewPX(id,"window.location = '?route=quanlykho/phieuxuat'");
							
					}
				}
				else
				{
				
					$('#error').html(data).show('slow');
					
					
				}
				$.unblockUI();
			}
		);
	}
	this.listOrder = function()
	{
		$.getJSON("?route=sales/sale/listOrder&shopid="+ $('#shopid').val(),function(data){
			var str = '<ul>';
			for(i in data)
			{
				
				str += '<li><input type="button" class="button" value="'+ data[i].maphieu + '-' + data[i].tenkhachhang +'" onclick="saleOrder.editOrder('+ data[i].id +')"/></li>';
			}
			str += '</ul>';
			$('#listorder').html(str);
		});
			
	}
	this.editOrder = function(id)
	{
		$.getJSON("?route=sales/sale/getOrder&id="+ id,function(data){
			$('#saleorder #id').val(data.id);
			$('#saleorder #ngaylap').val(data.ngaylap);
			$('#saleorder #khachhangid').val(data.khachhangid);
			$('#saleorder #tenkhachhang').val(data.tenkhachhang);
			$('#saleorder #dienthoai').val(data.dienthoai);
			$('#saleorder #diachi').val(data.diachi);
			$('#saleorder #shopid').val(data.shopid);
			$('#saleorder #loaiphieu').val(data.loaiphieu);
		});
	}

}
var saleOrder = new SaleOrder();
</script>