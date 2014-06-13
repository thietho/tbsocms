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
                        <input type="date" class="text" id="ngaybaogia" name="ngaybaogia" />
                    </p>
                    <p>
                        <label>Ghi chú</label><br>
                        <textarea id="ghichu" name="ghichu"></textarea>
                    </p>
                </div>
                <div fragment-detail>
                    <table class="data-table">
                        <thead>
                            <tr>
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
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
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
		var row = '<tr id="'+this.index+'">';
		row += '<td><input type="hidden" id="arrid-'+ this.index +'" name="arrid['+ this.index +']" value="'+ obj.id +'" /><input type="hidden" id="mediaid-'+ this.index +'" name="mediaid['+ this.index +']" value="'+ obj.mediaid +'" />'+ obj.productname +'</td>';
		row += '<td>'+ obj.brandname +'</td>';
		var price = obj.price;
		if(obj.pricepromotion>0)
			price = obj.pricepromotion;
		row += '<td><input type="text" class="text number" id="gia-'+ this.index +'" name="gia['+ this.index +']" value="'+price+'"></td>';
		row += '<td><input type="text" class="text" id="arrghichu-'+ this.index +'" name="arrghichu['+ this.index +']"></td>';
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
				var arr = data.split("-");
				if(arr[0] == "true")
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
				
					$('#error').html(data).show('slow');
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
$('.selectProduct').click(function(e) {
	alert($(this).attr('ref'));
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
	bg.newRow(obj)
	numberReady();
</script>
<?php } ?>