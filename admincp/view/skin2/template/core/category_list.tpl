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
                        <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                            <thead>
                                <tr>
                                    <th width="1%"><input class="inputchk" type="checkbox" onclick="$('input[name*=\'delete\']').attr('checked', this.checked);"></th>
                                    <th>Mã đơn vị</th>
                                    <th>Tên đơn vị</th>
                                    <th>Quy đổi</th>
                                    <th>Đơn vị qui đổi</th>
                                    <th>Control</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                    foreach($datas as $item)
                                    {
                                ?>
                                <tr class="odd gradeX">
                                    <td><input class="inputchk" type="checkbox" name="delete[<?php echo $item['madonvi']?>]" value="<?php echo $item['madonvi']?>" ></td>
                                    <td><?php echo $item['madonvi']?></td>
                                    <td><?php echo $item['tendonvitinh']?></td>
                                    <td><?php echo $this->string->numberFormate($item['quidoi'])?></td>
                                    <td class="center">
                                        <?php echo $this->document->getDonViTinh($item['madonviquydoi'])?>
                                        <?php if($item['madonviquydoi']!=""){ ?>
                                        (<?php echo $item['madonviquydoi']?>)
                                        <?php } ?>
                                    </td>
                                    <td class="center">
                                        <?php if($this->user->checkPermission("quanlykho/donvitinh/update")==true){ ?>
                                        <a class="btn btn-default" href="<?php echo $item['link_edit']?>" title="<?php echo $item['text_edit']?>"><?php echo $item['text_edit']?></a>
                                        <?php } ?>
                                    </td>
                                </tr>
                                
                               <?php } ?>
                                
                            </tbody>
                        </table>
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

<script language="javascript">

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