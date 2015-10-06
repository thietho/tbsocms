<?php foreach($data_product as $media){ ?>
<tr>
    <td>
        <?php echo @$this->document->productName($media)?>
    </td>
    <td>
        <?php echo @$media['barcode']?><br>
        Ref: <?php echo @$media['ref']?>
    </td>
    <td><?php echo @$media['Inventory']?></td>
    <td class="number"><?php echo @$this->string->numberFormate($media['price'])?></td>
    <td class="number"><?php echo @$this->string->numberFormate($media['discountpercent'])?></td>
    <td><img src="<?php echo @$media['icon']?>"></td>
    <td>
        <input type="button" class="button selectProduct" value="Chọn" ref="<?php echo @$media['mediaid']?>" image="<?php echo @$media['imagepreview']?>" code="<?php echo @$media['code']?>" unit="<?php echo @$media['unit']?>" title="<?php echo @$this->document->productName($media)?>" price="<?php echo @$media['price']?>" pricepromotion="<?php echo @$media['pricepromotion']?>" discountpercent="<?php echo @$media['discountpercent']?>" productname="<?php echo @$this->document->productName($media)?>" brandname="<?php echo @$this->document->getCategory($media['brand'])?>"/>
        <input type="button" class="button historyProduct" value="Lịch sử" ref="<?php echo @$media['mediaid']?>" />
    </td>
</tr>
<?php } ?>