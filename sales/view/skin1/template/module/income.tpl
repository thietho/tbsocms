<h3>Thống kê danh thu</h3>
<table>
	<tr>
    	<th>STT</th>
        <th>Thời gian bán</th>
        <th>Mã đơn hàng</th>
        <th>Số tiền</th>
    </tr>
    <?php $sum = 0;?>
	<?php foreach($data_order as $key => $order){ ?>
    <?php $sum += $order['total'];?>
	<tr>
    	<td align="center"><?php echo $key + 1?></td>
        <td align="center"><?php echo $this->date->formatMySQLDate($order['createtime'],'longdate')?></td>
        <td align="center"><?php echo $order['code']?></td>
        <td class="number"><?php echo $this->string->numberFormate($order['total'])?></td>
    </tr>
	<?php }?>	
    <tr>
    	<td colspan="3" align="right">Tổng doanh thu:</td>
        <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
    </tr>    
</table>

<h3>Các sản phẩm đã bán</h3>
<table>
	<tr>
    	<th>Tên sản phẩm</th>
        <th>Mã sản phẩm</th>
        <th>Số lượng</th>
        <th>ĐVT</th>
    </tr>
    <?php foreach($data_ct as $ct){ ?>
    <tr>
    	<td><?php echo $ct['title']?></td>
        <td><?php echo $ct['code']?></td>
        <td class="number"><?php echo $ct['total']?></td>
        <td><?php echo $this->document->getDonViTinh($ct['unit'])?></td>
    </tr>
    <?php } ?>
</table>