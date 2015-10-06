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
    		<?php $max = max(count($item['nhap']),count($item['xuat']))?>
        	<?php for($i=0;$i < $max;$i++){ ?>
        <tr class="item">
        	<td><a onclick="objdl.viewPX(<?php echo @$item['nhap'][$i]['phieuid']?>,'')"><?php echo @$item['nhap'][$i]['maphieu']?></a></td>
            <td>
            	<?php echo @$this->document->getCategory($item['nhap'][$i]['loaiphieu'])?>:
                <?php if(@$item['nhap'][$i]['tenkhachhang'])
                    {
                        echo $item['nhap'][$i]['tenkhachhang'];
                        echo ($item['nhap'][$i]['dienthoai'] != '') ?' - '.$item['nhap'][$i]['dienthoai']:'';
                        echo ($item['nhap'][$i]['diachi'] != '') ?' - '.$item['nhap'][$i]['diachi']:'';
                    }
                    if($item['nhap'][$i]['shopid'])
                    {
                        echo @$this->document->getShop($item['nhap'][$i]['shopid']);
                    }
                    if($item['nhap'][$i]['nhacungcapid'])
                    {
                        echo $item['nhap'][$i]['tennhacungcap'];
                    }
                ?>
            </td>
            <td><?php echo @$item['nhap'][$i]['soluong']?></td>
            <td><?php echo @$this->document->getDonViTinh($item['nhap'][$i]['madonvi'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhap'][$i]['giatien'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhap'][$i]['phantramgiamgia'])?>%</td>
            <td class="number"><?php echo @$this->string->numberFormate($item['nhap'][$i]['thanhtien'])?></td>
            <td><a onclick="objdl.viewPX(<?php echo @$item['xuat'][$i]['phieuid']?>,'')"><?php echo @$item['xuat'][$i]['maphieu']?></a></td>
            <td>
            	
            	<?php if(@$item['xuat'][$i]['shopid'])
                    {
                        echo @$this->document->getShop($item['xuat'][$i]['shopid'])." ";
                    }
                	echo $loaiphieu[$item['xuat'][$i]['loaiphieu']];
                ?>
                <?php if(@$item['xuat'][$i]['tenkhachhang'])
                    {
                        echo $item['xuat'][$i]['tenkhachhang'];
                        echo ($item['xuat'][$i]['dienthoai'] != '') ?' - '.$item['xuat'][$i]['dienthoai']:'';
                        echo ($item['xuat'][$i]['diachi'] != '') ?' - '.$item['xuat'][$i]['diachi']:'';
                    }
                   
                    if($item['xuat'][$i]['nhacungcapid'])
                    {
                        echo $item['xuat'][$i]['tennhacungcap'];
                    }
                    if($item['xuat'][$i]['xuattu'])
                    {
                        echo ", Bán từ ".$item['xuat'][$i]['xuattu'];
                    }
                ?>
            </td>
            <td><?php echo @$item['xuat'][$i]['soluong']?></td>
            <td><?php echo @$this->document->getDonViTinh($item['xuat'][$i]['madonvi'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuat'][$i]['giatien'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuat'][$i]['phantramgiamgia'])?>%</td>
            <td class="number"><?php echo @$this->string->numberFormate($item['xuat'][$i]['thanhtien'])?></td>
        </tr>
            <?php } ?>
        <?php } ?>
    </tbody>
    <?php } ?>
</table>