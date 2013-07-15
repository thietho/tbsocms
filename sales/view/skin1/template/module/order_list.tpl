<table>
	<tr>
    	<th>Mã đơn hàng</th>
        <th></th>
    </tr>
    <?php foreach($data_order as $order){ ?>
    <tr>
    	<td><?php echo $order['code']?></td>
        <td><input type="button" class="button" class="btnSeleteOrder" value="Chọn" onClick="pro.loadOrder(<?php echo $order['id']?>)"></td>
    </tr>
    <?php }?>
</table>
