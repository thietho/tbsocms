<h3>
	Tính hoa hồng 
    <?php if(@$post[tungay]){ ?>
    từ ngày <?php echo @$post[tungay]?>
    <?php } ?>
    đến ngày <?php echo @$post['denngay']?>
</h3>

<table id="reportbanhang" class="data-table">
	<thead>
        <tr>
        	
        	<th>Mã phiếu</th>
            <th>Ngày</th>
            <th>Sản phẩm</th>
            
            <th>Số lượng</th>
            <th>Giá</th>
            <th>Giảm giá(%)</th>
            <th>Giảm giá</th>
            <th>Thành tiền</th>
            <th>Hoa hồng</th>
        </tr>
    </thead>
    <tbody>
    	<?php $sum = 0;?>
        <?php $sumcommissions = 0;?>
        
        
    	<?php foreach($data_banhang as $memberid => $banhang){ ?>
        	
        <tr>
        	<td colspan="7"><strong><?php echo @$this->document->getCustomer($memberid)?> <?php echo @$this->document->getCustomer($memberid,'phone')?> <?php echo @$this->document->getCustomer($memberid,'address')?></strong></td>
            <?php $su = 0;?>
            <?php $sucom = 0;?>
            <?php foreach($banhang as $item) { ?>
            <?php $su += $item['thanhtien']?>
            <?php
                $comm =0;
                if($item['phantramgiamgia']>0) 
                    $comm = $item['thanhtien'] * $commission->fullsize /100;
                else
                    $comm = $item['thanhtien'] * $commission->minisize /100;
            ?>
            <?php $sucom += $comm?>
            <?php } ?>
            
            <td class="number"><strong><?php echo @$this->string->numberFormate($su)?></strong></td>
            <td class="number"><strong><?php echo @$this->string->numberFormate($sucom)?></strong></td>
        </tr>
        	<?php foreach($banhang as $item) { ?>
        	<?php $sum += $item['thanhtien']?>
            
        <tr>
        	
        	<td><a onclick="objdl.viewPX(<?php echo @$item['phieuid']?>,'')"><?php echo @$item['maphieu']?></a></td>
            <td><?php echo @$this->date->formatMySQLDate($item['ngaylap'])?></td>
            <td><?php echo @$item['title']?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['soluong'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['giatien'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['phantramgiamgia'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['giamgia'])?></td>
            <td class="number"><?php echo @$this->string->numberFormate($item['thanhtien'])?></td>
            <td class="number">
            	<?php
                	$comm =0;
                	if($item['phantramgiamgia']>0) 
                		$comm = $item['thanhtien'] * $commission->fullsize /100;
                    else
                    	$comm = $item['thanhtien'] * $commission->minisize /100;
                ?>
                <?php $sumcommissions += $comm ?>
            	<?php echo @$this->string->numberFormate($comm)?>
            </td>
        </tr>
        	<?php } ?>
        <?php } ?>
        <tr>
            <td class="number" colspan="7">Tổng cộng</td>
            <td class="number"><?php echo @$this->string->numberFormate($sum)?></td>
            <td class="number"><?php echo @$this->string->numberFormate($sumcommissions)?></td>
        </tr>
       
        <!--<tr>
            <td class="number" colspan="4">Công nợ hiện tại</td>
            <td class="number"><?php echo @$this->string->numberFormate($congno)?></td>
        </tr>
        <tr>
            <td class="number" colspan="4">Thanh toán hoa hồng</td>
            <td class="number"><?php echo @$this->string->numberFormate($congno - $sumcommissions)?></td>
        </tr>-->
    </tbody>
</table>