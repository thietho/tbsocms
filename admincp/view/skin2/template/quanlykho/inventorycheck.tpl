<div class="section">

	<div class="section-title"><?php echo @$this->document->title?></div>
    
    <div class="section-content">
    	
        <div>
        	<div class="right">
                <?php if(@$this->user->checkPermission("quanlykho/inventorycheck/check")==true){ ?>
                <a class="button" href="?route=quanlykho/inventorycheck/check">Đối chiếu tồn kho</a>
				<?php } ?>
                <?php if(@$this->user->checkPermission("quanlykho/inventorycheck/insert")==true){ ?>
                <a class="button" href="?route=quanlykho/inventorycheck/insert">Tạo đợt kiểm kho</a>
				<?php } ?>
                <?php if(@$this->user->checkPermission("quanlykho/inventorycheck/deleted")==true){ ?>
                <a class="button" onclick="deleteitem()">Xóa</a>&nbsp;
                <?php } ?>
                
            </div>
            <div class="clearer">^&nbsp;</div>
            <div id="listinventory"></div>
        </div>
    </div>
</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#listinventory').load("?route=quanlykho/inventorycheck/getList");
});
function deleteitem()
{
	var answer = confirm("Bạn có muốn xóa không?")
	if (answer)
	{
		$.post("?route=quanlykho/inventorycheck/delete", 
				$("#frm_listinventory").serialize(), 
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
</script>
