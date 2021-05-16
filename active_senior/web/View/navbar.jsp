<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>
<!DOCTYPE html>
<html>
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- Bootstrap CSS, font-awesome -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" />
	<!-- Summornote, jquery -->
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<link rel="stylesheet" type="text/css" href="static/main.css">
	<title><%= title %></title>

</head>
<body>

<header class="site-header">
	<nav class="navbar navbar-expand-md navbar-dark bg-steel fixed-top">
		<div class="container">
			<a class="navbar-brand mr-4" href="/">Simple Board</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggle" aria-controls="navbarToggle" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarToggle">
				<div class="navbar-nav mr-auto">
					<a class="nav-item nav-link" href="/">Home</a>
					<a class="nav-item nav-link" href="/about.jsp">About</a>
				</div>
				<!-- Navbar Right Side -->
				<div class="navbar-nav">
					<%
						if(userID == null) {
					%>
					<a class="nav-item nav-link" href="/login.jsp">Login</a>
					<a class="nav-item nav-link" href="/register.jsp">Register</a>
					<%
					} else {
					%>
					<a class="nav-item nav-link" href="/new_post.jsp">New Post</a>
					<a class="nav-item nav-link" href="/account.jsp">Account</a>
					<a class="nav-item nav-link" href="/logoutAction.jsp">Logout</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</nav>
</header>


