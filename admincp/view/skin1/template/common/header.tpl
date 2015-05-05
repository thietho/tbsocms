
<div id="top">

    <div class="left text-center" id="weblogo">
        <a href="http://holansolutions.com/">		
			<?php echo $imagepreview ?>
		</a>  
    </div>

    <div class="left">
        
        
        
        <h2><?php echo $title_system?></h2>
        

        <div class="clearer">&nbsp;</div>

    </div>
    
    <div class="right text-center" id="logo">
        <a href="http://holansolutions.com/">
            <img class="png" src="<?php echo DIR_IMAGE?>logo.png"/><br />
        </a>  
    </div>
    
    <div class="right">
        <table>
            <tr>
                <td>
                	<a href="?route=page/home"><img class="png" src="<?php echo DIR_IMAGE?>home.png" alt="" /></a>
                </td>
                <?php if($this->user->checkPermission("core/notification/systemCheck")==true){ ?>
                <td>
                	<div id="hl-notification">
                    	<div id="notification-number"></div>
                        <div id="notification-content"></div>
                    	<img class="png" src="<?php echo DIR_IMAGE?>notification-icon.png" alt="" />
                        
                    </div>
                </td>
                <?php } ?>
                <td>
                    
                    <ul class="nicelist">
                        
                        <li><a href="index.php?route=quanlykho/nhanvien/profile">Logged user: <b><?php echo $username?></b></a></li>
                        <li><a href="index.php?route=common/changepassword"><?php echo $button_change_password?></a></li>
                        <?php if($this->user->getUserTypeId() == 'admin'){?>
                        <li><a href="?route=core/module">Phân quyền</a></li>
                        <?php } ?>
                        <li><a href="logout.php"><?php echo $button_logout?></a></li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>

    <div class="clearer">&nbsp;</div>

</div>
<?php if($this->user->checkPermission("core/notification/systemCheck")==true){ ?>
<script language="javascript">
$('#hl-notification').hover(
	function(e)
	{
		$('#notification-content').show();
		
	},
	function(e)
	{
		$('#notification-content').hide();
	});
$(document).ready(function(e) {
	setTimeout('no.systemCheck();',5000);
    
});
</script>
<?php } ?>