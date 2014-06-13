<div>
	<p>
        <label>Ngày</label>
        <input type="date" class="text" id="ngaybaogia" name="ngaybaogia" value=""/>
    </p>
    <p>
        <label>Ghi chú</label><br>
        <textarea id="ghichu" name="ghichu"></textarea>
    </p>
</div>
<div>
	<table class="data-table">
    	<thead>
            <tr>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Ghi chú</th>
            </tr>
       	</thead>
        <tbody id="baogialistproduc">
        </tbody>
    </table>
</div>
<script language="javascript">
function BaoGia()
{
	this.index = 0;
	this.newRow = function(obj)
	{
		var row = '<tr>';
		row += '<td>'+ obj.productname +'</td>';
		row += '<td></td>';
		row += '<td></td>';
		row += '</tr>';
		return row;
	}
}
var bg = new BaoGia();
</script>
<?php foreach($medias as $media){ ?>
<script language="javascript">
	var obj = new Object();
	obj.productname = "<?php echo $this->document->productName($media)?>";
	$('#baogialistproduc').append(bg.newRow(obj));
</script>
<?php } ?>