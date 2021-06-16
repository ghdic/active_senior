<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String curTab = request.getParameter("curTab");
	String userID = ScriptManager.loginCheck(session, response, false);
	User user = null;
	if (userID != null) {
	    user = UserDAO.getUser(userID);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title><%= title %></title>
	<!-- font-awesome, Summornote, jquery -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" integrity="sha512-bnIvzh6FU75ZKxp0GXLH9bewza/OIw6dLVh9ICg0gogclmYGguQJWl8U30WpbsGTqbIiAwxTsbe76DErLq5EDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/static/main.css">
</head>
<body>
<nav id="active_senior_navbar">
	<div class="logo">
		<a href="/"><img src="static/image/active_senior.png" alt="logo"></a>
	</div>
	<input type="checkbox" id="check">
	<div class="menu-icon">
		<label for="check" class="button">
			<span></span>
			<span></span>
			<span></span>
		</label>
	</div>
	<ul class="topnav">
		<li class="dropdown">
			<a href="#" class="nav-item <% if(curTab.equals("1")){%>active<% } %>">소개</a>
			<div class="dropdown-content">
				<a href="/introduce" class="nav-item">사이트 소개</a>
				<a href="/activeSenior" class="nav-item">액티브 시니어란?</a>
			</div>
		</li>
		<li><a href="/appList" class="nav-item <% if(curTab.equals("2")){%>active<% } %>">구인 & 고용</a></li>
		<li class="dropdown">
			<a href="#" class="nav-item <% if(curTab.equals("3")){%>active<% } %>">교육</a>
			<div class="dropdown-content">
				<a href="/eduList?category=0">교육영상</a>
				<a href="/eduList?category=1">교육후기</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="nav-item <% if(curTab.equals("4")){%>active<% } %>">정보알리미</a>
			<div class="dropdown-content">
				<a href="/infoList?category=0">공지/채용정보</a>
				<a href="/infoList?category=1">지원사업</a>
				<a href="/infoList?category=2">이벤트/행사</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="nav-item <% if(curTab.equals("5")){%>active<% } %>">취미</a>
			<div class="dropdown-content">
				<a href="/hobbyList?category=0">사람책</a>
				<a href="/hobbyList?category=1">여행</a>
				<a href="/hobbyList?category=2">건강</a>
				<a href="/hobbyList?category=3">재무</a>
				<a href="/hobbyList?category=4">문화라이프</a>
			</div>
		</li>
		<li><a href="/cmntyList" class="nav-item <% if(curTab.equals("6")){%>active<% } %>">커뮤니티</a></li>
		<li style="float: right;" class="login">
			<% if(userID == null) { %>
			<i class="far fa-user"></i><a href="/login" class="nav-item">로그인</a>
			<a href="/register" class="nav-item">회원가입</a>
			<% } else {%>
			<i class="far fa-user"></i><a href="/account" class="nav-item"><%= userID %>님 안녕하세요!</a>
			<i class="fas fa-sign-out-alt"></i><a href="/logoutAction" class="nav-item">로그아웃</a>
			<% } %>
			<% if(user != null && user.getUserAuthority() == 0) { %>
			<i class="fas fa-users-cog"></i><a href="/admin" class="nav-item">사이트 관리</a>
			<% } %>
		</li>

	</ul>

	<hr>
</nav>





