<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>


<form id="ffile" name="ffile" method="post">

<table width="100%" class="data-table">
	<tr>
        <td colspan="3">
     		<input type="hidden" name="sitemap" id="sitemap" value="" />
      		<strong>File name</strong> <input type="text" name="keyword" id="keyword" class="text" />&nbsp;&nbsp;
            
            
            			
            
            &nbsp;&nbsp;<input type="button" id="btnfilter" name="btnfilter" value="Filter" class="button"/>
            
        </td>
    </tr>
    <tr>
    	<td colspan="3">
        	<p id="pnImage">
                <label for="image">Upload file</label><br />
                <a id="btnAddImagePopup" class="button">Select file</a><br />
                
                <div id="errorupload" class="error" style="display:none"></div>
                <input type="button" class="button" id="btnDelFile" value="Delete file"/>
                
            </p>
        </td>
    </tr>
    <tr valign="top">
    	
        <td id="result" style="vertical-align:top !important">
        	Loading...
        </td>
        
    </tr>
</table>
</form>
<script>
	var imageindex = 0;
	var DIR_UPLOADPHOTO = "<?php echo $DIR_UPLOADPHOTO?>";
	var DIR_UPLOADATTACHMENT = "<?php echo $DIR_UPLOADATTACHMENT?>";
</script>
<script language="javascript">
//alert(parent.opener.document.InsertContent.title.value);
$(document).ready(function() {
  	$("#result").load("?route=core/file/getList&edit=true");
	
	$(".checkbox").click(function(index){
		//alert($(this).val());
		//alert(this.checked);
		
		temp ="";
		$(".checkbox").each(function(index){
			
			if(this.checked)
			temp += $(this).val()+",";
		})
		$("#sitemap").val(temp);
	});
});
var arrfileid = new Array();
$("#btnfilter").click(function(){
	
	url = "?route=core/file/getList&edit=true&keyword="+escape($("#keyword").val())+"&location="+$("#location").val()+"&sitemap="+$("#sitemap").val();
	$("#result").load(url);						   
})
$('#btnDelFile').click(function(e) {
    /*for(i in arrfileid)
	{
		$.get("?route=core/file/delFile&fileid="+arrfileid[i],function(){
			$("#result").load("?route=core/file/getList&edit=true");	
		});
	}*/
	/*$('.chkfile').each(function(index, element) {
        if(this.checked==true)
		{
			$.get("?route=core/file/delFile&fileid="+this.value,function(){
				$("#result").load("?route=core/file/getList&edit=true");
			});
		}
    });*/
	$.post("?route=core/file/delListFile",$('#ffile').serialize(),function(data){
		$("#result").load("?route=core/file/getList&edit=true");
	});
});

function moveto(url)
{
	$("#result").html("Loading...")
	$("#result").load(url);	
}
function removeFile(fileid)
{
	$("#rowimage"+fileid).html("");	
	//arr.splice(arr.indexOf(fileid),1,arr);
}
var arr = new Array();
function selectFile(fileid)
{
	if(arr.indexOf(fileid)==-1)
	{
		arr.push(fileid);
	
		input = '<input type="hidden" class="rows" id="seletediamge'+fileid+'" name="seletediamge'+fileid+'" value="'+fileid+'" />';
		remove = '<a class="button" onClick="removeFile('+ fileid +')">Remove</a>'
		$("#selected").append("<div id='rowimage"+fileid+"'>"+$("#image"+fileid).html()+input+"</div>"+remove+"<br/>");
	}
}

function saveSelect()
{
	//parent.opener.document.InsertContent.listselectfile.value ="";
	$("#listselectfile").val('');
	$(".rows").each(function(index){
		//parent.opener.document.InsertContent.listselectfile.value+=$(this).val()+",";
		$("#listselectfile").val($("#listselectfile").val()+$(this).val()+",")
	})
	//window.close();
	$.unblockUI();
	addImageTo();
}

function callbackUploadFile()
{
	new AjaxUpload(jQuery('#btnAddImagePopup'), {
		action: DIR_UPLOADATTACHMENT,
		name: 'image2[]',
		responseType: 'json',
		onChange: function(file, ext){
		},
		onSubmit: function(file, ext){
			$('.loadingimage').show();
			// Allow only images. You should add security check on the server-side.
			/*if (ext && /^(jpg|png|jpeg|gif)$/i.test(ext)) {                            
				$('#pnImage').hide();
				$('.loadingimage').show();
			} else {
				alert('Your selection is not image');
				return false;
			}        */                    
		},
		onComplete: function(file, response){
			//alert(response);
			
			$('#errorupload').hide();
			$("#result").load("?route=core/file/getList&edit=true");
			
				
			
			
			$('#pnImage').show();
			$('.loadingimage').hide();
			
		}
	});	

	
}
callbackUploadFile();
</script>
