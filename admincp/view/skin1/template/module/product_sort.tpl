<form id="frm_sortproduct">
	<input type="hidden" name="sort" value="<?php echo 'sort'.$this->request->get['sitemapid'].$this->request->get['status'].$this->request->get['brand']?>">
    <?php foreach($medias as $key => $media) {?>
    <div class="product-item left" ref="<?php echo $media['mediaid']?>" style="background:url('<?php echo $media['imagepreview']?>') no-repeat center center;">
        <input type="hidden" class="listid" name="mediaid[]" value="<?php echo $media['mediaid']?>">
        <table height="100%">
            
            <tr valign="middle">
                <td align="center">
                    <?php echo $this->document->productName($media)?><br />
                    Giảm: <?php echo $this->string->numberFormate($media['discountpercent'])?>%<br />
                    Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                    Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?><br />
                    Tồn: <?php echo $media['tonkho']?>
                </td>
            </tr>
        </table>
    </div>
    <?php }?>
</form>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#frm_sortproduct').sortable();
});
</script>