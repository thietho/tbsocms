<div class="ben-post">
    <h3><?php echo $title?></h3>
    <?php if(count($medias)){ ?>
    <?php foreach($medias as $media) {?>
    <div>
        
        <a href='<?php echo $media['link']?>'><img width="140px" height="140px" src="<?php echo $media['imagethumbnail']?>" class='ben-left' /></a>
        
        <a href="<?php echo $media['link']?>"><h3><?php echo $media['title']?></h3></a>
        
        <div class="ben-post-body">
            <p><?php echo $media['summary']?></p>
        </div>
        <div class="clearer">&nbsp;</div>
    </div>
    <?php } ?>
    </div>
<div class="ben-post">
    <?php echo $pager?>
</div>
<?php } else{ ?>
Không có kết quả
<?php }?>