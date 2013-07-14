
<div class="section">

	<div class="section-title">Bán hàng</div>
    
    <div class="section-content">
    	<div id="showdanhmuc" class="left sales-scr" style="width:20%">
        	
        </div>
        <div class="left sales-scr" style="width:60%">
        	
        	<div id="search">
            	<label>Từ khóa:</label>
                <input type="text" class="text" id="keyword"/>
            </div>
            
            <div class="clearer">^&nbsp;</div>
            <form id="postlist" name="postlist" method="post" action="">
        		<div id="showsanpham" class="sales-scr"></div>
            </form>
        </div>
        <div id="orderview" class="left sales-scr" style="width:20%">
        	<h3><center>Đơn hàng</center></h3>
            <input type="hidden" id="orderid" name="orderid" />
            <table>
            	<thead>
                	<tr>
                    	<th>
                        	<th>Sản phẩm</th>
                            <th>Số lượng</th>
                            <th>ĐVT</th>
                            <th>Giá bán</th>
                            <th>Thành tiền</th>
                        </th>
                    </tr>
                </thead>
                <tbody id="orderlist"></tbody>
            </table>
        </div>
        <div class="clearer">^&nbsp;</div>
    </div>
</div>
<script language="javascript">
$(document).ready(function(e) {
    $('#showdanhmuc').load('?route=page/home/productCat');
	pro.loadProduct(pro.url+"&"+strurl);
	$('#keyword').keyup(function(e) {
		pro.searchForm();
	});
	pro.fixSize();
	
});
$(window).resize(function(e) {
    pro.fixSize();
	
});
function Product()
{
	this.url = "?route=page/home/getList";
	this.loadProduct = function(url)
	{
		$('#showsanpham').html(loading);
		$('#showsanpham').load(url,function()
		{
			$('.pro-item').click(function(e) {
                
				pro.view($(this).attr('mediaid'));
            });
		});
	}
	this.searchForm = function()
	{
		url = this.url;
		if($('#keyword').val()!="")
		{
			url += "&keyword="+encodeURI($('#keyword').val());
		}
		this.loadProduct(url);
	}
	this.fixSize = function()
	{
		$('#showdanhmuc').height($('body').height() - $('#showdanhmuc').position().top);
		$('#showsanpham').height($('body').height() - $('#showsanpham').position().top);
		$('#orderview').height($('body').height() - $('#orderview').position().top);
		
	}
	this.view = function(mediaid)
	{
		$("#popup").attr('title','Giá sản phẩm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			buttons: {
				
				
				'Đóng': function() 
				{
					
					$(this).dialog("close");
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=page/home/viewProduct&mediaid="+mediaid,function(){
			$("#popup").dialog("open");
			$('.orderpro').click(function(e) {
                pro.addOrder($(this).attr('mediaid'),$(this).attr('code'),$(this).attr('title'),$(this).attr('unit'),1,$(this).attr('price'));
            });
		});	
	}
	this.addOrder = function(mediaid,code,title,unit,quantity,price)
	{
		$.post("?route=page/home/addOrder",
			{
				mediaid:mediaid,
				code:code,
				title:title,
				unit:unit,
				quantity:quantity,
				price:price
			},
			function(data)
			{
				
			});	
	}
}
var pro = new Product();

</script>