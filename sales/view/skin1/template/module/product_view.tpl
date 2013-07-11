<h2><?php echo $media['title']?></h2>
<?php if(count($media['saleprice'])){ ?>
<strong>Giá:</strong>
	<?php foreach($media['saleprice'] as $madonvi => $price){ ?>
    <p>
        <input type="button" class="button orderpro" value="<?php echo $this->string->numberFormate($price)?>/<?php echo $this->document->getDonViTinh($madonvi)?>" mediaid="<?php echo $media['mediaid']?>" price="<?php echo $price?>" madonvi="<?php echo $madonvi?>">
    </p>
	<?php } ?>
<?php }else{ ?>
Chưa cài đặt giá
<?php } ?>