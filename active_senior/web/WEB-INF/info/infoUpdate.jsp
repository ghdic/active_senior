<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.InfoBbsDAO" %>
<%@ page import="model.dto.InfoBbs" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="공지&정보 게시판 수정"/>
	<jsp:param name="curTab" value="4"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	int bbsID = ScriptManager.checkBbs(request, response);
	InfoBbs infoBbs = InfoBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, infoBbs);
	ScriptManager.userMatchCheck(response, userID, infoBbs.getUserID());
%>
<form action="/infoUpdateAction?bbsID=<%= bbsID %>" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th class="write-title"><h2>커뮤니티 게시판 업데이트</h2></th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" id="bbsTitle" name="bbsTitle" value="<%= infoBbs.getBbsTitle() %>" autocomplete="off"></td>
		</tr>
		<tr>
			<td><textarea id="summernote" name="bbsContent"></textarea></td>
		</tr>
		<tr>
			<td>
				<input type="button" style="margin-right: 100px;" class="blue-button" value="임시 저장" onclick="setContent()">
				<input type="button" class="blue-button" value="불러오기" onclick="getContent()">
			</td>
		</tr>
		<tr>
			<td>
				<div class="collocate-input">
					<div class="thumbnailSetting">
						<img src="<%=infoBbs.getBbsThumbnailPath() %>" alt="프로필" id="profilePreview">
						<div><label for="profile">썸네일</label></div><div><input type="file" id="profile" name="bbsThumbnail" accept="image/*"></div>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td><input type="submit" class="submit-btn" value="완료"></td>
		</tr>
		</tbody>
	</table>
</form>

<script>
    window.onload = function () {
        $('#summernote').summernote('code', '')
        $('#summernote').summernote('pasteHTML', '<%= infoBbs.getBbsContent() %>')
    }
</script>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/bbsWriteController.js"></script>
<jsp:include page="/view/footer"/>