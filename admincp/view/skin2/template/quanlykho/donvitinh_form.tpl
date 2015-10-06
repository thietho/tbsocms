<div id="page-wrapper">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
            	<?php echo @$this->document->title?>
            </h1>
            <form name="frm" id="frm" action="<?php echo @$action?>" method="post" enctype="multipart/form-data">
        
                
                <input type="hidden" name="id" value="<?php echo @$item['madonvi']?>"/>
                <div id="error" class="error" style="display:none"></div>
                <div>
                	<div class="form-group">
                        <label>Mã đơn vị tính</label>
                        <input type="text" name="madonvi" value="<?php echo @$item['madonvi']?>" class="form-control" <?php echo @$readonly?>/>
                    </div>
                    <div class="form-group">
                        <label>Tên đơn vị tính</label>
                        <input type="text" name="tendonvitinh" value="<?php echo @$item['tendonvitinh']?>" class="form-control"/>
                    </div>
                    <div class="form-group">
                        <label>Quy đổi</label>
                        <input type="text" name="quidoi" value="<?php echo @$item['quidoi']?>" class="form-control number"/>
                    </div>
                   <div class="form-group">
                        <label>Đơn vị qui đổi</label>
                        <select id="madonviquydoi" name="madonviquydoi" class="form-control">
                            <option value=""></option>
                            <?php foreach($listdonvitinh as $it){ ?>
                            <option value="<?php echo @$it['madonvi']?>"><?php echo @$it['tendonvitinh']?></option>
                            <?php } ?>
                        </select>
                    </div>
                   	
                    
                   
                   
                </div>
                <center>
                    <input type="button" value="Lưu" class="btn btn-primary" onClick="save()"/>
                    <input type="button" value="Bỏ qua" class="btn btn-default" onclick="window.location = '?route=quanlykho/donvitinh'"/>   
                    
                </center>
                
            </form>
        </div>
   	</div>
</div>
<script language="javascript">
function save()
{
	$.blockUI({ message: "<h1>Please wait...</h1>" }); 
	
	$.post("?route=quanlykho/donvitinh/save", $("#frm").serialize(),
		function(data){
			if(data == "true")
			{
				window.location = "?route=quanlykho/donvitinh";
			}
			else
			{
			
				$('#error').html(data).show('slow');
				$.unblockUI();
				
			}
			
		}
	);
}

$("#madonviquydoi").val("<?php echo @$item['madonviquydoi']?>");
</script>
