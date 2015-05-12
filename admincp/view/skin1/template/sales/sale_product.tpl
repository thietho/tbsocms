<h2>Các sản phẩm đang có ở shop</h2>
<div>
	<?php foreach($data_product as $media){ ?>
    <div>
    	<?php echo $this->document->productName($media)?>
    </div>
    <?php } ?>
</div>