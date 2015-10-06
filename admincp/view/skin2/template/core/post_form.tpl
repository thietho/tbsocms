<!-- include codemirror (codemirror.css, codemirror.js, xml.js, formatting.js)-->
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/blackboard.min.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/theme/monokai.min.css">
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.min.js"></script>

<!-- include summernote -->
<link rel="stylesheet" href="<?php echo DIR_CSS?>summernote.css">
<script type="text/javascript" src="<?php echo DIR_JS?>summernote.js"></script>

<script type="text/javascript" src="<?php echo DIR_JS?>summernote-ext-hello.js"></script>
<div id="page-wrapper">
    
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
            	<?php echo @$heading_title?>
                <?php if(@$_GET['dialog']==""){ ?>
                <input type="button" value="<?php echo @$button_save ?>" class="btn btn-primary" onClick="save()"/>
     	        <input type="button" value="<?php echo @$button_cancel ?>" class="btn btn-danger" onclick="linkto('<?php echo @$DIR_CANCEL.'&page='.$_GET['page']?>')"/>   
                
                
                <?php } ?>
            </h1>
        </div>
        
        <!-- /.col-lg-12 -->
    
    	<div class="col-lg-12">
            <form name="frmPost" id="frmPost"  action="" method="post" enctype="multipart/form-data" role="form">
                 <input type="hidden" id="id" name="id" value="<?php echo @$post['id']?>" />
                 <input type="hidden" id="mediaparent" name="mediaparent" value="<?php echo @$post['mediaparent']?>" />
                 <input type="hidden" id="mediatype" name="mediatype" value="<?php echo @$post['mediatype']?>" />
                 <input type="hidden" id="refersitemap" name="refersitemap" value="<?php echo @$post['refersitemap']?>" />
                 
            
            
                 <div class="tabs">
                  <ul class="nav nav-tabs">
                    <li class="active"><a data-toggle="tab" href="#fragment-content"><?php echo @$tab_editcontent?></a></li>
                    <?php if(@$hasProperties) {?>
                    <li><a data-toggle="tab" href="#fragment-properties"><?php echo @$lbl_property ?></a></li>
                    <?php } ?>
                    <?php if(@$hasDetail){ ?>
                    <li><a data-toggle="tab" href="#fragment-detail"><?php echo @$lbl_detail ?></a></li>
                    <?php } ?>
                    <?php if(@$hasVideo) {?>
                    <li><a data-toggle="tab" href="#fragment-video">Video</a></li>
                    <?php } ?>
                    <?php if(@$hasAudio) {?>
                    <li><a data-toggle="tab" href="#fragment-audio">Audio</a></li>
                    <?php } ?>
                    <?php if(@$hasSubInfor) {?>
                    <li><a data-toggle="tab" href="#fragment-subinfor"><?php echo @$lbl_infor ?></a></li>
                    <?php } ?>
                    <?php if(@$hasTabImages){ ?>
                    <li><a data-toggle="tab" href="#fragment-images"><?php echo @$lbl_image ?></a></li>
                    <?php } ?>
                    <?php if(@$hasTabVideos){ ?>
                    <li><a data-toggle="tab" href="#fragment-videos"><span>Videos</span></a></li>
                    <?php } ?>
                    <?php if(@$hasTabDocuments){ ?>
                    <li><a data-toggle="tab" href="#fragment-documents"><?php echo @$lbl_document ?></a></li>
                    <?php } ?>
                    <?php if(@$hasTabMap) {?>
                    <li><a data-toggle="tab" href="#fragment-map"><?php echo @$tab_map?></a></li>
                    <?php } ?>
                    <?php if(@$hasTabComment) {?>
                    <li><a data-toggle="tab" href="#fragment-comment">Đánh giá</a></li>
                    <?php } ?>
                  </ul>
                
                  <div class="tab-content">
                    <div id="fragment-content" class="tab-pane fade in active">
                        
                        <div style="<?php echo @$displaynews?>">
                            
                            <div>
                                <?php if(@$hasId) {?>
                                
                                
                                <div class="form-group">
                                    <label>ID</label>
                                    <?php if(@$post['id'] == ""){ ?>
                                    <input class="form-control" type="text" id="mediaid" name="mediaid" value="<?php echo @$post['mediaid']?>"/>
                                    <?php }else{ ?>
                                    <?php echo @$post['mediaid']?>
                                    <input type="hidden" id="mediaid" name="mediaid" value="<?php echo @$post['mediaid']?>" />
                                    <?php } ?>
                                </div>
                                <?php }else{ ?>
                                <input type="hidden" id="mediaid" name="mediaid" value="<?php echo @$post['mediaid']?>" />
                                <?php } ?>
                                <?php if(@$hasTitle) {?>
                                
                               
                                <div class="form-group">
                                    <label><?php echo @$entry_title?></label>
                                    <input class="form-control" type="text" id="title" name="title" value="<?php echo @$post['title']?>"  />
                                </div>
                                
                                <div class="form-group">
                                    <label><?php echo @$text_alias?></label>
                                    <input class="form-control" type="text" id="alias" name="alias" value="<?php echo @$post['alias']?>"  />
                                </div>
        <script>
        $('#title').change(function(e) {
            
            $.ajax({
                    url: "?route=common/api/getAlias&title=" + toBasicText(this.value),
                    cache: false,
                    success: function(html)
                    {
                        $("#alias").val(html);
                    }
            });
        });
        </script>
                               
                                <?php } ?>
                                <?php if(@$hasCode){?>
                                <div class="form-group">
                                    <label>Bar code</label>
                                    <input class="form-control" type="text" id="barcode" name="barcode" value="<?php echo @$post['barcode']?>"  />
                                </div>
                                <div class="form-group">
                                    <label>Ref</label>
                                    <input class="form-control" type="text" id="ref" name="ref" value="<?php echo @$post['ref']?>"  />
                                </div>
                                
                                <div class="form-group">
                                    <label>Model</label>
                                    <input class="form-control" type="text" id="code" name="code" value="<?php echo @$post['code']?>"  />
                                </div>
                                <div class="form-group">
                                    <label>Qui cách</label>
                                    <input class="form-control" type="text" id="sizes" name="sizes" value="<?php echo @$post['sizes']?>"  />
                                    
                                </div>
                                <div class="form-group">
                                    <label>Màu sắc</label>
                                    <input class="form-control" type="text" id="color" name="color" value="<?php echo @$post['color']?>"  />
                                    
                                </div>
                                <div class="form-group">
                                    <label>Mã màu sắc</label>
                                    <input class="form-control" type="text" id="colorcode" name="colorcode" value="<?php echo @$post['colorcode']?>"/>
                                    <input class="form-control" type="color" id="colorcodetext" name="colorcodetext" value="<?php echo @$post['colorcode']?>"  />
                                    <script language="javascript">
                                        $('#colorcodetext').change(function(e) {
                                            $('#colorcode').val(this.value);
                                        });
                                        $('#colorcode').change(function(e) {
                                            $('#colorcodetext').val(this.value);
                                        });
                                    </script>
                                </div>
                                <div class="form-group">
                                    <label>Chất liệu</label>
                                    <input class="form-control" type="text" id="material" name="material" value="<?php echo @$post['material']?>"  />
                                    
                                </div>
                                <div class="form-group">
                                    <label>Nhãn hiệu</label>
                                    <select id="brand" name="brand" class="form-control">
                                        <option value=""></option>
                                        <?php foreach($nhanhieu as $it){ ?>
                                        <option value="<?php echo @$it['categoryid']?>"><?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?><?php echo @$it['categoryname']?></option>                        
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Chú thích</label>
                                    <input class="form-control" type="text" id="noted" name="noted" value="<?php echo @$post['noted']?>"  />
                                </div>
                                <div class="form-group">
                                    <label>Đơn vị</label>
                                    <select id="unit" name="unit">
                                        
                                        <option value=""></option>
                                        <?php foreach($donvitinh as $val){ ?>
                                        <option value="<?php echo @$val['madonvi']?>" <?php echo ($post['unit']==$val['madonvi'])?"selected='selected'":"" ?>><?php echo @$val['tendonvitinh']?></option>
                                        <?php } ?>
                                        
                                    </select>
                                 </div>
                                    <script language="javascript">
                                        
                                        
                                        $('#unit').change(function(e) {
                                            $('#giaban').html('');
                                            if(this.value !="")
                                            {
                                                
                                                $.getJSON("?route=quanlykho/donvitinh/getListDonVi&madonvi="+ this.value,function(data){
                                                    var str = "<table>";
                                                    str+= '<tr>';
                                                    str+= '<td></td>';
                                                    str+= '<td>Sỉ</td>';
                                                    str+= '<td>Lẻ</td>';
                                                    str+= '</tr>';
                                                    for(i in data)
                                                    {
                                                        str += '<tr>';
                                                        str+= '<td>'+data[i].tendonvitinh+'</td>';
                                                        str+= '<td><input type="text" id="saleprice-'+data[i].madonvi+'" name="saleprice['+data[i].madonvi+']" class="text number"></td>';
                                                        str+= '<td><input type="text" id="retail-'+data[i].madonvi+'" name="retail['+data[i].madonvi+']" class="text number"></td>';
                                                        
                                                        str+=  '</tr>';
                                                        
                                                    }
                                                    str += "</table>";
                                                    $('#giaban').append(str);
                                                    numberReady();
                                                    <?php if(@$post["saleprice"]!=""){ ?>
                                                        
                                                    var saleprice = $.parseJSON('<?php echo @$post["saleprice"]?>');
                                                    for(i in saleprice)
                                                    {
                                                        //alert(saleprice[i])
                                                        $('#saleprice-'+i).val(saleprice[i]);
                                                    }
                                                    
                                                    <?php } ?>
                                                    
                                                    <?php if(@$post["retail"]!=""){ ?>
                                                        
                                                    var retail = $.parseJSON('<?php echo @$post["retail"]?>');
                                                    for(i in retail)
                                                    {
                                                        //alert(saleprice[i])
                                                        $('#retail-'+i).val(retail[i]);
                                                    }
                                                    
                                                    <?php } ?>
                                                    $('#frmgiaban').show();
                                                    numberReady();
                                                })										
                                            }
                                            else
                                            {
                                                $('#frmgiaban').hide();
                                            }
                                        });
                                        
                                        $(document).ready(function(e) {
                                            $("#frmPost #unit").val("<?php echo @$post['unit']?>").change();
                                            //$('#unit').val("<?php echo @$post['unit']?>").change();
                                            $('#frmPost #brand').val("<?php echo @$post['brand']?>");
                                        });
                                        
                                        
                                    </script>
                                   
                                </p>
                                <?php } ?>
                                <?php if(@$hasPrice) {?>
                                <div class="form-group" id="frmgiaban">
                                    <label>Giá bán</label>
                                    <div id="giaban"></div>
                                </div>
                                <div class="form-group">
                                
                                    <label><?php echo @$text_price?></label>
                                    <input class="text number" type="text" id="price" name="price" value="<?php echo @$post['price']?>"/>
                                    <select id="noteprice" name="noteprice">
                                        <option value=""></option>
                                    <?php foreach($producttype as $it){ ?>
                                
                                        <option value="<?php echo @$it['categoryid']?>"><?php echo @$it['categoryname']?></option>
                                    
                                    <?php } ?>
                                    </select>
                                    <script language="javascript">
                                    $('#noteprice').val("<?php echo @$post['noteprice']?>");
                                    </script>
                                    
                                </div>
                                <div class="form-group">
                                    <label>Phần trăm giảm giá</label>
                                    <input class="text number" type="text" id="discountpercent" name="discountpercent" value="<?php echo @$post['discountpercent']?>" />%
                                </div>
                                <div class="form-group">
                                    <label>Giá khuyến mãi</label>
                                    <input class="text number" type="text" id="pricepromotion" name="pricepromotion" value="<?php echo @$post['pricepromotion']?>" />
                                </div>
                                <script language="javascript">
                                $('#price').keyup(function(e) {
                                    $('#discountpercent').keyup();
                                });
                                $('#discountpercent').keyup(function(e) {
                                    if(this.value == 0)
                                    {
                                        $('#pricepromotion').val('0');
                                    }
                                    else
                                    {
                                        var price = Number(stringtoNumber($('#price').val()));
                                        var discountpercent = Number(stringtoNumber($('#discountpercent').val()));
                                        var pricepromotion = price*( 1- discountpercent/100);
                                        $('#pricepromotion').val(formateNumber(pricepromotion));
                                    }
                                });
                                
                                $('#pricepromotion').keyup(function(e) {
                                    if(this.value == 0)
                                    {
                                        $('#discountpercent').val('0');
                                    }
                                    else
                                    {
                                        var price = Number(stringtoNumber($('#price').val()));
                                        var pricepromotion = Number(stringtoNumber($('#pricepromotion').val()));
                                        var discountpercent = (1- pricepromotion/price)*100;
                                        $('#discountpercent').val(formateNumber(discountpercent));
                                    }
                                });
                                </script>
                                <?php } ?>
                                <div class="form-group">
                                    <label>Trang thái:</label>
                                    
                                    <select id="status" name="status" class="form-control">
                                        <?php foreach(@$this->document->status_media as $key =>$val){ ?>
                                        <option value="<?php echo @$key?>"?><?php echo @$val?></option>
                                        <?php } ?>
                                        
                                    </select>
                                    <script language="javascript">
                                        $('#frmPost #status').val("<?php echo @$post['status']?>")
                                    </script>
                                </div>
                            </div>
                            <?php if(@$hasFile) {?>
                            <div class="col2 right">
                                
                                <div class="form-group" id="pnImage">
                                    <label for="image"><?php echo @$entry_image?></label>
                                    
                                    <input type="button" class="button" value="<?php echo @$entry_photo ?>" onclick="browserFile('imageid','single')"/><br />
                                    <img id="imageid_preview" src="<?php echo @$imagethumbnail?>" onclick="showFile($('#imageid_filepath').val())"/>
                                    <input type="hidden" id="imageid_filepath" name="imagepath" value="<?php echo @$post['imagepath']?>" />
                                    <input type="hidden" id="imageid_fileid" name="imageid" value="<?php echo @$post['imageid']?>" />
                                    
                                </div>
                                
                                
                                <div id="errorupload" class="error" style="display:none"></div>
                                
                                <div class="loadingimage" style="display:none"></div>
                               <?php if(@$hasAttachment){ ?>
                                <p>
                                    <input type="button" class="button" value="<?php echo @$entry_photo ?>" onclick="browserFile('attachment','multi')"/>
                                    
                                </p>
                                <p id="attachment">
                                </p>
                                
                                <span id="delfile"></span>
                                <?php } ?>
                            </div>
                            <?php }?>
        <script language="javascript">
            var arratt = new Array();
            $(document).ready(function() {
            // put all your jQuery goodness in here.
            
            
        <?php
                foreach($attachment as $key => $item)
                {
                    if(count($item))
                    {
        ?>
                        
                        $('#attachment').append(attachment.creatAttachmentRow("<?php echo @$item['filepath']?>","<?php echo @$item['basename']?>","<?php echo @$item['imagethumbnail']?>"));
                        /*$.getJSON("?route=core/file/getFile&fileid=<?php echo @$item['fileid']?>&width=50", 
                        function(file) 
                        {
                            
                            $('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
                            
                        });*/
                    
        <?php
                    }
                }
        ?>
                //alert(arratt)
                //callAtt(0);
            });
        
        function callAtt(pos)
        {
            if(arratt[pos]!= undefined)
            {
                $('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
                callAtt(pos+1);
                /*$.getJSON("?route=core/file/getFile&fileid="+ arratt[pos] +"&width=50", 
                function(file) 
                {
                    
                    $('#attachment').append(attachment.creatAttachmentRow(file.file.fileid,file.file.filename,file.file.imagepreview));
                    callAtt(pos+1);
                });*/
            }
        }
        </script>
                            
                        
                        </div>
                        
                        <div>
                            
                            
                            
                            <?php if(@$hasSummary) {?>
                            <div class="form-group">
                                <label><?php echo @$entry_summary?></label>
                                <textarea class="form-control editor" rows="3" cols="70" id="summary" name="summary"><?php echo @$post['summary']?></textarea>
        <?php if(@$_GET['dialog']==""){ ?>
        <script language="javascript">
        $(document).ready(function(e) {
            //setCKEditorType('summary',2);
        });
        </script>
        <?php } ?>
                            </div>
                            <?php } ?>
                            <?php if(@$hasSEO) {?>
                            <div class="form-group">
                                <label>Meta description</label>
                                <textarea class="form-control" rows="3" cols="70" id="metadescription" name="metadescription"><?php echo @$post['metadescription']?></textarea>
        
                            </div>
                            <div class="form-group">
                                <label>Meta keyword</label>
                                <textarea class="form-control" rows="3" cols="70" id="keyword" name="keyword"><?php echo @$post['keyword']?></textarea>
                            </div>
                            <?php }?>
                            <?php if(@$hasSource) {?>
                            <div class="form-group">
                                <label><?php echo @$entry_source?></label>
                                <input class="form-control" type="text" name="source" value="<?php echo @$post['source']?>" size="40" />
                            </div>
                            <?php } ?>
                        
                        </div>
                        
                    </div>
                    <?php if(@$hasProperties) {?>
                    <div id="fragment-properties" class="tab-pane fade">
                        <div>
                            
                            <div class="form-group">
                                <label>Màu sắc</label>
                                <?php foreach($color as $it){ ?>
                                <div>
                                    
                                    <?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                                    <input type="checkbox"  name="loaisp[<?php echo @$it['categoryid']?>]" value="<?php echo @$it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                                    <?php echo @$it['categoryname']?>
                                </div>
                                <?php } ?>
                            </div>
                            <div class="form-group">
                                <label>Size</label>
                                <?php foreach($size as $it){ ?>
                                <div>
                                    
                                    <?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                                    <input type="checkbox"  name="loaisp[<?php echo @$it['categoryid']?>]" value="<?php echo @$it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                                    <?php echo @$it['categoryname']?>
                                </div>
                                <?php } ?>
                            </div>
                            <div class="form-group">
                                <label><?php echo @$text_status?></label>
                                <?php foreach($statuspro as $it){ ?>
                                <div>
                                    
                                    <?php echo @$this->string->getPrefix("&nbsp;&nbsp;&nbsp;&nbsp;",$it['level']) ?>
                                    <input type="checkbox"  name="loaisp[<?php echo @$it['categoryid']?>]" value="<?php echo @$it['categoryid']?>" <?php echo in_array($it['categoryid'],$properties)?'checked="checked"':''; ?> />
                                    <?php echo @$it['categoryname']?>
                                </div>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    <?php } ?>
                    <?php if(@$hasDetail){ ?>
                    <div id="fragment-detail" class="tab-pane fade">
                        
                        <input type="button" class="button" value="<?php echo @$entry_photo ?>" onclick="browserFile('description','editor')"/>
                        <input type="button" class="button" value="Chọn video" onclick="browserFile('description','video')"/>
                        
                        
                        <div class="form-group">
                            <textarea name="description" id="description" class="editor"><?php echo @$post['description']?></textarea>
                        </div>
                        
                    </div>
                    
                    <?php }?>
                    
                    <?php if(@$hasVideo) {?>
                    <div id="fragment-video" class="tab-pane fade">
                            <div class="form-group" id="pnVideo">
                                <label for="file"><?php echo @$lbl_file ?></label>
                                <a id="btnAddVideo" class="button"><?php echo @$entry_file ?></a><br />
                                <span id="filename"><?php echo @$post['filepath']?></span>
                                <input type="hidden" id="filepath" name="filepath" value="<?php echo @$post['filepath']?>" />
                                <input type="hidden" id="fileid" name="fileid" value="<?php echo @$post['fileid']?>" />
                                <div id="sub_errorupload" class="error" style="display:none"></div>
                                
                                
                            </div>
                            
                            
                            <div id="errorupload" class="error" style="display:none"></div>
                            
                            <div class="loadingimage" style="display:none"></div>
                    </div>
                    <?php } ?>
                    
                    <?php if(@$hasAudio) {?>
                    <div id="fragment-audio" class="tab-pane fade">
                            <div class="form-group" id="pnAudio">
                                <label for="file"><?php echo @$lbl_file ?></label>
                                <a id="btnAddAudio" class="button"><?php echo @$entry_file ?></a><br />
                                <span id="filename"><?php echo @$filepath?></span>
                                <input type="hidden" id="filepath1" name="filepath" value="<?php echo @$post['filepath']?>" />
                                <input type="hidden" id="fileid1" name="fileid" value="<?php echo @$post['fileid']?>" />
                                <div id="sub_errorupload" class="error" style="display:none"></div>
                                
                                
                            </div>
                            
                            
                            <div id="errorupload" class="error" style="display:none"></div>
                            
                            <div class="loadingimage" style="display:none"></div>
                    </div>
                    <?php } ?>
                    
                    <?php if(@$hasSubInfor) {?>
                    <div id="fragment-subinfor" class="tab-pane fade">
                        <input type="hidden" name="sub_mediaid" id="sub_mediaid" />
                        <div>
                            <div class="form-group">
                               <?php echo @$lbl_title ?>
                                <input class="form-control" type="text" name="sub_title" id="sub_title" value="" size="40" />
                            </div>
                            <div class="form-group" id="sub_pnImage">
                                <label for="image"><?php echo @$lbl_image ?></label>
                                <a id="btnAddSubImage" class="button"><?php echo @$entry_photo ?></a><br />
                                <img id="sub_preview" src="" />
                                <input type="hidden" id="sub_imagepath" name="sub_imagepath" />
                                <input type="hidden" id="sub_imageid" name="sub_imageid"  />
                                <input type="hidden" id="sub_imagethumbnail" name="sub_imagethumbnail" />
                            </div>
                            <div class="form-group">
                                <textarea name="sub_description" id="sub_description" cols="80" rows="10"></textarea>
                            </div>
                            <div class="form-group">
                                <input type="button" class="button" value="<?php echo @$button_save?>" onclick="postSubInfor()"/>
                                <input type="button" class="button" value="<?php echo @$button_cancel?>"/>
                            </div>
                        </div>
                        <div id="subinforlist">
                        </div>
        <script language="javascript">
        function postSubInfor()
        {
            
            $.post("?route=core/postcontent/savepost", 
                            {
                                mediaid : $("#sub_mediaid").val(), 
                                mediaparent : $("#mediaid").val(),
                                title : $("#sub_title").val(), 
                                mediatype : 'subinfor',
                                description : $("#sub_description").val(),
                                imageid : $("#sub_imageid").val(),
                                imagepath : $("#sub_imagepath").val()
                            },
                function(data){
                    if(data=="true")
                    {
                        $("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
                        $("#sub_mediaid").val("");
                        $("#sub_title").val("");
                        $("#sub_summary").val("");
                        $("#sub_author").val("");
                        $("#sub_imageid").val("");
                        $("#sub_imagepath").val("");
                        $("#sub_preview").attr("src", "");
                        
                        $("#subimageerror").hide('slow');
                    }
                    else
                    {
                        $("#subimageerror").html(data);
                        $("#subimageerror").show('slow');
                    }
                    
                });
        }
        function editeSubInfor(mediaid)
        {
            
            $.getJSON("?route=core/postcontent/getSubInfor&mediaid="+mediaid, 
                    function(data) 
                    {
                        //alert(data.subimage.imagepreview);
                        $("#sub_mediaid").val(data.subinfor.mediaid);
                        $("#sub_title").val(data.subinfor.title);
                        $("#sub_summary").val(data.subinfor.summary);
                        $("#sub_author").val(data.subinfor.author);
                        $("#sub_imageid").val(data.subinfor.imageid);
                        $("#sub_imagepath").val(data.subinfor.imagepath);
                        $("#sub_imagethumbnail").val(data.subinfor.imagepreview);
                        $("#sub_preview").attr("src", data.subinfor.imagepreview);
                       
                        
                    });
        }
        
        function removeSubInfor(mediaid)
        {
            //$.blockUI({ message: "<h1><?php echo @$announ_infor ?></h1>" });
            $.ajax({
                url: "?route=core/postcontent/removeSubImage&mediaid="+mediaid, 
                cache: false,
                success: function(html)
                {
                    $("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
                }
            });
            
        }
        </script>
        <script language="javascript">
        $(document).ready(function() { 
            //setCKEditorType('sub_description',2);
            $("#subinforlist").load("?route=core/postcontent/loadSubInfor&mediaid="+$("#mediaid").val());
        })
        </script>
                    </div>
                    <?php }?>
                    <?php if(@$hasTabImages){ ?>
                    <div id="fragment-images" class="tab-pane fade">
                    </div>
                    <?php } ?>
                    <?php if(@$hasTabVideos){ ?>
                    <div id="fragment-videos" class="tab-pane fade">
                    </div>
                    <?php } ?>
                    <?php if(@$hasTabDocuments){ ?>
                    <div id="fragment-documents" class="tab-pane fade">
                    </div>
                    <?php } ?>
                    
                    <?php if(@$hasTabMap) {?>
                    
                    <div id="fragment-map" class="tab-pane fade">
                        <div>
                            <ul>
                                <?php echo @$listReferSiteMap?>
                            </ul>
                           
                                
                            
                        
                        </div>
                    </div>
                    <?php if(count($arrrefersitemap)){?>
                        <?php foreach($arrrefersitemap as $sitemapid){?>
                            <?php if(@$sitemapid){ ?>
                            <script language="javascript">
                                $('#refersitemap-<?php echo @$sitemapid?>').attr('checked','checked');
                            </script>
                            <?php } ?>
                        <?php }?>
                    <?php } ?>
                    <?php } ?>
                    <?php if(@$hasTabComment) {?>
                    <div id="fragment-comment" class="tab-pane fade">
                        <div id="listcommet">
                        </div>
                    </div>
        <script language="javascript">
        function Comment()
        {
            this.loadComment = function(mediaid)
            {
                $('#listcommet').load('?route=core/comment&mediaid='+mediaid+"&popup=true");
            }
        }
        function callbackLoadCommnet()
        {
            objComment.loadComment("<?php echo @$post['mediaid']?>");
        }
        var objComment = new Comment();
        $(document).ready(function(e) {
            objComment.loadComment("<?php echo @$post['mediaid']?>");
        });
        </script>
                    <?php } ?>
                  </div>
                
                
             
            
            
            	</div>
            </form>
        </div>
	</div>  
</div>


<script type="text/javascript" charset="utf-8">
function save()
{
	$.blockUI({ message: "<h1><?php echo @$announ_infor ?></h1>" });
	<?php if(@$hasDetail){ ?>
	
	<?php } ?>
	
	<?php if(@$hasSummary) {?>
	
	<?php } ?>
	$.post("?route=core/postcontent/savepost",$('#frmPost').serialize(),
		function(data){
			var obj = $.parseJSON(data);
			if(obj.error=="")
			{
				window.location = "<?php echo @$DIR_CANCEL?>";
			}
			else
			{
				$('#error').html(data).show('slow');
				$.unblockUI();
			}
			
			
		});
}




$(document).ready(function() { 
	
	$('.editor').summernote({
        height: 200,
        tabsize: 2,
        toolbar: [
  		    ['style', ['bold', 'italic', 'underline', 'clear']],
  		    ['color', ['color']],
  		    ['para', ['ul', 'ol', 'paragraph']],
  		    ['height', ['height']],
  		    ['table', ['table']],
  		    ['insert', ['hello', 'helloImage']],
  		    ['insert2', ['helloDropdown']],
  		  ]
      });
});
</script>

