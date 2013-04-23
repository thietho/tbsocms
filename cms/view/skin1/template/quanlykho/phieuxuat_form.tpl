<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="save('')"/>
                <input type="button" value="Lưu & In" class="button" onClick="save('print')"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieuxuat')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="container">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin phiếu nhập</span></a></li>
                    <li class="tabs"><a href="#fragment-nguyenlieu"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <!--<p>
                        <label>Người bán</label><br />
                        <input type="hidden" name="nguoithuchienid" value="<?php echo $item['nguoithuchienid']?>" value="<?php echo $item['nguoithuchienid']?>">
                        <input type="text" id="nguoithuchien" name="nguoithuchien" value="<?php echo $item['nguoithuchien']?>" class="text" size=60 <?php echo $readonly?>/>
                        <input type="button" class="button" id="btnSelectNhanVien" value="Chọn nhân viên" />
                    </p>-->
                    
                    
                    <p>
                        <label>Khách hàng</label><br />
                        <input type="hidden" name="nguoinhanid" value="<?php echo $item['nguoinhanid']?>" value="<?php echo $item['nguoinhanid']?>">
                        <input type="text" id="nguoinhan" name="nguoinhan" value="<?php echo $item['nguoinhan']?>" class="text" size=60 />
                        <input type="button" class="button" id="btnSelectKhachHang" value="Chọn khách hàng" />
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                        
                    </p>
                   
                </div>
                <div id="fragment-nguyenlieu">
                	<table>
                    	<tr>
                        	<th>Code</th>
                            <th>Sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Đơn vị tính</th>
                            <th>Đơn giá</th>
                            <th></th>
                        </tr>
                        <tbody id="nhapkhonguyenlieu">
                        </tbody>
                    </table>
                    <input type="hidden" id="delnhapkho" name="delnhapkho" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                </div>
           </div>
            
        </form>
    
    </div>
    
</div>
<?php if(count($data_nhapkho)){ ?>
	<?php foreach($data_nhapkho as $dl){ ?>
<script language="javascript">
$(document).ready(function(e) {
	objdl.addRow("<?php echo $dl['id']?>","<?php echo $dl['mediaid']?>","<?php echo $dl['code']?>","<?php echo $dl['title']?>","<?php echo $dl['soluong']?>","<?php echo $dl['madonvi']?>","<?php echo $dl['giatien']?>");
});
</script>
	<?php } ?>
<?php } ?>
<script language="javascript">
$(document).ready(function(e) {
    $('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
});
function DinhLuong()
{
	this.index = 0;
	this.addRow = function(id,mediaid,code,title,soluong,madonvi,giatien)
	{
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="nhapkhoid-'+ this.index +'" name="nhapkhoid['+ this.index +']" value="'+ id +'" /><input type="hidden" id="mediaid-'+ this.index +'" name="mediaid['+ this.index +']" value="'+ mediaid +'" /><input type="hidden" id="code-'+ this.index +'" name="code['+ this.index +']" value="'+ code +'" />'+ code +'</td>';
		row +='<td><input type="hidden" id="title-'+ this.index +'" name="title['+ this.index +']" value="'+ title +'" />'+ title +'</td>';
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number" /></td>';
		row +='<td class="number"><select mediaid="'+mediaid+'" id="madonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+madonvi+'"></section></td>';
		row +='<td class="number"><input type="text" id="giatien-'+ this.index +'" name="giatien['+ this.index +']" value="'+giatien+'" class="text number" /></td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>'
		$('#nhapkhonguyenlieu').append(row);
		var str = '#madonvi-'+ this.index;
		$.getJSON("?route=core/media/getListDonVi&mediaid="+ mediaid,
			function(data){
				html = "";
				for(i in data)
				{
					//alert(data[i].madonvi)
					html += '<option value="'+data[i].madonvi+'">'+data[i].tendonvitinh+'</option>';
				}
				$(str).html(html);
				$(str).val(madonvi);
			});
		
		this.index++;
		numberReady();
	}
	this.removeRow = function(pos)
	{
		var nhapkhoid = $('#nhapkhoid-'+pos).val();
		$('#delnhapkho').val(nhapkhoid+ "," +$('#delnhapkho').val());
		$('#row'+pos).remove();
	}
}

var objdl = new DinhLuong();
$('#btnSelectKhachHang').click(function(e) {
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
	$('.item').click(function(e) {
        $('#nguoinhanid').val($(this).attr('username'));
		$('#nguoinhan').val($(this).attr('fullname'));
		$("#popup").dialog( "close" );
    });
}
$('#btnAddRow').click(function(e) {
	$("#popup").attr('title','Chọn sản phẩm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			buttons: {
				
				
				'Chọn': function() 
				{
					$('#productselect .listid').each(function(index, element) {
                        //alert($(this).val());
						var id = 0;
						var mediaid = $(this).val();
						
						
						var code = $(this).attr('code');
						var unit = $(this).attr('unit');
						var title = $(this).attr('title');
						var price = $(this).attr('price');
						
						objdl.addRow(id,mediaid,code,title,0,unit,price);
                    });
					$(this).dialog("close");
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=addon/order/browseProduct",function(){
			$("#popup").dialog("open");	
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
						$("#popup").attr('title','Phiếu nhập kho');
						$( "#popup" ).dialog({
							autoOpen: false,
							show: "blind",
							hide: "explode",
							width: 900,
							height: 600,
							modal: true,
							close: function(ev, ui){
									window.location = "?route=quanlykho/phieuxuat";
								},
							buttons: {
								
								'In':function()
								{
									openDialog("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=print",800,500)
									window.location = "?route=quanlykho/phieuxuat";
								},
								'Đóng': function() 
								{
									
									$( this ).dialog( "close" );
									window.location = "?route=quanlykho/phieuxuat";
								},
							}
						});
					
						
						$("#popup-content").load("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=true",function(){
							$("#popup").dialog("open");
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

$("#manhom").val("<?php echo $item['manhom']?>");
$("#loai").val("<?php echo $item['loai']?>");

$("#madonvi").val("<?php echo $item['madonvi']?>");

var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
</script>

