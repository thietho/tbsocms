<div class="section">
    <div class="section-content">
        <div><label><?php echo $item['tennguyenlieu']?> tồn:</label> <?php echo $this->string->numberFormate($item['soluongton'],2)?>
        <?php echo $this->document->getDonViTinh($item['madonvi'])?>
        <h3>Nhập kho</h3>
        <table>
            <thead>
                <tr>
                    <th>Ngày nhập</th>
                    <th>Cung cấp bởi</th>
                    <th>Ghi chú</th>
                    <th>Số lượng</th>
                    <th>Giá nhập</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
            <?php $sumnhap = 0;?>
            <?php $sumnhapthanhtien = 0;?>
            <?php foreach($datact as $val){ ?>
            	<?php if($val['soluong']>0){ ?>
                <?php $sumnhap += $val['soluong'];?>
                <?php $sumnhapthanhtien += $val['soluong']*$val['gianhap'];?>
                <tr>
                    <td><?php echo $this->date->formatMySQLDate($val['ngaynhap'],'longdate')?></td>
                    
                    <td><?php echo $this->document->getNhaCungCap($val['nhacungcapid'])?></td>
                    <td><?php echo $val['ghichu']?></td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['soluong'],2)?>
                        <?php echo $this->document->getDonViTinh($val['donvi'])?>
                    </td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['gianhap'])?>
                        
                    </td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['gianhap']*$val['soluong'],2)?>
                        
                    </td>
                </tr>
                <?php } ?>
            <?php } ?>
            	<tr>
                	<td></td>
                    <td></td>
                    <td>Tổng</td>
                    <td class="number"><?php echo $this->string->numberFormate($sumnhap,2)?></td>
                    <td></td>
                    <td class="number"><?php echo $this->string->numberFormate($sumnhapthanhtien,2)?></td>
                </tr>
            </tbody>
            
        </table>
        <h3>Xuất kho</h3>
        <table>
            <thead>
                <tr>
                    <th>Ngày nhập</th>
                    <th>Cung cấp bởi</th>
                    <th>Ghi chú</th>
                    <th>Số lượng</th>
                    <th>Giá xuất</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
            <?php $sumxuat = 0;?>
            <?php $sumxuatthanhtien = 0;?>
            <?php foreach($datact as $val){ ?>
            	<?php if($val['soluong']<0){ ?>
                <?php $sumxuat += $val['soluong'];?>
                <?php $sumxuatthanhtien += $val['soluong']*$val['gianhap'];?>
                <tr>
                    <td><?php echo $this->date->formatMySQLDate($val['ngaynhap'],'longdate')?></td>
                    
                    <td><?php echo $this->document->getNhaCungCap($val['nhacungcapid'])?></td>
                    <td><?php echo $val['ghichu']?></td>
                    <td class="number">
                        <?php echo $this->string->numberFormate(-1*$val['soluong'],2)?>
                        <?php echo $this->document->getDonViTinh($val['donvi'])?>
                    </td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['gianhap'])?>
                        
                    </td>
                    <td class="number">
                        <?php echo $this->string->numberFormate($val['gianhap']*-1*$val['soluong'],2)?>
                        
                    </td>
                    
                </tr>
                <?php } ?>
            <?php } ?>
            	<tr>
                	<td></td>
                    <td></td>
                    <td>Tổng</td>
                    <td class="number"><?php echo $this->string->numberFormate(-1*$sumxuat,2)?></td>
                    <td></td>
                    <td class="number"><?php echo $this->string->numberFormate(-1*$sumxuatthanhtien,2)?></td>
                </tr>
            </tbody>
            
        </table>
    </div>
		
</div>

