<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.EduBbsDAO" %>
<%@ page import="model.dto.EduBbs" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="교육 게시판 업데이트"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	int bbsID = ScriptManager.checkBbs(request, response);
	EduBbs eduBbs = EduBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, eduBbs);
	ScriptManager.userMatchCheck(response, userID, eduBbs.getUserID());
%>

<form action="/eduUpdateAction?bbsID=<%= bbsID %>" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th>고용 게시판 수정</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" id="bbsTitle" name="bbsTitle" autocomplete="off" value="<%= eduBbs.getBbsTitle() %>"></td>
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
				<img src="<%=eduBbs.getBbsThumbnailPath() %>" alt="프로필" id="profilePreview" width="100px" height="100px">
			</td>
		</tr>

		<tr>
			<td><input type="submit" value="완료"></td>
		</tr>
		</tbody>
	</table>
</form>
<script>
    $('#summernote').summernote('code', '')
    $('#summernote').summernote('pasteHTML', '<%= eduBbs.getBbsContent() %>')
</script>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/eduBbsUpdate.js"></script>

<jsp:include page="/view/footer"/>