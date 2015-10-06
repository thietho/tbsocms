
<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo @$this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="savephieu('')"/>
                <input type="button" value="Lưu & In" class="button" onClick="savephieu('print')"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieunhap')"/>   
     	        <input type="hidden" name="id" value="<?php echo @$item['id']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="phieunhapxuat">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin phiếu nhập</span></a></li>
                    <li class="tabs"><a href="#fragment-nguyenlieu"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                	<p>
                    	<label>Ngày nhập</label><br />
                        
                        <input type="text" class="text"  id="ngaylap" name="ngaylap" value="<?php echo @$this->date->formatMySQLDate($item['ngaylap'])?>"/>
						<script language="javascript">
                            $(function() {
                                $("#ngaylap").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                    </p>
                    <p>
                    	<label>Loại phiếu</label><br />
                        <select id="loaiphieu" name="loaiphieu">
                        <?php foreach($loaiphieu as $val){ ?>
                        	<option value="<?php echo @$val['categoryid']?>"><?php echo @$val['categoryname']?></option>
                        <?php } ?>
                        </select>
                        
                    </p>
                    <div id="f-NK-KHTL">
                        <p>
                            <label>Khách hàng</label><br />
                            <input type="hidden" id="khachhangid" name="khachhangid" value="<?php echo @$item['khachhangid']?>" >
                            <input type="text" id="tenkhachhang" name="tenkhachhang" value="<?php echo @$item['tenkhachhang']?>" class="text" size=60 />
                            <input type="button" class="button" id="btnSelectKhachHang" value="Chọn khách hàng" />
                        </p>
                        <p>
                            <label>Điện thoại</label><br />
                            <input type="text" id="dienthoai" name="dienthoai" value="<?php echo @$item['dienthoai']?>" class="text" size=60 />
                        </p>
                        <p>
                            <label>Địa chỉ</label><br />
                            <input type="text" id="diachi" name="diachi" value="<?php echo @$item['diachi']?>" class="text" size=60 />
                        </p>
                    </div>
                    <div id="f-NK">
                    	<p>
                            <label>Nhà cung cấp</label><br />
                            <span id="nhacungcapview"><?php echo @$item['tennhacungcap']?></span>
                            <input type="hidden" id="nhacungcapid" name="nhacungcapid" value="<?php echo @$item['nhacungcapid']?>">
                            <input type="hidden" id="tennhacungcap" name="tennhacungcap" value="<?php echo @$item['tennhacungcap']?>">
                            <input type="button" class="button" id="btnSeleteNhaCungCap" value="Chọn nhà cung cấp">
                            
                        </p>
                        <p>
                            <label>Người giao</label><br />
                            <input type="text" id="nguoigiao" name="nguoigiao" value="<?php echo @$item['nguoigiao']?>" class="text" size=60 />
                            
                        </p>
                    </div>
                    <div id="f-NK-CH">
                    	
                        <select id="shopid" name="shopid">
                            <option value="">Chọn cửa hàng</option>
                            <?php foreach($data_shop as $shop){ ?>
                            <option value="<?php echo @$shop['id']?>"><?php echo @$shop['shopname']?></option>
                            <?php }?>
                        </select>
                        <script language="javascript">
                        $('#shopid').val("<?php echo @$item['shopid']?>");
                        </script>
                       
                    </div>
                    
                    <p>
                    	<label>Tình trạng</label><br />
                        <select id="trangthai" name="trangthai">
                        	<?php foreach(@$this->document->status_phieunhapxuat as $key => $val){?>
                            <option value="<?php echo @$key?>"><?php echo @$val?></option>
                            <?php } ?>
                        </select>
                        <script language="javascript">
                        $('#trangthai').val("<?php echo @$item['trangthai']?>");
                        </script>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo @$item['ghichu']?></textarea>
                        
                    </p>
                   
                </div>
                <div id="fragment-nguyenlieu">
                	
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
                                	
                                    <input type="text" id="lydothu" name="lydothu" class="text" value="<?php echo @$item['lydothu']?>"/>
                                </td>
                                <td class="number"><input type="text" class="text number"  id="thuphi" name="thuphi" value="<?php echo @$this->string->numberFormate($item['thuphi'])?>"/></td>
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
                                    <input type="hidden" id="tongtien" name="tongtien" value="<?php echo @$item['tongtien']?>"/>
                                </td>
                                <td class="number" id="tongcong"><?php echo @$this->string->numberFormate($item['tongtien'])?></td>
                                <td></td>
                            </tr>
                            <tr>
                                
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">Thanh toán</td>
                                <td class="number"><input type="text" class="text number"  id="thanhtoan" name="thanhtoan" value="<?php echo @$this->string->numberFormate($item['thanhtoan'])?>"/></td>
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
                                	<input type="text" class="text"  id="ngaythanhtoan" name="ngaythanhtoan" value="<?php echo @$this->date->formatMySQLDate($item['ngaythanhtoan'])?>"/>
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
                                	<input type="hidden" id="congno" name="congno" value="<?php echo @$item['congno']?>"/>
                                </td>
                                <td class="number" id="lbl-congno"><?php echo @$this->string->numberFormate($item['congno'])?></td>
                                <td></td>
                            </tr>
                            <tr>
                                
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="number">Số ngày công nợ</td>
                                <td class="number"><input type="text" class="text number"  id="songaycongno" name="songaycongno" value="<?php echo @$this->string->numberFormate($item['songaycongno'])?>"/></td>
                                <td>Ngày</td>
                            </tr>
                        </tfoot>
                    </table>
                    <input type="hidden" id="delnhapkho" name="delnhapkho" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                    <input type="button" class="button" id="btnImport" value="Lấy dữ liệu từ file excel"/>
                    <input type="button" class="button" id="btnGetFomat" value="Lấy file excel mẫu"/>
                </div>
           </div>
            
        </form>
    
    </div>
    
</div>
<?php if(count($data_nhapkho)){ ?>
	<?php foreach($data_nhapkho as $dl){ ?>
<script language="javascript">
$(document).ready(function(e) {
	objdl.addRow("<?php echo @$dl['id']?>","<?php echo @$dl['mediaid']?>","<?php echo @$dl['code']?>","<?php echo @$this->document->productName($dl['mediaid'])?>","<?php echo @$dl['soluong']?>","<?php echo @$dl['madonvi']?>","<?php echo @$dl['giatien']?>","<?php echo @$dl['giamgia']?>","<?php echo @$dl['phantramgiamgia']?>");
	
	
});
</script>
	<?php } ?>
<?php } ?>
<script language="javascript">
$('#phieunhapxuat').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
$("#nhapkhonguyenlieu").sortable();
$('#loaiphieu').change(function(e) {
	$('.nhapxuat').hide();
    $('#f-'+$('#loaiphieu').val()).show();
	switch(this.value)
	{
		case "NK":
			$('#f-NK').show();
			break;
		case "NK-KHTL":
			$('#f-NK-KHTL').show();
	}
});
function savephieu(type)
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/phieunhap/save", $("#frm").serialize(),
		function(data){
			var obj = $.parseJSON(data);
			if(obj.error == "")
			{
				phieuid = obj.id;
				objdl.delDetail($('#delnhapkho').val());
				
				switch(type)
				{
					case "":
						objdl.saveDetail(obj,'window.location = "?route=quanlykho/phieunhap";');
						
						break;
					case "print":
						objdl.saveDetail(obj,function(){
							var id = obj.id;
							objdl.viewPN(id,"window.location = '?route=quanlykho/phieunhap'");
						});
						
						
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
//
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
	$("#tenkhachhang").autocomplete({
		minLength: 2,
		select: function( event, ui ) {
			//console.log(ui.item.id);
			//objdl.getProbyMediaId(ui.item.id);
			//alert(ui.item.data.fullname);
			$('#khachhangid').val(ui.item.id);
			$('#dienthoai').val(ui.item.data.phone);
			$('#diachi').val(ui.item.data.address);
		},
		source: function( request, response ) {
		var term = request.term;
		if ( term in cache ) {
			response( cache[ term ] );
			return;
		}
		$.getJSON( "?route=core/member/getMember", request, function( data, status, xhr ) {
			cache[ term ] = data;
			response( data );
			});
		}
	});
	$("#nguoithuchien").autocomplete({
		minLength: 2,
		select: function( event, ui ) {
			$('#nguoithuchienid').val(ui.item.id);
			$('#nguoithuchien').val(ui.item.value);
		},
		source: function( request, response ) {
		var term = request.term;
		if ( term in cache ) {
			response( cache[ term ] );
			return;
		}
		$.getJSON( "?route=quanlykho/nhanvien/getNhanVienByName", request, function( data, status, xhr ) {
			cache[ term ] = data;
			response( data );
			});
		}
	});
});
$(document).ready(function(e) {
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
	$('#btnSelectNhanVien').click(function(e) {
		handle = "nguoinhan";
		$("#popup").attr('title','Chọn nhân viên');
			$( "#popup" ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				
			});
		
			$("#popup").dialog("open");	
			$("#popup-content").html(loading);
			$("#popup-content").load("?route=quanlykho/nhanvien&opendialog=true",function(){
				
			});
	});
	$('#btnSelectNhanVienNhan').click(function(e) {
		handle = "nguoinhan";
		$("#popup").attr('title','Chọn nhân viên');
			$( "#popup" ).dialog({
				autoOpen: false,
				show: "blind",
				hide: "explode",
				width: $(document).width()-100,
				height: window.innerHeight,
				modal: true,
				
			});
		
			$("#popup").dialog("open");	
			$("#popup-content").html(loading);
			$("#popup-content").load("?route=quanlykho/nhanvien&opendialog=true",function(){
				
			});
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
	
	$('#btnAddRow').click(function(e) {
		browseProduct('objdl.addFunction()');
	});
	
	$('#btnSeleteNhaCungCap').click(function(e) {
		$("#popup").attr('title','Chọn nhà cung cấp');
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
			$("#popup-content").load("?route=quanlykho/nhacungcap&opendialog=true",function(){
				
			});
	});
	
	
	$('#loaiphieu').val("<?php echo @$item['loaiphieu']?>").change();
        
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
function intSelectNhaCungCap()
{
	$('.item').click(function(e) {
		$('#nhacungcapid').val($(this).attr('id'));
		$('#tennhacungcap').val($(this).attr('tennhacungcap'));
		$('#nhacungcapview').html($(this).attr('tennhacungcap'));
		$('#nguoinhan').val($(this).attr('tennhacungcap'));
		$("#popup").dialog( "close" );
	});
}

</script>