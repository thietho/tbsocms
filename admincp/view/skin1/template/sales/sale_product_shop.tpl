<div id="shopsearch">
    <input type="text" class="text" id="keyword" size="100" placeholder="Tìm kiếm sản phẩm"/>
    <select id="brand">
        <option value="">Tất cả nhản hiệu</option>
        <?php foreach($nhanhieu as $it){ ?>
        <option value="<?php echo $it['categoryid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo $it['categoryname']?></option>                        
        <?php } ?>
    </select>
    <select id="sitemapid">
        <option value="">Tất cả danh mục</option>
        <?php foreach($sitemaps as $sitemap){ ?>
        <?php if($sitemap['moduleid'] == 'module/product'){ ?>
        <option value="<?php echo $sitemap['sitemapid']?>"><?php echo $this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$sitemap['level']) ?><?php echo $sitemap['sitemapname']?></option>
        <?php } ?>
        <?php } ?>
    </select>
    
</div>
<div id="product-content"></div>
<script language="javascript">
$(document).ready(function(e) {
    saleOrder.loadProduct();
});
$('#shopsearch #keyword').keyup(function(e) {
    if(e.keyCode == 13)
		saleOrder.loadProduct();
});
$('#shopsearch select').change(function(e) {
    saleOrder.loadProduct();
});

</script>