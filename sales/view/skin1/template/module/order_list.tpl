
    <?php foreach($data_order as $order){ ?>
    	<input type="button" class="button btnSeleteOrder" orderid="<?php echo $order['id']?>"value="<?php echo $order['code']?>">
    <?php }?>
<script language="javascript">
$('.btnSeleteOrder').click(function(e) {
    pro.loadOrder($(this).attr('orderid'));
});
</script>
    

