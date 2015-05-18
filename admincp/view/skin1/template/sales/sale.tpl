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
                <tr>
                	<td><label>Tình trạng</label></td>
                    <td>
                    	<select id="trangthai" name="trangthai">
                        	<?php foreach($this->document->status_phieunhapxuat as $key => $val){?>
                            <option value="<?php echo $key?>"><?php echo $val?></option>
                            <?php } ?>
                        </select>
                        <a class="button" id="btnSelectKhachHang" >Chọn khách hàng</a>
                    </td>
                </tr>
                <tr>
                	<td><label>Ghi chú</label></td>
                    <td><textarea id="ghichu" name="ghichu"></textarea></td>
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
                            
                            <input type="text" id="lydothu" name="lydothu" class="text"/>
                        </td>
                        <td class="number"><input type="text" class="text number"  id="thuphi" name="thuphi" /></td>
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
                            <input type="hidden" id="tongtien" name="tongtien"/>
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
        <input type="button" class="button" id="btnSavePrint" value="Lưu & in" onClick="saleOrder.save('print')"/>
        <input type="button" class="button" id="btnNewOrder" value="Đơn hàng mới" onClick="saleOrder.newOrder()"/>
        <input type="button" class="button" id="btnDelOrder" value="Xóa đơn hàng" onClick="saleOrder.delOrder($('#saleorder #id').val())"/>
        
        <div id="listorder"></div>
        
        <div id="product-content"></div>
        <div class="clearer">&nbsp;</div>
	</div>
    
