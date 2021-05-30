<%@ page import="controller.tool.ScriptManager" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="취미 게시판 글쓰기"/>
	<jsp:param name="curTab" value="5"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	int category = ScriptManager.categoryCheck(request, response, true);
%>

<form action="/hobbyWriteAction" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th>학습 게시판 글쓰기</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" id="bbsTitle" name="bbsTitle" autocomplete="off"></td>
		</tr>
		<tr>
			<td><textarea id="summernote" name="bbsContent"></textarea></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="임시 저장" onclick="setContent()">
				<input type="button" value="불러오기" onclick="getContent()">
			</td>
		</tr>
		<tr>
			<td>
				<label for="profile">썸네일:</label><input type="file" id="profile" name="bbsThumbnail" accept="image/*">
				<img src="/static/image/default/default-image.png" alt="프로필" id="profilePreview" width="100px" height="100px">
			</td>
		</tr>
		<tr>
			<td><input type="hidden" name="bbsCategory" value="<%= category %>"></td>
		</tr>
		<tr>
			<td><input type="submit" value="완료"></td>
		</tr>
		</tbody>
	</table>
</form>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/hobbyBbsWrite.js"></script>
<jsp:include page="/view/footer"/>