<div id="productseach">
	<p>
		<label>Từ khóa</label>
        <input type="text" class="text" id="keyword" name="keyword"/>
    </p>
</div>
<div class="clearer">^&nbsp;</div>
<div id="productlist" class="left">
	
</div>
<div id="productselect" class="right">
	
</div>
<div class="clearer">^&nbsp;</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#productlist').load("?route=addon/order/listProduct");
});
$('#keyword').keyup(function(e) {
	
	var url ="?route=addon/order/listProduct&keyword="+ encodeURIComponent( this.value);
    $('#productlist').load(url);
});
</script>