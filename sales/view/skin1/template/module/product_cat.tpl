<div class="pro-item procat left" ref=''>
	<table>
    	<tr>
        	<td>
            	Tất cả sản phẩm
            </td>
        </tr>
    </table>
</div>
<?php foreach($catshow as $sitemap){ ?>
<div class="pro-item procat left" ref='<?php echo $sitemap['sitemapid']?>'>
	<table>
    	<tr>
        	<td>
            	<?php echo $sitemap['sitemapname']?>
            </td>
        </tr>
    </table>
</div>
<?php }?>
<script language="javascript">
$('.procat').click(function(e) {
	url ="?route=page/home/showProductForm&sitemapid="+ $(this).attr('ref');
    $('#main-screen').load(url);
	pro.history.push(url);
});
</script>