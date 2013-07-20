<h3>Thống kê danh thu</h3>
<table>
	<tr>
    	<th>STT</th>
        <th>Thời gian bán</th>
        <th>Mã đơn hàng</th>
        <th>Số tiền</th>
    </tr>
	<?php foreach($data_order as $key => $order){ ?>
    <?php $sum = 0;?>
	<tr>
    	<td><?php echo $key + 1?></td>
        <td><?php echo $this->date->formatMySQLDate($order['createtime'],'longdate')?></td>
        <td><?php echo $order['code']?></td>
        <td class="number"><?php echo $this->string->numberFormate($order['total'])?></td>
    </tr>
	<?php }?>	    
</table>

