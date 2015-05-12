<link rel="stylesheet" type="text/css" href="<?php echo DIR_CSS?>style.css">
<div class="section">
	<div class="section-title"><?php echo $this->document->title?></div>	
    <div class="section-content">					
        <select id="shopid" name="shopid">
            <option value="">Chọn cửa hàng</option>
            <?php foreach($data_shop as $shop){ ?>
            <option value="<?php echo $shop['id']?>"><?php echo $shop['shopname']?></option>
            <?php }?>
        </select>
	</div>
    <div id="product-content"></div>
    <div id="sale-order">
    djk knfladnljas
    </div>
</div>
<script language="javascript">
$('#shopid').change(function(e) {
	$('#product-content').load('?route=sales/sale/listProduct&shopid='+this.value);
    
});
</script>