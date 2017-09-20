<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>LOGIN APPLICATION</title>
</head>

<body style="background-image:url('../background.jpg');
    				background-repeat:no-repeat;
    				background-size:cover;">
   <div class="w3-container w3-teal">
        <h1 class="w3-padding  w3-left">Do-Did-Done</h1>
   </div>
   <br>
<% 
	String messageFromServer = (String) request.getAttribute("messageFromServer");
	if(messageFromServer != null) {
		out.println("<div class=\"w3-container w3-center\"><font color=\"red\"><h3>" 
					+ messageFromServer + "</h3></font></div>");
	}
%>   
   <br>
   <div class="w3-container w3-center">
	<form method="post" action="/userRegister" style="width:33%; display:inline-block; text-align: center;">
		<input class="w3-input" type="text" name="username" placeholder="Username" required/><br />
		<input class="w3-input" type="password" name="password" placeholder="Password" required/><br />
		<input class="w3-input" type="text" name="fname" placeholder="First Name" required/><br />
		<input class="w3-input" type="text" name="lname" placeholder="Last name" required/><br />
		<input class="w3-input" type="text" name="email" placeholder="Email Id" required/><br />
		<input class="w3-input" type="text" name="phone" placeholder="Contact Number" required/><br />
		<input class="w3-input w3-purple w3-hover-text-black" type="submit" value="Register"  />
	</form>
  </div>
</body>
</html>