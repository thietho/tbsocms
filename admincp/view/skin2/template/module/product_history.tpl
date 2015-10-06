<h3><?php echo @$this->document->productName($media)?></h3>


<table class="data-table">
	<thead>
        <tr>
        	<th colspan="7">Nhập kho</th>
            <th colspan="7">Xuất kho</th>
        </tr>
        <tr>
        	<th>Mã phiếu</th>
            <th>Nhập từ</th>
        	<th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá</th>
            <th>Giảm giá</th>
            <th>Thành tiền</th>
            <th>Mã phiếu</th>
            <th>Khách hàng</th>
            <th>Số lượng</th>
            <th>Đơn vị</th>
            <th>Giá</th>
            <th>Giảm giá</th>
            <th>Thành tiền</th>
        </tr>
    </thead>
    <?php if(count($nhapxuat)){ ?>
    <tbody>
    	<?php foreach($nhapxuat as $date => $item){?>
        <tr>
        	<td colspan="8"><strong><?php echo @$this->date->formatMySQLDate($date)?></strong></td>
        </tr>
    		<?php $max = max(count($item['nhapkho']),count($item['xuatkho']))?>
        	<?php for($i=0;$i < $max;$i++){ ?>
        <tr class="item">
        	<td><a onclick="objdl.viewPN(<?php echo @$item['nhapkho'][$i]['phieuid']?>)"><?php echo @$item['nhapkho'][$i]['maphieu']?></a></td>
            <td>
            	<?php echo @$this->document->getCategory($item['nhapkho'][$i]['loaiphieu'])?>:
                <?php if(@$item['nhapkho'][$i]['tenkhachhang'])
                    {
                        echo $item['nhapkho'][$i]['tenkhachhang'];
                        echo ($item['nhapkho'][$i]['dienthoai'] != '') ?' - '.$item['nhapkho'][$i]['dienthoai']:'';
                        echo ($item['nhapkho'][$i]['diachi'] != '') ?' - '.$item['nhapkho'][$i]['diachi']:'';
                    }
                    if($item['nhapkho'][$i]['shopid'])
                    {
                        echo @$this->document->getShop($item['nhapkho'][$i]['shopid']);
                    }
                    if($item['nhapkho'][$i]['nhacungcapid'])
                    {
                        echo $item['nhapkho'][$i]['tennhacungcap'];
                    }
                ?>
            </td>
            <td><?php echo @$item['nhapkho'][$i]['soluong']?></td>
            <td><?php echo @$this->document->getDonViTinh($item['nhapkho'][$i]['madonvi'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhapkho'][$i]['giatien'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhapkho'][$i]['phantramgiamgia'])?>%</td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhapkho'][$i]['thanhtien'])?></td>
            <td><a onclick="objdl.viewPX(<?php echo @$item['xuatkho'][$i]['phieuid']?>,'')"><?php echo @$item['xuatkho'][$i]['maphieu']?></a></td>
            <td>
            	<?php echo @$this->document->getCategory($item['xuatkho'][$i]['loaiphieu'])?>:
                <?php if(@$item['xuatkho'][$i]['tenkhachhang'])
                    {
                        echo $item['xuatkho'][$i]['tenkhachhang'];
                        echo ($item['xuatkho'][$i]['dienthoai'] != '') ?' - '.$item['xuatkho'][$i]['dienthoai']:'';
                        echo ($item['xuatkho'][$i]['diachi'] != '') ?' - '.$item['xuatkho'][$i]['diachi']:'';
                    }
                    if($item['xuatkho'][$i]['shopid'])
                    {
                        echo @$this->document->getShop($item['xuatkho'][$i]['shopid']);
                    }
                    if($item['xuatkho'][$i]['nhacungcapid'])
                    {
                        echo $item['xuatkho'][$i]['tennhacungcap'];
                    }
                ?>
            </td>
            <td><?php echo @$item['xuatkho'][$i]['soluong']?></td>
            <td><?php echo @$this->document->getDonViTinh($item['xuatkho'][$i]['madonvi'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuatkho'][$i]['giatien'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuatkho'][$i]['phantramgiamgia'])?>%</td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuatkho'][$i]['thanhtien'])?></td>
        </tr>
            <?php } ?>
        <?php } ?>
    </tbody>
    <?php } ?>
</table>