			<?php echo $pager?>
			<table class="data-table" width="100%">
            
            	<thead>
                	<th width="10%"><?php echo $column_position?></th>
                    
                    <th>Code</th>
                    <th>Quy cách</th>
                    <th>Giá</th>
                    <th>Giá khuyến mãi</th>
                    <th width="200px">Tồn kho</th>
   
                    <th>Tên sản phẩm</th>
                    <th>ĐVT</th>
                    <th>Hình</th>
                    <th></th>
                </thead>
                
                <tbody>
                    <?php foreach($medias as $key => $media) {?>
                	<tr>
                    	<td>
                        	<input type="checkbox" value="<?php echo $media['mediaid']?>" name="delete[<?php echo $media['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $media['mediaid']?>]" value="<?php echo $key+1?>" size="3"/>
                        </td>
                        
                        <td><b><?php echo $media['code']?></b>&nbsp;</td>
                        <td><b><?php echo $media['sizes']?></b>&nbsp;</td>
                        <td class="number">
                        	
                        	<ul>
                            	<?php if($media['price']){ ?>
                            	<li><?php echo $this->string->numberFormate($media['price'])?></li>
                                <?php } ?>
                                <?php if(count($media['saleprice'])){ ?>
                                <?php foreach($media['saleprice'] as $k => $price){ ?>
                            	<li><?php echo $this->string->numberFormate($price)?>/<?php echo $this->document->getDonViTinh($k)?></li>
                            	<?php } ?>
                                <?php } ?>
                            </ul>
                        	
                            
                        </td>
                        <td class="number"><b><?php echo $this->string->numberFormate($media['pricepromotion'])?></b>&nbsp;</td>
                        <td class="number">
                        	<?php echo $media['tonkho']?>
                            
                        </td>
                       
                        <td><b><?php echo $media['title']?></b>&nbsp;</td>
                        <td><b><?php echo $this->document->getDonViTinh($media['unit'])?></b>&nbsp;</td>
                        <td><?php echo $media['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	
                            <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="window.location='<?php echo $media['link_edit']?>'"/>
                            <?php } ?>
                            <?php if($this->user->checkPermission("module/product/insert")==true){ ?>
                  			
                            <input type="button" class="button" value="<?php echo $media['text_addchild']?>" onclick="window.location='<?php echo $media['link_addchild']?>'"/>
                            <?php }?>
                        </td>
                    </tr>
                    	<?php if(count($media['child'])){ ?>
                        	<?php foreach($media['child'] as $k => $child){ ?>
                    <tr class="media-child">
                    	<td>
                        	<input type="checkbox" value="<?php echo $child['mediaid']?>" name="delete[<?php echo $child['mediaid']?>]" class="inputchk">
                            <input type="text" class="text number" name="position[<?php echo $child['mediaid']?>]" value="<?php echo $k +1?>" size="3"/>
                        </td>
                        
                        <td><b><?php echo $child['code']?></b>&nbsp;</td>
                        <td><b><?php echo $child['sizes']?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($child['price'])?></b>&nbsp;</td>
                        <td class="number"><b><?php echo $this->string->numberFormate($child['pricepromotion'])?></b>&nbsp;</td>
                        <td class="number">
                        	<?php echo $child['tonkho']?>
                        </td>
                       
                        <td><b><?php echo $child['title']?></b>&nbsp;</td>
                        <td><b><?php echo $this->document->getDonViTinh($child['unit'])?></b>&nbsp;</td>
                        <td><?php echo $child['imagepreview']?>&nbsp;</td>
                        <td>
                        	<?php if($this->user->checkPermission("module/product/update")==true){ ?>
                        	
                            <input type="button" class="button" value="<?php echo $media['text_edit']?>" onclick="window.location='<?php echo $child['link_edit']?>'"/>
                            <?php } ?>
                           
                        </td>
                    </tr> 
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>                	
                	
                </tbody>
            
            </table>
            <?php echo $pager?>
            <div class="clearer">&nbsp;</div>
