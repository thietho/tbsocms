<?php foreach($medias as $media){ ?>
<div class="product-item left price-item" ref="<?php echo $media['mediaid']?>" image="<?php echo $media['imagepreview']?>" code="<?php echo $media['code']?>" unit="<?php echo $media['unit']?>" title="<?php echo $media['title']?>" price="<?php echo $media['price']?>" pricepromotion="<?php echo $media['pricepromotion']?>">
    <input type="hidden" class="listid" value="<?php echo $media['mediaid']?>">
	<table>
    	<tr>
        	<td width="100px" height="100px" align="center">
            	<img src="<?php echo $media['imagepreview']?>">
            </td>
        </tr>
        <tr>
        	<td align="center">
            	<?php echo $this->string->getTextLength($media['title'],0,5)?>...<br>
                Giá: <?php echo $this->string->numberFormate($media['price'])?><br />
                Giá khuyến mãi: <?php echo $this->string->numberFormate($media['pricepromotion'])?>
            </td>
        </tr>
    </table>
</div>
<?php if(count($media['child'])){ ?>
<?php foreach($media['child'] as $item){ ?>
<div class="product-item left price-item" ref="<?php echo $item['mediaid']?>" image="<?php echo $item['imagepreview']?>" code="<?php echo $item['code']?>" unit="<?php echo $item['unit']?>" title="<?php echo $item['title']?>" price="<?php echo $item['price']?>" pricepromotion="<?php echo $item['pricepromotion']?>">
    <input type="hidden" class="listid" value="<?php echo $item['mediaid']?>">
	<table>
    	<tr>
        	<td width="100px" height="100px" align="center">
            	<img src="<?php echo $item['imagepreview']?>">
            </td>
        </tr>
        <tr>
        	<td align="center">
            	<?php echo $item['title']?><br>
                Giá: <?php echo $this->string->numberFormate($item['price'])?><br />
                Giá khuyến mãi: <?php echo $this->string->numberFormate($item['pricepromotion'])?>
            </td>
        </tr>
    </table>
</div>
<?php } ?>
<?php } ?>
<?php } ?>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
/*$('.product-item').click(function(e) {
    var html = "<div><input type='button' class='button removeselect' value='X'>"+$(this).html()+"</div>";
	$('#productselect').append(html);
	
	$('.removeselect').click(function(e) {
		$(this).parent().remove();
	});
});*/
$('.price-item').click(function(e) {
	var obj = new Object();
    obj.mediaid = $(this).attr('ref');
	obj.imagepath = $(this).attr('image');
	obj.title = $(this).attr('title');
	obj.code = $(this).attr('code');
	obj.unit = $(this).attr('unit');
	if($(this).attr('pricepromotion') == 0)
		obj.price = $(this).attr('price');
	else
		obj.price = $(this).attr('pricepromotion');
	
	var html = '<div><input type="button" class="button removeselect" value="X"><br><input type="hidden" class="listid" value="'+obj.mediaid+'" image="'+ obj.imagepath +'" code="'+ obj.code +'" unit="'+ obj.unit +'" title="'+ obj.title +'" price="'+obj.price+'">';
	html+='<img src="'+ obj.imagepath +'"><br>'
	html+= obj.title+'<br>'+ formateNumber(obj.price) +'</div>';
	$('#productselect').append(html);
	$('.removeselect').click(function(e) {
		$(this).parent().remove();
	});
	
});
$('.product-item').hover(
	function()
	{
		$(this).children('div').show();
		
	},function()
	{
		$(this).children('div').hide();
	});
</script>