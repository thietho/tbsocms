<div class="section">

	<div class="section-title"><?php echo @$this->document->title?></div>
    
    <div class="section-content">
    	<h3>Số lượng sản phẩm đang tồn kho tính đến ngày <?php echo @$this->date->formatMySQLDate(@$this->date->getTodayNoTime())?></h3>
		<table class="data-table">
            
            <tr>
                
                <th>Tên sản phẩm</th>
                
                <th>Tồn kho</th>
                <th>Giá nhập trung bình</th>
                <th>Thành tiền</th>
            </tr>
            <?php $sum = 0;?>
            <?php $sumthanhtien = 0;?>
            <?php foreach($medias as $media){ ?>
            	<?php if((int)$media['inventory']){ ?>
                <?php $sum += (int)$media['inventory'];?>
                <?php $sumthanhtien += $media['priceimport']*$media['inventory'];?>
			<tr>
            	
                <td><?php echo @$this->document->productName($media['mediaid'])?></td>
                
                <td class="number"><?php echo @$media['inventory']?></td>
                <td class="number"><?php echo @$this->string->numberFormate($media['priceimport'])?></td>
                <td class="number"><?php echo @$this->string->numberFormate($media['priceimport']*$media['inventory'])?></td>
            </tr>
            	<?php } ?>
            <?php } ?>
            <tr>
            	
                
                <td class="number">Tổng tồn kho</td>
                <td class="number"><?php echo @$this->string->numberFormate($sum)?></td>
                <td class="number">Tổng giá trị tồn</td>
                <td class="number"><?php echo @$this->string->numberFormate($sumthanhtien)?></td>
            </tr>
        </table>    	
        
        
    </div>
    
</div>
