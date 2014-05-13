<?php echo $path?>
<div class="clearer">^&nbsp;</div>
<?php if(count($folderchild)){ ?>
	<?php foreach($folderchild as $folder){ ?>
    <div class="left folderlist" folderpath="<?php echo $folder['foldername']?>" title="<?php echo $folder['foldername']?>">
    	<table>
        	<tr>
            	<td><?php echo $folder['foldername']?></td>
            </tr>
        </table>
    	
    </div>
    <?php }?>





<?php } ?>
<?php 
	if(count($files))
   		foreach($files as $file){ ?>
	<div class="left">
    <div class="filelist  text-center" id="<?php echo $file['fileid']?>" imagethumbnail="<?php echo $file['imagethumbnail']?>" filename="<?php echo $file['filename']?>" filepath="<?php echo $file['filepath']?>" style="background:url('<?php echo $file['imagethumbnail']?>') no-repeat center center" title="<?php echo $file['filename']?>">
        
		<p class="filename"><?php echo substr($file['filename'],0,20)?></p>
            
        
        
    </div>
	
</div>
<?php } ?>

<div class="clearer">^&nbsp;</div>


<script language="javascript">

</script>