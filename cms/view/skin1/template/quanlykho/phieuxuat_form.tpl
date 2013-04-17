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
                    <li class="tabs"><a href="#fragment-nguyenlieu"><span>Nguyên liệu</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                    <p>
                        <label>Người xuất</label><br />
                        <input type="text" id="nguoithuchien" name="nguoithuchien" value="<?php echo $item['nguoithuchien']?>" class="text" size=60 <?php echo $readonly?>/>
                        
                    </p>
                    <p>
                        <label>Nhà cung cấp</label><br />
                        <span id="nhacungcapview"></span>
                        <input type="hidden" id="nhacungcapid" name="nhacungcapid" value="<?php echo $item['nhacungcapid']?>">
                        <input type="hidden" id="tennhacungcap" name="tennhacungcap" value="<?php echo $item['tennhacungcap']?>">
                        <input type="button" class="button" id="btnSeleteNhaCungCap" value="Chọn nhà cung cấp">
                        
                    </p>
                    <p>
                        <label>Người nhận</label><br />
                        <input type="text" id="nguoinhan" name="nguoinhan" value="<?php echo $item['nguoinhan']?>" class="text" size=60 />
                        
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="ghichu" name="ghichu"></textarea>
                        
                    </p>
                   
                </div>
                <div id="fragment-nguyenlieu">
                	<table>
                    	<tr>
                            <th>Nguyên liệu</th>
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
	objdl.addRow("<?php echo $dl['id']?>","<?php echo $dl['meidaid']?>","<?php echo $dl['code']?>","<?php echo $dl['title']?>","<?php echo $dl['soluong']?>","<?php echo $dl['madonvi']?>","<?php echo $dl['giatien']?>");
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
	this.addRow = function(id,meidaid,code,title,soluong,madonvi,giatien)
	{
		var row = '<tr id="row'+ this.index +'">';
		row +='<td><input type="hidden" id="nhapkhoid-'+ this.index +'" name="nhapkhoid['+ this.index +']" value="'+ id +'" /><input type="hidden" id="meidaid-'+ this.index +'" name="meidaid['+ this.index +']" value="'+ meidaid +'" />'+ code +' - '+ title +'</td>';
		row +='<td class="number"><input type="text" id="soluong-'+ this.index +'" name="soluong['+ this.index +']" value="'+soluong+'" class="text number" /></td>';
		row +='<td class="number"><select meidaid="'+meidaid+'" id="madonvi-'+ this.index +'" name="dlmadonvi['+ this.index +']" value="'+madonvi+'"></section></td>';
		row +='<td class="number"><input type="text" id="giatien-'+ this.index +'" name="giatien['+ this.index +']" value="'+giatien+'" class="text number" /></td>';
		row +='<td><input type="button" class="button" value="Xóa" onclick="objdl.removeRow('+ this.index +')"/></td>';
		row+='</tr>'
		$('#nhapkhonguyenlieu').append(row);
		var str = '#madonvi-'+ this.index;
		$.getJSON("?route=quanlykho/nguyenlieu/getListDonVi&meidaid="+ meidaid,
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
$('#btnSeleteNhaCungCap').click(function(e) {
    $("#popup").attr('title','Chọn nhà cung cấp');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
		});
	
		
		$("#popup-content").load("?route=quanlykho/nhacungcap&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
function intSelectNhaCungCap()
{
	$('.item').click(function(e) {
        $('#nhacungcapid').val($(this).attr('id'));
		$('#tennhacungcap').val($(this).attr('tennhacungcap'));
		$('#nhacungcapview').html($(this).attr('tennhacungcap'));
		$("#popup").dialog( "close" );
    });
}
$('#btnAddRow').click(function(e) {
    $("#popup").attr('title','Chọn nguyên liệu');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 900,
			height: 600,
			modal: true,
			buttons: {
				
				
				
				'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},
				'Chọn': function() 
				{
					$('.selectitem').each(function(index, element) {
						var id = 0;
						var meidaid = this.id;
						var code = $(this).attr('code');
						var title = $(this).attr('title');
						var soluong = 0;
						var madonvi = $(this).attr('madonvi');
						objdl.addRow(id,meidaid,code,soluong,madonvi,0);
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
					
				},
			}
		});
	
		
		$("#popup-content").load("?route=quanlykho/nguyenlieu&opendialog=true",function(){
			$("#popup").dialog("open");
		});
});
function intSelectNguyenLieu()
{
	$('.item').click(function(e) {
	
		if($('#popup-seletetion #'+this.id).html() == undefined)
		{
			var html = "<div><div class='selectitem left' id='"+ this.id +"' manguyenlieu="+$(this).attr('manguyenlieu')+" code="+$(this).attr('code')+" madonvi='"+$(this).attr('madonvi')+"'>"+$(this).attr('manguyenlieu')+":"+ $(this).attr('code') +"   </div><a class='removeitem button right'>X</a><div class='clearer'>^&nbsp;</div></div>";
			$('#popup-seletetion').append(html);
			
			$('.removeitem').click(function(e) {
				$(this).parent().remove();
			});
		}
		
	});	
}

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
									
									$( this ).dialog("close");
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

