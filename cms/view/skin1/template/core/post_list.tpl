<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<div class="left">
            <h3><?php echo $heading_title?></h3>
        </div>
        
    	<div class="right">
        	<?php if($permissionAdd){?>
        	<a class="button" href="<?php echo $DIR_ADD.'&page='.$page?>"><?php echo $button_add?></a>&nbsp;
            <?php }?>
            <?php if($permissionEdit){?>
        	<a class="button" onclick="updatePosition()"><?php echo $button_updateposition?></a>&nbsp;
            <?php }?>
            <?php if($permissionDelete){?>
            <a class="button" id="removelist"><?php echo $button_remove?></a>&nbsp;
            <?php }?>
            <a class="button" href="index.php"><?php echo $button_cancel?></a>
        </div>
        <div class="clearer">&nbsp;</div>
        
        <div>
        	<form id="postlist" name="postlist" method="post" action="">
            
			</form>
        </div>
        <div class="right">
        	<?php if($permissionAdd){?>
        	<a class="button" href="<?php echo $DIR_ADD.'&page='.$page?>"><?php echo $button_add?></a>&nbsp;
            <?php }?>
            <?php if($permissionEdit){?>
        	<a class="button" onclick="updatePosition()"><?php echo $button_updateposition?></a>&nbsp;
            <?php }?>
            <?php if($permissionDelete){?>
            <a class="button" id="removelist"><?php echo $button_remove?></a>&nbsp;
            <?php }?>
            <a class="button" href="index.php"><?php echo $button_cancel?></a>
        </div>
        <div>
        	<!--
        	<?php echo $nextlink?>
            <?php echo $prevlink?>
            -->
            <div class="phantrang"><?php echo $listpage ?></div>
            <div class="clearer">&nbsp;</div>
        </div>
        
       
        
    </div>

</div>

<script>
var DIR_DELETE = '<?php echo $DIR_DELETE?>';
var DIR_UPDATEPOSITION = '<?php echo $DIR_UPDATEPOSITION?>';
$(document).ready(function() { 
	$('#postlist').load("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
	$('#removelist').attr('title','Delete selected item').click(function(){deletelist();});  
	
});

function deletelist()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post(DIR_DELETE, $("#postlist").serialize(), function(data){
		$('#postlist').load("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
		$.unblockUI();
	});	
}
function updatePosition()
{
	$.blockUI({ message: "<h1><?php echo $announ_infor ?></h1>" }); 
	$.post(DIR_UPDATEPOSITION, $("#postlist").serialize(), function(data){
		$('#postlist').load("?route=core/postlist/loadData&moduleid=<?php echo $route?>&sitemapid=<?php echo $sitemap['sitemapid']?>");
		$.unblockUI();
	});	
}

</script>
