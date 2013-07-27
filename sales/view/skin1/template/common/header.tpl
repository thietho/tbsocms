
<div id="top">

    
    <div class="left">
        
        
        
        <h2><?php echo $title_system?></h2>
        
		
        <div class="clearer">&nbsp;</div>

    </div>
    
    <div class="right text-center" id="logo">
        <a href="http://ben-solution.com/">
            <img class="png" src="<?php echo DIR_IMAGE?>logo.png"/><br />
        </a>  
    </div>
    
    <div class="right">
        <table>
            <tr>
                <td><a href="?route=page/home"><img class="png" src="<?php echo DIR_IMAGE?>home.png" alt="" /></a></td>
                <td>
                    
                    <ul class="nicelist">
                        
                        <li><a href="index.php?route=addon/nhanvien/profile">Logged user: <b><?php echo $username?></b></a></li>
                        <li><a href="index.php?route=common/changepassword"><?php echo $button_change_password?></a></li>
                        <?php if($this->user->getUserTypeId() == 'admin'){?>
                        <li><a href="<?php echo ADIMCP?>">Quản trị hệ thống</a></li>
                        <?php } ?>
                        <li><a onclick="pro.viewIncome()">Tổng kết doanh thu</a></li>
                        <li><a href="logout.php"><?php echo $button_logout?></a></li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>

    <div class="clearer">&nbsp;</div>

</div>