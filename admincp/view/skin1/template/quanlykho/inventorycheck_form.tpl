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
		</form>
    </div>
</div>
<script language="javascript">
function Inventory()
{
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
}
var inven = new Inventory();
</script>