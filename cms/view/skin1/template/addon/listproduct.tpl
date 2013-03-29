<?php foreach($medias as $media){ ?>
<div class="product-item left">
	
   
    <div class="product-price">
    	<table>
        	<tr>
            	<th>Sản phẩm</th>
                <th>Giá</th>
                <th>Khuyến mãi</th>
            </tr>
            <?php if($media['price']){ ?>
            <tr class="price-item" ref="<?php echo $media['mediaid']?>" image="<?php echo $media['imagepreview']?>" title="<?php echo $media['title']?>" price="<?php echo $media['price']?>" pricepromotion="<?php echo $media['pricepromotion']?>">
            	<td>
            		<?php echo $media['title']?>
            	</td>
                <td class="number">
            		<?php echo $this->string->numberFormate($media['price'])?>
            	</td>
                <td class="number">
            		<?php echo $this->string->numberFormate($media['pricepromotion'])?>
            	</td>
            </tr>
            <?php } ?>
        	<?php foreach($media['productprice'] as $item){ ?>
            <tr class="price-item" ref="<?php echo $item['mediaid']?>" image="<?php echo $media['imagepreview']?>" title="<?php echo $media['title']?> <?php echo $item['title']?>" price="<?php echo $item['gia']?>" pricepromotion="<?php echo $item['khuyenmai']?>">
            	<td>
            		<?php echo $media['title']?> <?php echo $item['title']?>
            	</td>
                <td class="number">
            		<?php echo $this->string->numberFormate($item['gia'])?>
            	</td>
                <td class="number">
            		<?php echo $this->string->numberFormate($item['khuyenmai'])?>
            	</td>
            </tr>
            <?php } ?>
        </table>
    	
    </div>
    
    <input type="hidden" class="listid" value="<?php echo $media['mediaid']?>">
	<table>
    	<tr>
        	<td width="100px" height="100px" align="center">
            	<img src="<?php echo $media['imagepreview']?>">
            </td>
        </tr>
        <tr>
        	<td align="center">
            	<?php echo $media['title']?><br>
                
            </td>
        </tr>
    </table>
	
</div>
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
	if($(this).attr('pricepromotion') == 0)
		obj.price = $(this).attr('price');
	else
		obj.price = $(this).attr('pricepromotion');
	
	var html = '<div><input type="button" class="button removeselect" value="X"><br><input type="hidden" class="listid" value="'+obj.mediaid+'" image="'+ obj.imagepath +'" title="'+ obj.title +'">';
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