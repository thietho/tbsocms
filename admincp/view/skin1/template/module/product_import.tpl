<script src='<?php echo DIR_JS?>ajaxupload.js' type='text/javascript' language='javascript'> </script>
<form id="frm_importproduct" method="post" enctype="multipart/form-data">
	
    <input type="button" class="button" id="importfile" value="Chọn file">
    
</form>
<script language="javascript">
$(document).ready(function(e) {
    new AjaxUpload(jQuery('#importfile'), {
		action: '?route=module/product/importData',
		name: 'fileimport',
		
		responseType: 'json',
		onChange: function(file, ext){
		},
		onSubmit: function(file, ext){
			if (ext && /^(xls|xlsx)$/i.test(ext)) 
			{                            
				
			}
			else 
			{
				alert('Your selection is not excel');
				return false;
			}
		},
		onComplete: function(file, response){
			
			for(i in response.files)
			{
				
				var fileid = response.files[i].imageid;
				var folderid = $('#folderidcur').val();
				$.get("?route=core/file/updateFolder&fileid="+fileid+"&folderid="+folderid,
					function(){
						 showResult("?route=core/file/getList&folderid="+folderid);
					});
				//Cap nhat vo thu muc folder:$('#folderidcur').val(),
			}
			$('#errorupload').hide();
			
           
				
            
			
			
				
			
			
			$('#pnImage').show();
			$('.loadingimage').hide();
			
		}
	});	
});
	
</script>