<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>登录界面</title>
<script type="text/javascript">  
     function checkaccount() {  
         var x=document.getElementById("account").value;
         if(x.length>20) {  
              alert("用户账户位数不能大于20")
              document.getElementById("account").value = "";
         }
     }
     function checkpwd() {  
         var x=document.getElementById("password").value;
         if(x.length>20) {  
              alert("密码最大只有20位")
              document.getElementById("password").value = "";
         }
     }
     function Checka(){
          var Username = document.getElementById("account").value;
          if (Username == "" || account.value == null ) {
                alert("用户名不能为空");
            }
     }
     function Checkp(){
          var Username = document.getElementById("password").value;
          if (Username == "" || password.value == null ) {
                alert("密码不能为空");
            }
     }

        </script>
</head>
<body style="text-align:center;">
<br><br><br>
<form name="form2" action="Login" method="post"> 
帐号 <input type="text" name="account" id="account" onblur="Checka();checkaccount();"><br><br>
密码 <input type="password" name="password" id="password" onblur="Checkp;checkpwd();"><br><br>
<input type="submit" value="登录">
</form>
</body>
</html>
