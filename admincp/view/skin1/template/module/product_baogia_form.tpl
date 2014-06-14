<div class="section" id="sitemaplist">
	<div class="section-title"><?php echo $this->document->title?></div>
    <div class="section-content padding1">
    
    	<form id="frm_baogia">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="bg.save('')"/>
                <input type="button" value="Lưu & In" class="button" onClick="save('print')"/>
     	        <input type="button" value="Bỏ qua" class="button" onclick="linkto('?route=quanlykho/phieuxuat')"/>   
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="baogia">
                <ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin phiếu nhập</span></a></li>
                    <li class="tabs"><a href="#fragment-detail"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                	<p>
                        <label>Ngày</label>
                        <input type="date" class="text" id="ngaybaogia" name="ngaybaogia" value="<?php echo $item['ngaybaogia']?>"/>
                    </p>
                    <p>
                        <label>Ghi chú</label><br>
                        <textarea id="ghichu" name="ghichu"><?php echo $item['ghichu']?></textarea>
                    </p>
                </div>
                <div fragment-detail>
                    <table class="data-table">
                        <thead>
                            <tr>
                            	<th><input type="checkbox" onclick="$('.rowselect').attr('checked',this.checked)"/></th>
                                <th>Tên sản phẩm</th>
                                <th>Nhẵn hiệu</th>
                                <th>Giá</th>
                                <th>Ghi chú</th>
                            </tr>
                        </thead>
                        <tbody id="baogialistproduct">
                        </tbody>
                    </table>
                    <input type="hidden" id="delid" name="delid" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm sản phẩm"/>
                    <input type="button" class="button" id="btnDel" value="Xóa"/>
                </div>                
           </div>
		</form>
    </div>
    
</div>
    

<script language="javascript">
$(document).ready(function(e) {
    $('#baogia').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
	
});
function BaoGia()
{
	this.index = 0;
	this.newRow = function(obj)
	{
		var row = '<tr id="row'+this.index+'" class="item">';
		row += '<td align="center"><input type="checkbox" class="rowselect" value="'+ this.index +'"/></td>';
		row += '<td><input type="hidden" id="arrid-'+ this.index +'" name="arrid['+ this.index +']" value="'+ obj.id +'" /><input type="hidden" id="mediaid-'+ this.index +'" name="mediaid['+ this.index +']" value="'+ obj.mediaid +'" />'+ obj.productname +'</td>';
		row += '<td>'+ obj.brandname +'</td>';
		var price = obj.price;
		if(obj.pricepromotion>0)
			price = obj.pricepromotion;
		row += '<td><input type="text" class="text number" id="gia-'+ this.index +'" name="gia['+ this.index +']" value="'+price+'"></td>';
		if(obj.ghichu == undefined)
			obj.ghichu = "";
		row += '<td><input type="text" class="text" id="arrghichu-'+ this.index +'" name="arrghichu['+ this.index +']" value="'+obj.ghichu+'"></td>';
		row += '</tr>'
		this.index++;
		
		$('#baogialistproduct').append(row);
		numberReady();
	}
	this.save = function(type)
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
		$.post("?route=module/product/savebaogia", $("#frm_baogia").serialize(),
			function(data){
				var arr = $.parseJSON(data);
				if(arr.error == "")
				{
					switch(type)
					{
						case "":
							window.location = "?route=module/product";
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
								height: window.innerHeight,
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
						
							$("#popup").dialog("open");
							$("#popup-content").html(loading);
							$("#popup-content").load("?route=quanlykho/phieuxuat/view&id="+id+"&opendialog=true",function(){
								
							});
					}
				}
				else
				{
				
					$('#error').html(arr.error).show('slow');
					$.unblockUI();
					
				}
				
			}
		);
	}
}
var bg = new BaoGia();
$('#btnAddRow').click(function(e) {
	browseProduct();
});
$('#btnDel').click(function(e) {
    $('.rowselect').each(function(index, element) {
        if(this.checked)
		{
			$('#delid').val($('#delid').val()+","+ $('#arrid-'+this.value).val());
			$('#row'+this.value).remove();
		}
    });
});
</script>
<?php foreach($medias as $media){ ?>
<script language="javascript">
	var obj = new Object();
	obj.id = 0;
	obj.mediaid = "<?php echo $media['mediaid']?>";
	obj.productname = "<?php echo $this->document->productName($media)?>";
	obj.brandname = "<?php echo $this->document->getCategory($media['brand'])?>";
	obj.price = "<?php echo $media['price']?>";
	obj.pricepromotion = "<?php echo $media['pricepromotion']?>";
	
	bg.newRow(obj);
	numberReady();
</script>
<?php } ?>
<?php foreach($detail as $media){ ?>
<script language="javascript">
	var obj = new Object();
	obj.id = "<?php echo $media['id']?>";
	obj.mediaid = "<?php echo $media['mediaid']?>";
	obj.productname = "<?php echo $this->document->productName($media)?>";
	obj.brandname = "<?php echo $this->document->getCategory($media['brand'])?>";
	obj.price = "<?php echo $media['gia']?>";
	obj.pricepromotion = 0;
	obj.ghichu = "<?php echo $media['ghichu']?>";
	bg.newRow(obj);
	numberReady();
</script>
<?php } ?>