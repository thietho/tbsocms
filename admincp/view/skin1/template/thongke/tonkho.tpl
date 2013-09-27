<div class="section">

	<div class="section-title"><?php echo $this->document->title?></div>
    
    <div class="section-content">
    	<h3>Số lượng sản phẩm đang tồn kho tính đến ngày <?php echo $this->date->formatMySQLDate($this->date->getTodayNoTime())?></h3>
		<table class="data-table">
            
            <tr>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
                <th>Màu</th>
                <th>Tồn kho</th>
                
            </tr>
            <?php $sum = 0;?>
            <?php foreach($medias as $media){ ?>
            	<?php if((int)$media['tonkho']){ ?>
                <?php $sum += (int)$media['tonkho'];?>
			<tr>
            	<td><?php echo $media['code']?></td>
                <td><?php echo $media['title']?></td>
                <td><?php echo $media['color']?></td>
                <td><?php echo $media['tonkho']?></td>
            </tr>
            	<?php } ?>
            <?php } ?>
            <tr>
            	<td></td>
                <td></td>
                <td>Tổng tồn</td>
                <td><?php echo $this->string->numberFormate($sum)?></td>
            </tr>
        </table>    	
        
        
    </div>
    
</div>
