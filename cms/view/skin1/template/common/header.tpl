<script type="text/javascript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='index.php?lang="+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
<div id="top">

    <div class="left text-center" id="weblogo">
        <a href="http://ben-solution.com/">		
			<?php echo $imagepreview ?>
		</a>  
    </div>

    <div class="left">
        
        <?php if($sitename) {?>
        <p><?php echo $title_system ?></p>
        <h2><?php echo $sitename?></h2>
        <?php } else { ?>
        <h2><?php echo $title_system ?></h2>
        <?php } ?>

        <div class="clearer">&nbsp;</div>

    </div>
    
    <div class="right text-center" id="logo">
        <a href="http://ben-solution.com/">
            <img class="png" src="<?php echo DIR_IMAGE?>logo.png"/><br />
        </a>  
    </div>
    
    <div class="right">
    <?php if($username != "") { ?>
    	<?php echo $logged_user ?>: <b><?php echo $username?></b><br />
	<?php } ?>	
    </div>

    <div class="clearer">&nbsp;</div>

</div>