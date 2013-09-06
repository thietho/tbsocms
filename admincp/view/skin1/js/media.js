function showFile(fileid)
{
	//if(!$(document).has("#fileinformation"))
	$('body').append('<div id="fileinformation" style="display:none"></div>');
	
	$("#fileinformation").attr('title','Thông tin file');
		$( "#fileinformation" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			close:function()
				{
					$('#fileinformation').remove();
				},
			buttons: {
				
				
				
				'Tải về':function()
				{
					window.location = "download.php?url="+ encodeURI($('#filepath').val());
				},
				'Đóng': function() 
				{
					
					$("#fileinformation").dialog( "close" );
					
				},
			}
		});
	
		
		$("#fileinformation").load("?route=core/file/detail&fileid="+fileid+"&dialog=true",function(){
			$("#fileinformation").dialog("open");	
		});
}
function showMediaForm(fileid)
{
	$('body').append('<div id="mediaform" style="display:none"></div>');
	
	$("#mediaform").attr('title','Thông tin file');
		$( "#mediaform" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: 600,
			modal: true,
			close:function()
				{
					$('#mediaform').remove();
				},
			buttons: {
				
				
				
				'Lưu':function()
				{
					$.post("?route=core/media/addMediaQuick",$('#frmQuickAddMedia').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							//loadData("?route=addon/order/listProduct");
							$('#frmAddSanPham').dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				},
				'Đóng': function() 
				{
					
					$("#mediaform").dialog( "close" );
					
				},
			}
		});
	
		
		$("#mediaform").load("?route=core/media/fileToMedia&fileid="+fileid+"&dialog=true",function(){
			$("#mediaform").dialog("open");	
		});
}
function showMediaUse(fileid)
{
	$('body').append('<div id="medialist" style="display:none"></div>');
	
	$("#medialist").attr('title','Thông tin file');
		$( "#medialist" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 500,
			height: 600,
			modal: true,
			close:function()
				{
					$('#medialist').remove();
				},
			buttons: {
				
				'Đóng': function() 
				{
					
					$("#medialist").dialog( "close" );
					
				},
			}
		});
	
		
		$("#medialist").load("?route=core/media/mediaUse&fileid="+fileid+"&dialog=true",function(){
			$("#medialist").dialog("open");	
		});
}
function addQuickProduct()
{
	$('body').append('<div id="frmAddSanPham" style="display:none"></div>');
	
	$("#frmAddSanPham").attr('title','Thêm nhanh sản phẩm');
	$("#frmAddSanPham").dialog({
		autoOpen: false,
		show: "blind",
		hide: "explode",
		width: 500,
		height: 500,
		modal: true,
		close:function()
				{
					$('#frmAddSanPham').remove();
				},
		buttons: {
			
			
			'Thêm': function() 
			{
				$.post("?route=core/media/addMediaQuick",$('#frmQuickAddProduct').serialize(),
					function(data)
					{
						var obj = $.parseJSON(data);
						if(obj.error=="")
						{
							loadData("?route=addon/order/listProduct");
							$('#frmAddSanPham').dialog("close");
						}
						else
						{
							alert(obj.error);
						}
					});
				
			},
			
		}
	});

	
	$("#frmAddSanPham").load("?route=addon/order/showProductForm",function(){
		$("#frmAddSanPham").dialog("open");	
	});
}
function browseProduct()
{
	$('body').append('<div id="popupbrowseproduct" style="display:none"></div>');
	$("#popup").attr('title','Chọn sản phẩm');
		$("#popupbrowseproduct").dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 500,
			modal: true,
			close:function()
				{
					$('#popupbrowseproduct').remove();
				},
			
		});
	
		
		$("#popupbrowseproduct").load("?route=addon/order/browseProduct",function(){
			$("#popupbrowseproduct").dialog("open");
			

		});
}
