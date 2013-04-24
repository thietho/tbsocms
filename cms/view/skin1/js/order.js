function Order()
{
	this.updateStatus = function(orderid,status)
	{
		$.ajax({
			  url: "?route=addon/order/updatestatus&orderid="+orderid+"&status="+status,
			  cache: false,
			  success: function(html){
				
			  }
			});
	}
	
	this.getOrder = function()
	{
		$.getJSON("?route=addon/order/getOrders&col=status&val=new&operator=", 
				function(data) 
				{
					$("#orderwarring").html(" ("+data.orders.length+" new)");
					//setTimeout('order.getOrder()',5000);
				});	
	}
	this.editDelivery = function(orderid)
	{
		$("#popup").attr('title','Thông tin nhận hàng');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 510,
			height: 300,
			modal: true,
			buttons: {
				
				
				'Cập nhật': function() 
				{
					$.post("?route=addon/order/saveDelivery",$('#frmDelivery').serialize(),
						function(data){
							if(data=="true")
							{
								alert('Cập nhật thông tin giao hàng thành công');
								window.location.reload();
							}
							
							
						});
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=addon/order/editDelivery&orderid="+orderid,function(){
			$("#popup").dialog("open");	
		});
	}
	this.printBill = function(orderid)
	{
		
		openDialog("?route=addon/order/printBill&orderid="+orderid,800,500)
	}
	this.confirmOder = function(orderid)
	{
		this.updateStatus(orderid,"confirmed");
		alert("Đơn hàng đã được khách hàng xác nhận");
		window.location.reload();
	}
	this.reActive = function(orderid)
	{
		this.updateStatus(orderid,"wait");
		alert("Đơn hàng đã được kích hoạt lại");
		window.location.reload();
	}
	this.cancel = function(orderid)
	{
		$.ajax({
			url: "?route=addon/order/updatestatus&orderid="+orderid+"&status=cancel",
			cache: false,
			success: function(html)
			{
				alert("Đơn hàng đã được hủy");
				window.location = "?route=addon/order";
			}
		});
	}
	this.pending = function(orderid)
	{
		
		$.ajax({
			url: "?route=addon/order/updatestatus&orderid="+orderid+"&status=pending",
			cache: false,
			success: function(html)
			{
				window.location = "?route=addon/order";
			}
		});
		
	}
	this.completed = function(orderid)
	{
		
		$.ajax({
			url: "?route=addon/order/updatestatus&orderid="+orderid+"&status=completed",
			cache: false,
			success: function(html)
			{
				alert("Đơn hàng đã hoàn tất");
				//Xuat phieu ban hang
				$.ajax({
					url: "?route=addon/order/createphieuxuat&orderid="+orderid,
					cache: false,
					success: function(html)
					{
						window.location = "?route=addon/order";
					}
				});
				
			}
		});
		
	}
	this.edit = function(orderid)
	{
		window.location = "?route=addon/order/edit&orderid="+orderid;	
	}
	this.browseProduct = function()
	{
		$("#popup").attr('title','Chọn sản phẩm');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			buttons: {
				
				
				'Chọn': function() 
				{
					$('#productselect .listid').each(function(index, element) {
                        //alert($(this).val());
						var mediaid = $(this).val();
						var imagepath = '<img src="'+$(this).attr('image')+'">';
						var title = $(this).attr('title');
						$.getJSON("?route=core/media/getMedia&col=mediaid&val="+mediaid,
							function(data)
							{
								//alert(data.medias[0].title);
								price = data.medias[0].price;
								if(data.medias[0].pricepromotion != 0)
									price = data.medias[0].pricepromotion;
								var row = order.addRow(0,data.medias[0].mediaid,title,imagepath,1,price);
								$('#listproduct').append(row);
								numberReady();
							});
                    });
					$(this).dialog("close");
				},
				
			}
		});
	
		
		$("#popup-content").load("?route=addon/order/browseProduct",function(){
			$("#popup").dialog("open");	
		});
	}
	this.index = 0;
	this.addRow = function(id,mediaid,title,image,quantity,price)
	{
		var row = "";
		row += "<td><input type='hidden' id='id-"+this.index+"' name=id["+this.index+"] value='"+id+"'><input type='hidden' name=mediaid["+this.index+"] value='"+mediaid+"'>" +title+"</td>";
		row += "<td>"+image+"</td>";
		row += "<td class='number'><input type='text' class='text number' id='quantity-"+this.index+"' name='quantity["+this.index+"]' value='"+quantity+"'></td>";
		row += "<td class='number'><input type='text' class='text number' id='price-"+this.index+"' name='price["+this.index+"]' value='"+price+"'></td>";
		
		row += "<td><input type='button' class='button' value='X' onclick='order.delRow("+this.index+")'></td>";
		var html = "<tr id='row-"+this.index+"'>"+row+"</tr>";
		this.index++;
		return html;
		
	}
	this.delRow = function(pos)
	{
		if($('#id-'+pos).val() != 0)
			$("#delid").val($("#delid").val() + $('#id-'+pos).val()+",");
		$("#row-"+pos).remove();
	}
	this.viewHistory = function(orderid)
	{
		$("#popup").attr('title','Lịch sử đơn hàng');
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
	
		
		$("#popup-content").load("?route=addon/order/viewHistory&orderid="+orderid,function(){
			$("#popup").dialog("open");	
		});
	}
}

var order = new Order();

$(document).ready(function(){
	order.getOrder();
});