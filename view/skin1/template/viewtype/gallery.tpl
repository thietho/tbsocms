	<div id="listpoduct">
    	<table>
        	<?php for($i=0;$i<count($medias);){ ?>
            <tr>
            	<?php for($j=0;$j<4;$j++){ ?>
                <td width="25%">
                	<?php $media = $medias[$i]?>
                    <?php $i++?>
                    <?php if(count($media)){ ?>
                     <div class="ben-left product" ref="<?php echo $media['imagetpreview']?>" title="<?php echo $media['keyword']?>">
                        <table>
                            <tr class="product-list-image">
                                <td>
                                    <?php if($media['discountpercent']){ ?>
                                    <div class="flagdiscount ben-icon">-<?php echo $media['discountpercent']?>%</div>
                                    <?php } ?>
                                    <?php if(in_array("sanphamhot",$media['properties'])){ ?>
                                    <div id="ben-icon-hot" class="ben-icon">
                                        <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-hot.png" />
                                    </div>
                                    <?php } ?>
                                    <?php if(in_array("sanphamkhuyenmai",$media['properties'])){ ?>
                                    <div id="ben-icon-sale" class="ben-icon">
                                        <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-sale.png" />
                                    </div>
                                    <?php } ?>
                                    <?php if(in_array("sanphammoi",$media['properties'])){ ?>
                                    <div id="ben-icon-new" class="ben-icon">
                                        <img src="<?php echo HTTP_SERVER.DIR_IMAGE?>icon/ico-new.png" />
                                    </div>
                                    <?php } ?>
                                    <?php if($media['imagethumbnail'] !=""){ ?>
                                    <a class="islink" href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>"><img src="<?php echo $media['imagethumbnail']?>" class='ben-center' alt="<?php echo $media['title']?>" title="<?php echo $media['title']?>"/></a>
                                    
                                    <?php }?>
                                        
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div align="center">
                                        <a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">
                                            <h6>
                                                <?php echo $media['title']?>
                                            </h6>
                                            <?php if($media['code']!="") echo "<h6>".$media['code']."</h6>"?>
                                        </a>
                                    </div>
                                    <?php $cls = '';?>
                                    <?php if($media['pricepromotion']!=0){ ?>
                                    <div align="center" class="product-pricepromotion">
                                            
                                            <?php if($media['pricepromotion']){ ?>
                                            <?php $cls = 'product-price-no';?>
                                            <?php echo $this->string->numberFormate($media['pricepromotion'])?> <?php echo $this->document->setup['Currency']?>
                                            <?php } ?>
                                    </div>
                                    <?php } ?>
                                    <div align="center" class="product-price <?php echo $cls?>"><?php echo $this->string->numberFormate($media['price'])?> <?php echo $this->document->setup['Currency']?></div>
                                    <div align="center">
                                        <!--<a href="<?php echo $media['link']?>" title="<?php echo $media['title']?><?php if($media['code']!="") echo ' - '.$media['code']?>">Chi tiết</a>-->
                                        
                                        <input type="button" class="cart-order" value="Đặt hàng" onclick="cart.add('<?php echo $media['mediaid']?>')"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        
                        
                        
                        
                    </div>
                    <?php } ?>
                    </td>
                <?php } ?>
            </tr>
            <?php } ?>
        </table>
                    
        
    </div>