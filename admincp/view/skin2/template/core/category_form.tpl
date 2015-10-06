<div id="page-wrapper">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
            	<?php echo @$this->document->title?>
                <input type="button" value="<?php echo @$button_save ?>" class="btn btn-primary" onClick="save()"/>
     	        <input type="button" value="<?php echo @$button_cancel ?>" class="btn btn-danger" onclick="linkto('?route=core/category')"/>   
            </h1>
        </div>
        
        <!-- /.col-lg-12 -->
    
    	<div class="col-lg-12">
            <form name="frm" id="frmCat" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<?php echo @$item['id']?>">
                <div id="error" class="panel panel-danger" style="display:none">
                	<div class="panel-heading">
                        Errors
                    </div>
                    <div class="panel-body"></div>
                </div>
                <div class="form-group">
                    <label><?php echo @$text_categoryID ?></label>
                    <input type="text" name="categoryid" value="<?php echo @$item['categoryid']?>" class="form-control" <?php echo @$readonly?>/>
                </div>
                <div class="form-group">
                    <label><?php echo @$text_categroyname ?></label>
                    <input type="text" name="categoryname" value="<?php echo @$item['categoryname']?>" class="form-control" />
                </div>
                <div class="form-group">
                    <label><?php echo @$text_category_parent?></label>
                    <select id="parent" name="parent" class="form-control">
                        <?php foreach($datas as $it){ ?>
                        <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>
                        <?php } ?>
                    </select>
                </div>
            </form>
            
        </div>
    </div>
</div>

<?php
	$parent =$item['parent'];
	if($_GET['parent'] !="")
    	$parent = $_GET['parent'];
    
?>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1><?php echo @$announ_infor ?></h1>" }); 
	
	$.post("?route=core/category/save", $("#frmCat").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=core/category";
			}
			else
			{
			
				$('#error .panel-body').html(data);
				$('#error').show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}
$(document).ready(function() {
	
	$("#parent").val("<?php echo @$parent?>");
	
	
});

</script>
