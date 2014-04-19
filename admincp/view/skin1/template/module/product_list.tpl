			<?php echo $pager?>
			<table class="data-table" width="100%">
            
            	<thead>
                	<th width="10%"><?php echo $column_position?></th>
                    
                    
                    <th>Tên sản phẩm</th>
                    <th>Barcode</th>
                    <th>Ref</th>
                    <th>Giá</th>
                    <th>Giảm</th>
                    <th>Giá khuyến mãi</th>
                    <th width="200px">Tồn kho</th>
   
                    
                    <th>ĐVT</th>
                    <th>Nhãn hiệu</th>
                    <th>Trạng thái</th>
                    <th>Hình</th>
                    <th>Danh mục</th>
                    <th></th>
                </thead>
                
                <tbody>
                    <?php foreach($medias as $key => $media) {?>
                	<tr id="<?php echo $media['mediaid']?>">
                    	<td>
                        	<input type="checkbox" value="<?php echo $media['mediaid']?>" name="delete[<?php echo $media['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $media['mediaid']?>]" value="<?php echo $key+1?>" size="3"/>
                        </td>
                        
                        
                    	<td>
                        	<b class="title"><?php echo $this->document->productName($media)?></b>
                            
                        </td>
                        <td class="barcode"><?php echo $media['barcode']?></td>
                        <td class="ref"><?php echo $media['ref']?></td>
                        <td class="number">
                            <b class="price">
                            	<?php echo $this->string->numberFormate($media['price'])?>
                                <?php if($media['noteprice']!=""){?>
                                <br />(<?php echo $media['noteprice']?>)
                                <?php }?>
                            </b>
                        </td>
                        <td class="number">
                            <b class="discountpercent"><?php echo $this->string->numberFormate($media['discountpercent'])?>%</b>
                        </td>
                        <td class="number"><b class="pricepromotion"><?php echo $this->string->numberFormate($media['pricepromotion'])?></b></td>
                        <td class="number" class="tonkho">
                        	<?php echo $media['tonkho']?>
                            
                        </td>
                       
                        
                        <td><b class="unit"><?php echo $this->document->getDonViTinh($media['unit'])?></b>&nbsp;</td>
                        <td class="brand"><?php echo $this->document->getCategory($media['brand'])?></td>
                        <td class="status"><?php echo $this->document->status_media[$media['status']]?></td>
                        <td align="center" ><img class="imagepreview" src="<?php echo $media['imagepreview']?>" />&nbsp;</td>
                        <td><?php echo $media['sitemapname']?></td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	
                            
                            <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="showProductForm('<?php echo $media['mediaid']?>','<?php echo $media['link_edit']?>')"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                  			
                            <input type="button" class="button" value="<?php echo $media['text_addchild']?>" onclick="window.location='<?php echo $media['link_addchild']?>'"/>
                            <input type="button" class="button enterGroup" value="Đưa vào nhóm" onclick="pro.enterGroup('<?php echo $media['mediaid']?>')"/>
                            <input type="button" class="button selectGroup" value="Chọn" onclick="pro.selectGroup('<?php echo $media['mediaid']?>')"/>
                            <?php }?>
                            <input type="button" class="button" value="Lịch sử" onclick="pro.history('<?php echo $media['mediaid']?>')"/>
                            <?php if(count($media['child'])==0){ ?>
                            
                            <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $media['mediaid']?>')"/>
                            
                            <?php } ?>
                        </td>
                    </tr>
                    	<?php if(count($media['child'])){ ?>
                    
                            <?php foreach($media['child'] as $k => $child){ ?>
                                <tr id="<?php echo $child['mediaid']?>" class="media-child">
                                    <td>
                                        <input type="checkbox" value="<?php echo $child['mediaid']?>" name="delete[<?php echo $child['mediaid']?>]" class="inputchk">
                                        <input type="text" class="text number" name="position[<?php echo $child['mediaid']?>]" value="<?php echo $k +1?>" size="3"/>
                                    </td>
                                    <td>
	                                    <b class="title"><?php echo $this->document->productName($child)?></b>
                                        
                                    </td>
                                    <td class="barcode"><?php echo $child['barcode']?></td>
                                    <td class="ref"><?php echo $child['ref']?></td>
                                    <td class="number">
                                        <b class="price">
                                            <?php echo $this->string->numberFormate($child['price'])?>
                                            <?php if($child['noteprice']!=""){?>
                                            <br />(<?php echo $child['noteprice']?>)
                                            <?php }?>
                                        </b>
                                    </td>
                                    <td class="number">
                                        <b class="discountpercent"><?php echo $this->string->numberFormate($child['discountpercent'])?>%</b>
                                    </td>
                                    <td class="number"><b class="pricepromotion"><?php echo $this->string->numberFormate($child['pricepromotion'])?></b></td>
                                    <td class="number" class="tonkho">
                                        <?php echo $child['tonkho']?>
                                        
                                    </td>
                                   
                                    
                                    <td><b class="unit"><?php echo $this->document->getDonViTinh($child['unit'])?></b>&nbsp;</td>
                                    <td class="brand"><?php echo $this->document->getCategory($child['brand'])?></td>
                                    <td class="status"><?php echo $this->document->status_media[$child['status']]?></td>
                                    <td align="center" ><img class="imagepreview" src="<?php echo $child['imagepreview']?>" />&nbsp;</td>
                                    
                                    
                                    <td>
                                        <?php if($this->user->checkPermission("module/product/update")==true){ ?>
                                        
                                        <input type="button" class="button" value="<?php echo $child['text_edit']?>" onclick="showProductForm('<?php echo $child['mediaid']?>','<?php echo $child['link_edit']?>')"/>
                              			          
                                        <?php } ?>
                                       	<input type="button" class="button" value="Ra ngoài nhóm" onclick="pro.outGroup('<?php echo $child['mediaid']?>')"/>
                                        <input type="button" class="button" value="Lịch sử" onclick="pro.history('<?php echo $child['mediaid']?>')"/>
                                        <input type="button" class="button" value="Đưa vào danh sách" onclick="pro.addToList('<?php echo $child['mediaid']?>')"/>
                                    </td>
                                </tr> 
                            <?php } ?>
                            
                        	
                        <?php } ?>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
