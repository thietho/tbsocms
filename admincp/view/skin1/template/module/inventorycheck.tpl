<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	
        <div>
        	<div class="right">
                <?php if($this->user->checkPermission("module/inventorycheck/insert")==true){ ?>
                <a class="button" onclick="">Tạo đợt kiểm kho</a>
				<?php } ?>
                
                <?php if($this->user->checkPermission("module/inventorycheck/deleted")==true){ ?>
                <a class="button" onclick="pro.deleteProduct()">Xóa</a>&nbsp;
                <?php } ?>
                
            </div>
            <div class="clearer">^&nbsp;</div>
        </div>
    </div>
</div>