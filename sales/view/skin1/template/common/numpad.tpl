<table>
	<tr>
    	<td colspan="3"><div id="numpadtext">0</div></td>
    </tr>
    <tr>
    	<td><input type="button" class="button numpad" value="1"></td>
        <td><input type="button" class="button numpad" value="2"></td>
        <td><input type="button" class="button numpad" value="3"></td>
    </tr>
    <tr>
    	<td><input type="button" class="button numpad" value="4"></td>
        <td><input type="button" class="button numpad" value="5"></td>
        <td><input type="button" class="button numpad" value="6"></td>
    </tr>
    <tr>
    	<td><input type="button" class="button numpad" value="7"></td>
        <td><input type="button" class="button numpad" value="8"></td>
        <td><input type="button" class="button numpad" value="9"></td>
    </tr>
    <tr>
    	<td><input type="button" class="button numpad" value="0"></td>
        <td><input type="button" class="button numpad" value="."></td>
        <td><input type="button" class="button numpad" id="btnBackSpace" value="&larr;"></td>
    </tr>
</table>
<script language="javascript">
$('.numpad').click(function(e) {
	if(this.id=="btnBackSpace")
	{
		$('#numpadtext').html($('#numpadtext').html().substr(0,$('#numpadtext').html().length-1));
	}
	else
	{
		if($('#numpadtext').html()=="0")
			$('#numpadtext').html('');
		var chr = this.value;
		$('#numpadtext').html($('#numpadtext').html()+chr);
	}
	if($('#numpadtext').html()=="")
		$('#numpadtext').html("0");
});
</script>