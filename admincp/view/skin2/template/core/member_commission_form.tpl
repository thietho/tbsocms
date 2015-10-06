<div class="section" id="sitemaplist">

	<div class="section-title"><?php echo @$header_category ?></div>
    
    <div class="section-content padding1">
    
    	<form name="frm" id="frm" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
        
        	<div class="button right">
            	 <input type="hidden" id="memberid" name="memberid" value="<?php echo @$member['id']?>"/>
            	<input type="button" value="<?php echo @$button_save ?>" class="button" onClick="save()"/>
     	        <input type="button" value="<?php echo @$button_cancel ?>" class="button" onclick="linkto('?route=core/category')"/>   
     	        <input type="hidden" name="id" value="<?php echo @$item['id']?>">
            </div>
            <div class="clearer">^&nbsp;</div>
        	<div id="error" class="error" style="display:none"></div>
        	<div>   
            	<p>
                    <label>Ngày tính hoa hồng</label><br />
                    <input type="text" class="text date" id="ngaytinhhoahong" name="ngaytinhhoahong" />
					<script language="javascript">
                    $(function() {
                        $("#ngaytinhhoahong").datepicker({
                                changeMonth: true,
                                changeYear: true,
                                dateFormat: 'dd-mm-yy'
                                });
                        });
                    </script>
                </p>     
               
                
            </div>
            
        </form>
    
    </div>
    
</div>

<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1><?php echo @$announ_infor ?></h1>" }); 
	
	$.post("?route=core/category/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=core/category";
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