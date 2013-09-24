<table class="data-table">
	<thead>
        <tr>
        	<th>Mã phiếu</th>
        	<th>Tên sản phẩm</th>
            <th>Khách hàng</th>
            <th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá bán</th>
            <th>Giảm %</th>
            <th>Giảm</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0?>
    	<?php foreach($data_banhang as $date => $banhang){ ?>
        <tr>
        	<td colspan="5"><strong><?php echo $this->date->formatMySQLDate($date)?></strong></td>
        </tr>
        	<?php foreach($banhang as $item) { ?>
        	<?php $sum += $item['thanhtien']?>
        <tr>
        	<td><a onclick="objdl.viewPX(<?php echo $item['phieuid']?>)"><?php echo $item['maphieu']?></a></td>
        	<td>
            	<?php echo $item['title']?>
                <?php if($item['code']){ ?>
                (<?php echo $item['code']?>)
                <?php } ?>
            </td>
            <td><?php echo $item['nguoinhan']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['soluong'])?></td>
            <td><?php echo $this->document->getDonViTinh($item['madonvi'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['giatien'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['phantramgiamgia'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['giamgia'])?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['thanhtien'])?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
        <tr>
        	<td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="number">Tổng cộng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
    </tbody>
</table>