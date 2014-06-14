<center>
    <h2>Báo giá</h2>
</center>
<table>
	<tr>
        <td align="right">
        	<p>
            	Ngày <?php echo $this->date->getDay($item['ngaybaogia'])?> tháng <?php echo $this->date->getMonth($item['ngaybaogia'])?> năm <?php echo $this->date->getYear($item['ngaybaogia'])?>
            </p>
            
        </td>
    </tr>
    <?php if($item['ghichu']!=""){ ?>
    <tr>
    	<td>
            <div class="cusinfo">
                <?php echo $item['ghichu']?>
            </div>
        </td>
	</tr>
    <?php } ?>
</table>
<table class="data-table">
	<thead>
        <tr>
            <th>STT</th>
            <th>Sản phẩm</th>
			<th>Nhãn hiệu</th>            
            <th>SL</th>
            <th>Giá</th>
            <th>Hình</th>
        </tr>
    </thead>
    <tbody>
    <?php foreach($sitemaps as $sitemap => $medias){ ?>
    	<?php if(count($medias)){ ?>
    	<tr>
        	<td colspan="6"><strong><?php echo $this->document->getSiteMap($sitemap,SITEID)?></strong></td>
        </tr>
        <?php foreach($medias as $media){?>
        <tr>
        	<td></td>
            <td><?php echo $this->document->productName($media)?></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <?php }?>
        <?php } ?>
    <?php } ?>
    </tbody>
</table>