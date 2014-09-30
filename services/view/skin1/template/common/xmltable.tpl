<data>
<?php foreach($data as $item){?>
    <row>
        <?php foreach($item as $col => $val){?>
        <<?php echo $col?>><?php echo $val?></<?php echo $col?>>
        <?php }?>
    </row>
<?php } ?>
</data>