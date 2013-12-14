<div class="section">

	<div class="section-title">
    	<?php echo $breadcrumb?>
    </div>
    
    <div class="section-content padding1">
    
    	<form name="InsertContent"  action="" method="post" enctype="multipart/form-data">
    
    	<div class="left">
            
            <h3><?php echo $heading_title?></h3>
        
        </div>
        
    	<div class="right">
        	<input class="button" type="submit" value="<?php echo $button_save ?>" />
            <a class="button" href="<?php echo $DIR_CANCEL?>"><?php echo $button_cancel?></a>
             <input type="hidden" id="status" name="status" value="<?php echo $post['status']?>" />
             <input type="hidden" id="mediaid" name="mediaid" value="<?php echo $post['mediaid']?>" />
             <input type="hidden" id="mediatype" name="mediatype" value="<?php echo $post['mediatype']?>" />
             <input type="hidden" id="refersitemap" name="refersitemap" value="<?php echo $post['refersitemap']?>" />
        </div>
        <div class="clearer">&nbsp;</div>
        
        
        <div id="container">
        	
            
        	<ul>
                <li><a href="#fragment-content"><span>Information</span></a></li>
               
                <li><a href="#fragment-detail"><span>Detail</span></a></li>
               
                
            </ul>
           
            
            <div id="fragment-content">
            	
                <div style="<?php echo $displaynews?>">
        			
                    <div class="col2 left">
                    	
                       
                        <p>
                            <label>Title</label><br>
                            <input class="text" type="text" name="title" value="<?php echo $post['title']?>" size="60" />
                        </p>
                        
                        
                        
                        <p>
                            <label>Summary</label><br>
                            <textarea class="text" rows="3" cols="70" name="summary"><?php echo $post['summary']?></textarea>
                        </p>
                        
                    	
                    </div>
                    
                    <div class="col2 right">
                    	
                    	<p id="pnImage">
                            <label for="image"><?php echo $entry_image?></label><br />
                            <a  class="button" onclick="browserFileImage()">Chọn hình</a><br />
                            <img id="imagepreview" src="<?php echo $imagethumbnail?>" onclick="showFile($('#imageid').val())"/>
                            <input type="hidden" id="imagepath" name="imagepath" value="<?php echo $post['imagepath']?>" />
                            <input type="hidden" id="imageid" name="imageid" value="<?php echo $post['imageid']?>" />
                            <input type="hidden" id="imagethumbnail" name="imagethumbnail" value="<?php echo $post['imagethumbnail']?>" />
                        </p>
                        
                        
                        <div id="errorupload" class="error" style="display:none"></div>
                        
                        <div class="loadingimage" style="display:none"></div>
                       	
                        <p>
                        	<a id="btnAddAttachment" class="button" onclick="browserFileAttachment()">Chọn hình phụ</a><br />
                        </p>
                        <p id="attachment">
                        </p>
                    	
                        <span id="delfile"></span>
                        
                    </div>
                   
<script language="javascript">
	$(document).ready(function() {
   	// put all your jQuery goodness in here.
<?php
	if(count($attachment))
		foreach($attachment as $item)
		{
			if(count($item))
			{
?>
			$('#attachment').append(creatAttachmentRow("<?php echo $item['fileid']?>","<?php echo $item['filename']?>","<?php echo $item['imagethumbnail']?>"));
<?php
			}
		}
?>
 	});

</script>
                    <div class="clearer">&nbsp;</div>
                
                </div>
                
               
                
            </div>
            
            <div id="fragment-detail">
            	<a class="button" onclick="browserFileEditor()">Select image</a>
                <input type="hidden" id="listselectfile" name="listselectfile" />
            	<div>
                	<p>
                        <textarea name="description" id="editor1" cols="80" rows="10"><?php echo $description?></textarea>
                    </p>
                </div>
            </div>
            
            
            
            
            
            
        
        </div>
        
        </form>
    
    </div>

</div>
<div id="popup" class="hidden"></div>


<script type="text/javascript" charset="utf-8">

