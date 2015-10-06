<h2>Các sản phẩm đang có ở shop</h2>

<div id="tabs">
  <ul>
  	<?php foreach($nhanhieu as $brand){ ?>
        <?php if(count($data_product[$brand['categoryid']])) {?>
    <li><a href="#tabs-<?php echo @$brand['categoryid']?>"><?php echo @$brand['categoryname']?></a></li>
    	<?php } ?>
    <?php } ?>
  </ul>
  <?php foreach($nhanhieu as $brand){ ?>
        <?php if(count($data_product[$brand['categoryid']])) {?>
  <div id="tabs-<?php echo @$brand['categoryid']?>">
	<table class="data-table">
    	<thead>
            <tr>
            	<th>Sản phẩm</th>
                <th>Code</th>
                <th>Số lượng tồn</th>
                <th>Giá</th>
                <th>Giảm%</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
       
        		<?php foreach($data_product[$brand['categoryid']] as $media){ ?>
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
            
        
    </table>
  </div>
  		<?php } ?>
   <?php } ?>
</div>
<div>
	
</div>
<script language="javascript">
$(document).ready(function(e) {
    $( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
    $( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
});
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
$('.historyProduct').click(function(e) {
    saleOrder.history($(this).attr('ref'));
});
</script>