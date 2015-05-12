<h2>Các sản phẩm đang có ở shop</h2>
<div>
	<table>
        <?php foreach($data_product as $media){ ?>
        <tr>
        	<td>
            	<?php echo $this->document->productName($media)?>
            </td>
            <td><img src="<?php echo $media['icon']?>"></td>
            <td>
            	<input type="button" class="button" value="Đưa vào đơn hàng">
            </td>
        </tr>
    <?php } ?>
    </table>
</div>