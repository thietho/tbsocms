<link href="<?php echo DIR_CSS?>jquery.nestable.css" rel="stylesheet">
<script src="<?php echo DIR_JS?>jquery.nestable.js"></script>
<div id="page-wrapper">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
            	<?php echo $this->document->title?>
                <?php if($this->user->checkPermission("quanlykho/donvitinh/insert")==true){ ?>
                <input class="btn btn-primary" value="Thêm" type="button"  onclick="window.location = '<?php echo $insert?>'">
                <?php } ?>
                <?php if($this->user->checkPermission("quanlykho/donvitinh/delete")==true){ ?>
                <input class="btn btn-danger" type="button" name="delete_all" value="Xóa" onclick="deleteitem()"/>
                <?php } ?>
            </h1>
        </div>
        
        <!-- /.col-lg-12 -->
    </div>
        <!-- /.row -->
    <div class="row">
    	
        <div class="col-lg-12">
            <div class="panel panel-default">
                
                <div class="panel-body">
                    <div class="dataTable_wrapper">
                    	<form action="" method="post" id="listitem" name="listitem">
                            <div class="dd" id="nestable">
                                <ol class="dd-list">
                            	<?php echo $tree?>
                                </ol>
                            </div>
                        </form>
                    </div>
                    <!-- /.table-responsive -->
                
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    
    
</div>
<textarea id="nestable-output"></textarea>
<script language="javascript">
var updateOutput = function(e)
{
	var list   = e.length ? e : $(e.target),output = list.data('output');
	if (window.JSON) {
		$('#nestable-output').val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
	} else {
		$('#nestable-output').val('JSON browser support required for this demo.');
	}
};
$(document).ready(function(e) {
    $('#nestable').nestable({
       
    })
    .on('change', updateOutput);
});
function deleteitem()
{
	var answer = confirm("<?php echo $announ_del ?>")
	if (answer)
	{
		$.post("?route=core/category/delete", 
				$("#listitem").serialize(), 
				function(data)
				{
					if(data!="")
					{
						alert(data)
						window.location.reload();
					}
				}
		);
	}
}

function updateposition()
{
	$.post("?route=core/category/updateposition", 
			$("#listitem").serialize(), 
			function(data)
			{
				if(data!="")
				{
					alert(data)
					window.location.reload();
				}
			}
	);
	
}

</script>