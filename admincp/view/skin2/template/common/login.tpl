<div class="error"><?php echo @$error_warning?></div>
<form role="form" method="post">
    <fieldset>
        <div class="form-group">
            <input class="form-control" placeholder="Username" name="username" type="username" autofocus>
        </div>
        <div class="form-group">
            <input class="form-control" placeholder="Password" name="password" type="password" value="">
        </div>
        
        <!-- Change this to a button or input when using this as a form -->
        <input type="submit" class="btn btn-lg btn-success btn-block" value="Login">
        
    </fieldset>
</form>