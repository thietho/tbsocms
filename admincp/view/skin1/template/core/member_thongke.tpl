<table id="reportbanhang" class="data-table">
	<thead>
        <tr>
        	
        	<th>Mã phiếu</th>
            <th>Khách hàng</th>
            <th>Điện thoại</th>
            <th>Địa chỉ</th>
            <th>Giá trị đơn hàng</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0?>
    	<?php foreach($data_banhang as $memberid => $banhang){ ?>
        <tr>
        	<td colspan="6"><strong><?php echo $this->document->getCustomer($memberid)?></strong></td>
        </tr>
        	<?php foreach($banhang as $item) { ?>
        	<?php $sum += $item['tongtien']?>
        <tr>
        	
        	<td><a onclick="objdl.viewPX(<?php echo $item['phieuid']?>,'')"><?php echo $item['maphieu']?></a></td>
        	
            
            <td><?php echo $item['tenkhachhang']?></td>
            <td><?php echo $item['dienthoai']?></td>
            <td><?php echo $item['diachi']?></td>
            <td class="number"><?php echo $this->string->numberFormate($item['tongtien'])?></td>
        </tr>
        	<?php } ?>
        <?php } ?>
        <tr>
            <td class="number" colspan="4">Tổng cộng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Hoa hồng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum*10/100)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Công nợ hiện tại</td>
            <td class="number"><?php echo $this->string->numberFormate($congno)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Thanh toán hoa hồng</td>
            <td class="number"><?php echo $this->string->numberFormate($sum*10/100 - $congno)?></td>
        </tr>
    </tbody>
</table>