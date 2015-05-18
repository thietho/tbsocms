<h2>Các sản phẩm đang có ở shop</h2>
<div>
	<table class="data-table">
    	<thead>
            <tr>
            	<th>Sản phẩm</th>
                <th>Số lượng tồn</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <?php foreach($nhanhieu as $brand){ ?>
        	<?php if(count($data_product[$brand['categoryid']])) {?>
        <tr>
        	<td colspan="4"><strong><?php echo $brand['categoryname']?></strong></td>
        </tr>
        		<?php foreach($data_product[$brand['categoryid']] as $media){ ?>
        <tr>
        	<td>
            	<?php echo $this->document->productName($media)?>
            </td>
            <td><?php echo $media['Inventory']?></td>
            <td><img src="<?php echo $media['icon']?>"></td>
            <td>
            	<input type="button" class="button selectProduct" value="Chọn" ref="<?php echo $media['mediaid']?>" image="<?php echo $media['imagepreview']?>" code="<?php echo $media['code']?>" unit="<?php echo $media['unit']?>" title="<?php echo $this->document->productName($media)?>" price="<?php echo $media['price']?>" pricepromotion="<?php echo $media['pricepromotion']?>" discountpercent="<?php echo $media['discountpercent']?>" productname="<?php echo $this->document->productName($media)?>" brandname="<?php echo $this->document->getCategory($media['brand'])?>"/>
            </td>
        </tr>
        		<?php } ?>
            <?php } ?>
    	<?php } ?>
        
    </table>
</div>
<script language="javascript">
$('.selectProduct').click(function(e) {
	var obj = new Object();
	obj.id = 0;
	obj.mediaid = $(this).attr('ref');
	obj.imagepath = $(this).attr('image');
	obj.title = $(this).attr('title');
	obj.code = $(this).attr('code');
	obj.unit = $(this).attr('unit');
	//console.log(obj.mediaid);
	obj.price = $(this).attr('price');
	
	obj.pricepromotion = $(this).attr('pricepromotion');
	obj.discountpercent = $(this).attr('discountpercent');
	obj.productname = $(this).attr('productname');
	obj.brandname = $(this).attr('brandname');
	
	var giagiam = 0;
	if(obj.pricepromotion > 0)
	{
		giagiam = obj.price - obj.pricepromotion;
	}
	if($('#nhapkhonguyenlieu').length)
		objdl.addRow('',obj.mediaid,obj.code,obj.title,1,obj.unit,obj.price,giagiam,obj.discountpercent);
	
	
	
});
</script>