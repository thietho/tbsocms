<h2>Các sản phẩm đang có ở shop</h2>
<div>
	<table>
        <?php foreach($data_product as $media){ ?>
        <tr>
        	<td>
            	<?php echo $this->document->productName($media)?>
            </td>
            <td>
            	
            </td>
            <td><img src="<?php echo $media['icon']?>"></td>
        </tr>
    <?php } ?>
    </table>
</div>