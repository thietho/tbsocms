<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content padding1">
    
    	<form id="frm_inventorycheck" action="<?php echo $action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	<input type="button" value="Lưu" class="button" onClick="inven.save()"/>
                <input type="button" value="Trở về" class="button" onClick="window.location = '?route=quanlykho/inventorycheck';"/>
     	        <input type="hidden" name="id" value="<?php echo $item['id']?>">
                <input type="hidden" name="nhanvienid" value="<?php echo $item['nhanvienid']?>">
                
                
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
            <div id="inventorycheck">
            	<ul class="tabs-nav">
                    <li class="tabs-selected"><a href="#fragment-thongtin"><span>Thông tin kiềm kho</span></a></li>
                    <li class="tabs"><a href="#fragment-sanpham"><span>Sản phẩm</span></a></li>
                </ul>
                <div id="fragment-thongtin">
                	<p>
                        <label>Ngày kiểm</label><br />
                        
                        <input type="text" class="text"  id="datecheck" name="datecheck" value="<?php echo $this->date->formatMySQLDate($item['datecheck'])?>"/>
                        <script language="javascript">
                            $(function() {
                                $("#datecheck").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: 'dd-mm-yy'
                                        });
                                });
                         </script>
                    </p>
                    <p>
                        <label>Ghi chú</label><br />
                        <textarea id="note" name="note"><?php echo $item['note']?></textarea>
                        
                    </p>
                </div>
                <div id="fragment-sanpham">
                	<table>
                    	<thead>
                            <tr>
                                
                                <th>Sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Đơn vị tính</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="listproduct">
                        	
                        </tbody>
                	</table>
                    <input type="hidden" id="delinventoryid" />
                    <input type="button" class="button" id="btnAddRow" value="Thêm dòng"/>
                </div>
            </div>
            
		</form>
    </div>
</div>
<script language="javascript">
$(document).ready(function(e) {
	$('#inventorycheck').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	$("#listproduct").sortable();
});
function Inventory()
{
	this.index = 0;
	this.save = function()
	{
		$.blockUI({ message: "<h1>Please wait...</h1>" });
		$.post("?route=quanlykho/inventorycheck/save",$('#frm_inventorycheck').serialize(),function(data){
			var obj = $.parseJSON(data);
			if(obj.error == '')
			{
				//$('#error').html('').hide('slow');
				window.location = '?route=quanlykho/inventorycheck/update&id='+obj.id;
			}
			else
			{
				$('#error').html(obj.error).show('slow');	
			}
			$.unblockUI();
		});	
	}
	this.addRow = function(id,mediaid,title,quantity)
	{
		var str = '<tr>';
		str += '<td><input type="hidden" id="id-'+ this.index +'" value="'+ id +'"><input type="hidden" id="mediaid-'+ this.index +'" value="'+ mediaid +'">'+title+'</td>';
		str += '<td><input type="number" id="quantity-'+ this.index +'" value="'+quantity+'"></td>';
		str += '<td class="number"><select mediaid="'+mediaid+'" class="madonvi" id="madonvi-'+ this.index +'" value="'+madonvi+'" ref="'+ this.index +'"></select></td>';
		str += '</tr>';
		$('#listproduct').append(str);
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
	}
}
var inven = new Inventory();
</script>