<%@ page import="java.io.PrintWriter" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="고용 게시판 수정"/>
	<jsp:param name="curTab" value="2"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
	int bbsID = ScriptManager.checkBbs(request, response);
	HireBbs hireBbs = HireBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, hireBbs);
	ScriptManager.userMatchCheck(response, userID, hireBbs.getUserID());
%>

<form action="/appUpdateAction?bbsID=<%= bbsID %>" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th>고용 게시판 수정</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" id="bbsTitle" name="bbsTitle" autocomplete="off" value="<%= hireBbs.getBbsTitle() %>"></td>
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
				<label for="bbsState">게시판 상태 : </label>
				<select name="bbsState" id="bbsState">
					<option value="종료">종료</option>
					<option value="신청·접수중">신청·접수중</option>
					<option value="마감">마감</option>
					<option value="공지">공지</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<label for="profile">썸네일:</label><input type="file" id="profile" name="bbsThumbnail" accept="image/*">
				<img src="<%=hireBbs.getBbsThumbnailPath() %>" alt="프로필" id="profilePreview" width="100px" height="100px">
			</td>
		</tr>
		<tr>
			<td><label for="recruitmentNumber">모집 인원 :</label><input type="text" id="recruitmentNumber" name="recruitNum" autocomplete="off" value="<%= hireBbs.getRecruitNum() %>"></td>
		</tr>
		<tr>
			<td><label for="agency">기관명 :</label><input type="text" id="agency" name="agency" autocomplete="off" value="<%= hireBbs.getAgency() %>"></td>
		</tr>
		<tr>
			<td><label for="department">담당부서 :</label><input type="text" id="department" name="department" autocomplete="off" value="<%= hireBbs.getDepartment()  %>"></td>
		</tr>
		<tr>
			<td><label>모집기간 > </label><input type="date" id="recruitStart" name="recruitStart" value="<%= hireBbs.getRecruitStartSimple() %>">~<input type="date" id="recruitEnd" name="recruitEnd" value="<%= hireBbs.getRecruitEndSimple() %>"></td>
		</tr>
		<tr>
			<td><label>교육기간 > </label><input type="date" id="eduStart" name="eduStart" value="<%= hireBbs.getEduStartSimple() %>">~<input type="date" id="eduEnd" name="eduEnd" value="<%= hireBbs.getEduEndSimple() %>"></td>
		</tr>
		<tr>
			<td><label>활동기간 > </label><input type="date" id="activeStart" name="activeStart" value="<%= hireBbs.getActiveStartSimple() %>">~<input type="date" id="activeEnd" name="activeEnd" value="<%= hireBbs.getActiveEndSimple() %>"></td>
		</tr>
		<tr>
			<td><label>파일 첨부</label><input type="file" name="files" multiple></td>
		</tr>
		<tr>
			<td><input type="submit" value="완료"></td>
		</tr>
		</tbody>
	</table>
</form>
<script>
    $('#summernote').summernote('code', '')
    $('#summernote').summernote('pasteHTML', '<%= hireBbs.getBbsContent() %>')
    $('#bbsState').val('<%= hireBbs.getBbsState() %>')
</script>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/hireBbsUpdate.js"></script>

<jsp:include page="/view/footer"/>