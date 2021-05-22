<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<!-- font-awesome, Summornote, jquery -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" />
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/static/main.css">
	<title><%= title %></title>
</head>
<body>
<nav>
	<a href="/"><img src="static/active_senior.png" alt="logo" class="logo"></a>
	<input type="checkbox" id="check">
	<div class="menu-icon">
		<label for="check" class="button">
			<span></span>
			<span></span>
			<span></span>
		</label>
	</div>
	<ul class="topnav">
		<li style="width: 100%; height: 80px;"></li>
		<li class="dropdown">
			<a href="#" class="nav-item">소개</a>
			<div class="dropdown-content">
				<a href="/introduce" class="nav-item">사이트 소개</a>
				<a href="/activeSenior" class="nav-item">액티브 시니어란?</a>
			</div>
		</li>
		<li><a href="/appList" class="nav-item active">구인 & 고용</a></li>
		<li class="dropdown">
			<a href="#" class="nav-item">교육</a>
			<div class="dropdown-content">
				<a href="/eduVideoList">교육영상</a>
				<a href="/eduReviewList">교육후기</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="nav-item">정보알리미</a>
			<div class="dropdown-content">
				<a href="/noticeList">공지/채용정보</a>
				<a href="/supportList">지원사업</a>
				<a href="/eventList">이벤트/행사</a>
			</div>
		</li>
		<li class="dropdown">
			<a href="#" class="nav-item">취미</a>
			<div class="dropdown-content">
				<a href="/peopleBookList">사람책</a>
				<a href="/tripList">여행</a>
				<a href="/healthList">건강</a>
				<a href="/financeList">재무</a>
				<a href="/cultureList">문화라이프</a>
			</div>
		</li>
		<li><a href="/communityList" class="nav-item">커뮤니티</a></li>
		<li style="float: right;" class="login">
			<% if(userID == null) { %>
			<i class="far fa-user"></i><a href="/login" class="nav-item">로그인</a>
			<a href="/register" class="nav-item">회원가입</a>
			<% } else {%>
			<i class="far fa-user"></i><a href="/account" class="nav-item"><%= userID %>님 안녕하세요!</a>
			<i class="fas fa-sign-out-alt"></i><a href="/logoutAction" class="nav-item">로그아웃</a>
			<% } %>
		</li>

	</ul>

	<hr>
</nav>





