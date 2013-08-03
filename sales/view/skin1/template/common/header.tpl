
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
                <td><a onclick="$('#main-screen').load('?route=page/home/main');"><img class="png" src="<?php echo DIR_IMAGE?>home.png" alt="" /></a></td>
                <td>
                    
                    <ul class="nicelist">
                        
                        <li>Logged user: <b><?php echo $username?></b></li>
                        
                    </ul>
                </td>
            </tr>
        </table>
    </div>

    <div class="clearer">&nbsp;</div>

</div>