</div>
<script language="javascript">
$(document).ready(function(e) {
	saleOrder.loadProduct();
	$("#nhapkhonguyenlieu").sortable();
   
		
	saleOrder.listOrder();
	saleOrder.newOrder();
	$('#btnTrahet').click(function(e) {
		$('#thanhtoan').val($('#tongcong').html());
		$('#thanhtoan').keyup();
	});
	$('#thuphi').keyup(function(e) {
		objdl.tinhtong(0);
	});
	$('#thanhtoan').keyup(function(e) {
		var tongcong = Number(stringtoNumber($('#tongcong').html()));
		var thanhtoan = Number(stringtoNumber($('#thanhtoan').val()));
		var congno = tongcong - thanhtoan;
		$('#congno').val(congno);
		$('#lbl-congno').html(formateNumber(congno));
	});
});
$('#btnAddRow').click(function(e) {
	browseProduct();
});
$('#btnSelectKhachHang').click(function(e) {
	$("#popup").attr('title','Chọn khách hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 1000,
			height: window.innerHeight,
			modal: true,
		});
	
		$("#popup").dialog("open");
		$("#popup-content").html(loading);
		$("#popup-content").load("?route=core/member&opendialog=true",function(){
			
		});
});
function intSelectMember()
{
	$('.item').click(function(e) {
		
		$('#khachhangid').val($(this).attr('id'));
		$('#tenkhachhang').val($(this).attr('fullname'));
		$('#dienthoai').val($(this).attr('phone'));
		$('#diachi').val($(this).attr('address'));
		$("#popup").dialog( "close" );
	});
}
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
function SaleOrder(shopid)
{
	this.shopid = shopid
	this.newOrder = function()
	{
		$('#saleorder #id').val('');
		$('#saleorder #ngaylap').val(intToDate(Date.now()));
		$('#saleorder #khachhangid').val('');
		$('#saleorder #tenkhachhang').val('Khách lẻ');
		$('#saleorder #dienthoai').val('');
		$('#saleorder #diachi').val('');
		
		$('#saleorder #loaiphieu').val('CH-BH');
		$('#saleorder #trangthai').val('new');
		$('#saleorder #ghichu').val('');
		$('#saleorder #lydothu').val('');
		$('#saleorder #thuphi').val('');
		$('#saleorder #thanhtoan').val('');
		$('#saleorder #tongtien').val('');
		$('#nhapkhonguyenlieu').html('');
		$('#tongcong').html('');
		$('#sumsoluong').html('');
		$('#lbl-congno').html('');
		$('#btnDelOrder').hide();
		$('.listorder').removeClass('ordercurrent');
	}
	this.delOrder = function(id)
	{
		$.get("?route=sales/sale/delOrder&id="+ id,function(html){
			alert(html);
			saleOrder.listOrder();
			saleOrder.loadProduct();
		});
	}
	this.print = function(id)
	{
		openDialog("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=print&show=giamgia",800,500);
		
	}
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
							$('#saleorder #id').val(obj.id);
							saleOrder.print(obj.id);
					}
				}
				else
				{
				
					$('#error').html(data).show('slow');
					
					
				}
				$.unblockUI();
				saleOrder.listOrder();
				saleOrder.loadProduct();
			}
		);
	}
	this.listOrder = function()
	{
		$.getJSON("?route=sales/sale/listOrder&shopid="+ this.shopid,function(data){
			var chuathanhtoan = '<h2>Đơn hàng chưa thanh toán</h2>';
			chuathanhtoan += '<ul>';
			var dathanhtoan = '<h2>Đơn hàng đã thanh toán</h2>';
			dathanhtoan += '<ul>';
			var stype = 'style="background:red"';
			for(i in data)
			{
				if(data[i].congno != 0 )
					chuathanhtoan += '<li><input type="button" class="button listorder" value="'+ data[i].maphieu + '-' + data[i].tenkhachhang +'" onclick="saleOrder.editOrder('+ data[i].id +')" ref="'+ data[i].id +'"/></li>';
				if(data[i].congno == 0 )
					dathanhtoan += '<li><input type="button" class="button listorder" value="'+ data[i].maphieu + '-' + data[i].tenkhachhang +'" onclick="saleOrder.editOrder('+ data[i].id +')" ref="'+ data[i].id +'"/></li>';
			}
			chuathanhtoan += '</ul>';
			dathanhtoan += '</ul>';
			$('#listorder').html(chuathanhtoan + dathanhtoan);
			$('.listorder').click(function(e) {
				$('.listorder').removeClass('ordercurrent');
                $(this).addClass('ordercurrent');
            });
			$('.listorder').each(function(index, element) {
                if($(this).attr('ref') == $('#saleorder #id').val())
					$(this).addClass('ordercurrent');
            });
		});
			
	}
	this.editOrder = function(id)
	{
		$.getJSON("?route=sales/sale/getOrder&id="+ id,function(data){
			$('#btnDelOrder').show();
			$('#saleorder #id').val(data.id);
			$('#saleorder #ngaylap').val(data.ngaylap);
			$('#saleorder #khachhangid').val(data.khachhangid);
			$('#saleorder #tenkhachhang').val(data.tenkhachhang);
			$('#saleorder #dienthoai').val(data.dienthoai);
			$('#saleorder #diachi').val(data.diachi);
			$('#saleorder #shopid').val(data.shopid);
			$('#saleorder #loaiphieu').val(data.loaiphieu);
			$('#saleorder #trangthai').val(data.trangthai);
			$('#saleorder #ghichu').val(data.ghichu);
			$('#saleorder #lydothu').val(data.lydothu);
			$('#saleorder #thuphi').val(data.thuphi);
			$('#saleorder #thanhtoan').val(data.thanhtoan);
			$('#saleorder #tongtien').val(data.tongtien);
			$('#nhapkhonguyenlieu').html('');
			objdl.index = 0;
			for(i in data.detail)
			{
				var obj = data.detail[i];
				//alert(obj.title);
				//objdl.addRow(obj.id,obj.mediaid,obj.code,obj.title,1,obj.unit,obj.price,giagiam,obj.discountpercent);
				objdl.addRow(obj.id,obj.mediaid,obj.code,obj.title,obj.soluong,obj.madonvi,obj.giatien,obj.giamgia,obj.phantramgiamgia);	
			}
			
		});
	}
	this.loadProduct = function()
	{
		$('#product-content').load('?route=sales/sale/listProduct&shopid=' + this.shopid);
	}
}
var saleOrder = new SaleOrder($('#shopid').val());
</script>