$(document).ready(function() { 
	setCKEditorType('editor1',0);
	
	$('#container').tabs({ fxSlide: true, fxFade: true, fxSpeed: 'slow' });
	
});
</script>
<script language="javascript">
function browserFileImage()
{
    
	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=single",function(){
			$("#popup").dialog("open");	
		});
		
}
function intSeleteFile(type)
{
	
	switch(type)
	{
		case "single":
			$('.filelist').click(function(e) {
				$('#imagepreview').attr('src',$(this).attr('imagethumbnail'));
				$('#imageid').val(this.id);
				$('#imagepath').val($(this).attr('filepath'));
				$('#imagethumbnail').val($(this).attr('imagethumbnail'));
				$("#popup").dialog( "close" );
			});			
			break;
			
		case "editor":
			$('.filelist').click(function(e) {

				
				width = "";
							
				var value = "<img src='<?php echo HTTP_IMAGE?>"+$(this).attr('filepath')+"'/>";
				
				var oEditor = CKEDITOR.instances['editor1'] ;
				
				
				// Check the active editing mode.
				if (oEditor.mode == 'wysiwyg' )
				{
					// Insert the desired HTML.
					oEditor.insertHtml( value ) ;
					
					var temp = oEditor.getData()
					oEditor.setData( temp );
				}
				else
					alert( 'You must be on WYSIWYG mode!' ) ;
				$("#popup").dialog( "close" );
			});			
			break;
		case "multi":
			$('.filelist').click(function(e) {
                //$('#popup-seletetion').append($(this))
            });
			break;
	}
}
function browserFileAttachment()
{

	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: $(document).width()-100,
			height: 600,
			modal: true,
			buttons: {
				
				
				
				/*'Xem danh sach':function()
				{
					$( "#popup-selete" ).show('fast',function(){
						$( "#popup-selete" ).position({
							my: "center",
							at: "center",
							of: "#popup"
						});
						$( "#popup-selete" ).draggable();
					});
					$('.closeselect').click(function(e) {
                        $( "#popup-selete" ).hide('fast');
                    });
				},*/
				'Chọn': function() 
				{
					$('.selectfile').each(function(index, element) {
                        $.getJSON("?route=core/file/getFile&fileid="+this.id+"&width=50", 
							function(file) 
							{
								
								$('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
								
							});
						
                    });
					$('#popup-seletetion').html("");
					$( this ).dialog( "close" );
				},
			}
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=multi",function(){
			$("#popup").dialog("open");	
		});
}
function browserFile()
{
    //var re = openDialog("?route=core/file&dialog=true",800,500);
	$('#handler').val('file');
	$('#outputtype').val('file');
	showPopup("#popup", 800, 500);
	$("#popup").html("<img src='view/skin1/image/loadingimage.gif' />");
	$("#popup").load("?route=core/file&dialog=true")
		
}

function browserFileEditor()
{

	
	$("#popup").attr('title','Chọn hình');
		$( "#popup" ).dialog({
			autoOpen: false,
			show: "blind",
			hide: "explode",
			width: 800,
			height: 600,
			modal: true,
			
		});
	
		
		$("#popup-content").load("?route=core/file&dialog=true&type=editor",function(){
			$("#popup").dialog("open");	
		});
}


function Attachment()
{
	this.index = 0;
	this.removeAttachmentRow = function(index)
	{
		$("#delfile").append('<input type="hidden" id="attimageid'+attachment.index+'" name="delfile['+index+']" value="'+$("#attimageid"+index).val()+'" />');
		$("#attrows"+index).html("")
	}
	this.creatAttachmentRow = function(iid,path,thums)
	{
		
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+path+' <a id="removerow'+attachment.index+'" onclick="attachment.removeAttachmentRow('+attachment.index+')" class="button" >Remove</a></div>';
		attachment.index++;
		return row;	
	}
	this.creatAttachmentRowView = function(iid,name,path,thums)
	{
		row = '<div id="attrows'+attachment.index+'"><img src="'+thums+'" /><input type="hidden" id="attimageid'+attachment.index+'" name="attimageid['+attachment.index+']" value="'+iid+'" />'+'<a href="'+path+'" target="_blank">'+name+'</a>';
		attachment.index++;
		return row;
	}

}
var attachment = new Attachment();
</script>



