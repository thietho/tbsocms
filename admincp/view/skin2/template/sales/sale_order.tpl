<div id="chbhsearch">
    <label>Mã phiếu</label>
    <input type="text" id="maphieu" name="maphieu" class="text" value="" />
    
    <label>Khách hàng</label>
    <input type="text" id="tenkhachhang" name="tenkhachhang" class="text" value="" />
    <label>Số điện thoại</label>
    <input type="text" id="dienthoai" name="dienthoai" class="text" value="" />
    <label>Địa chỉ</label>
    <input type="text" id="diachi" name="diachi" class="text" value="" />
    <br>
    <label>Từ ngày</label>
    <input type="text" class="text date" id="tungay" />
    <script language="javascript">
        $(function() {
            $("#tungay").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd-mm-yy'
                    });
            });
     </script>
    <label>Đến ngày</label>
    <input type="text" class="text date" id="denngay" />
    <script language="javascript">
        $(function() {
            $("#denngay").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: 'dd-mm-yy'
                    });
            });
     </script>
    
    <br />
</div>
<div id="listordercomlete"></div>
<script language="javascript">
$(document).ready(function(e) {
	saleOrder.listOrderCompleteData('');
});
function createParam()
{
	var url =  "";
	if($("#chbhsearch #maphieu").val() != "")
		url += "&maphieu=" + $("#chbhsearch #maphieu").val();
	
	if($("#chbhsearch #tenkhachhang").val() != "")
		url += "&tenkhachhang="+ encodeURI($("#chbhsearch #tenkhachhang").val());
	if($("#chbhsearch #dienthoai").val() != "")
		url += "&dienthoai="+ encodeURI($("#chbhsearch #dienthoai").val());
	if($("#chbhsearch #diachi").val() != "")
		url += "&diachi="+ encodeURI($("#chbhsearch #diachi").val());
	
	if($("#chbhsearch #tungay").val() != "")
		url += "&tungay="+ encodeURI($("#chbhsearch #tungay").val());
	if($("#chbhsearch #denngay").val() != "")
		url += "&denngay="+ encodeURI($("#chbhsearch #denngay").val());
	
	return url;
}
$('#chbhsearch .text').keyup(function(e) {
    saleOrder.listOrderCompleteData(createParam());
});

$('#chbhsearch .date').change(function(e) {
    saleOrder.listOrderCompleteData(createParam());
});
</script>
