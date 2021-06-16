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
			<th class="write-title"><h2>고용 게시판 글쓰기</h2></th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" id="bbsTitle" name="bbsTitle" value="<%= hireBbs.getBbsTitle() %>" autocomplete="off"></td>
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
						<img src="<%=hireBbs.getBbsThumbnailPath() %>" alt="프로필" id="profilePreview">
						<div><label for="profile">썸네일</label></div><div><input type="file" id="profile" name="bbsThumbnail" accept="image/*"></div>
					</div>
					<div class="info-input">
						<ul>
							<li>
								<div>
									<label for="bbsState">게시판 상태</label>
								</div>
								<div>
									<select name="bbsState" id="bbsState">
										<option value="종료">종료</option>
										<option value="신청·접수중">신청·접수중</option>
										<option value="마감">마감</option>
										<option value="공지">공지</option>
									</select>
								</div>
							</li>
							<li>
								<div>
									<label for="recruitmentNumber">모집 인원</label>
								</div>
								<div>
									<input type="text" id="recruitmentNumber" name="recruitNum" value="<%= hireBbs.getRecruitNum() %>" autocomplete="off">
								</div>
							</li>
							<li>
								<div>
									<label for="agency">기관명</label>
								</div>
								<div>
									<input type="text" id="agency" name="agency" value="<%= hireBbs.getAgency() %>" autocomplete="off">
								</div>
							</li>
							<li>
								<div>
									<label for="department">담당부서</label>
								</div>
								<div>
									<input type="text" id="department" name="department" value="<%= hireBbs.getDepartment() %>" autocomplete="off">
								</div>
							</li>
						</ul>
					</div>
					<div class="info-input">
						<ul>
							<li>
								<div>
									<label>모집기간</label>
								</div>
								<div class="input-date">
									<input type="date" id="recruitStart" value="<%= hireBbs.getRecruitStartSimple() %>" name="recruitStart">~<input type="date" id="recruitEnd" value="<%= hireBbs.getRecruitEndSimple() %>" name="recruitEnd">
								</div>
							</li>
							<li>
								<div>
									<label>교육기간</label>
								</div>
								<div class="input-date">
									<input type="date" id="eduStart" value="<%= hireBbs.getEduStartSimple() %>" name="eduStart">~<input type="date" id="eduEnd" value="<%= hireBbs.getEduEndSimple() %>" name="eduEnd">
								</div>
							</li>
							<li>
								<div>
									<label>활동기간</label>
								</div>
								<div class="input-date">
									<input type="date" id="activeStart" value="<%= hireBbs.getActiveStartSimple() %>" name="activeStart">~<input type="date" id="activeEnd" value="<%= hireBbs.getActiveEndSimple() %>" name="activeEnd">
								</div>
							</li>
						</ul>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td>
				<div class="file-uploader">
					<div class="file-uploader__message-area">파일 리스트:</div>
					<ul class="file-list">
					</ul>
					<div class="hidden-inputs hidden"></div>
					<div class="file-chooser">
						<input class="file-chooser__input" type="file">
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
    $('#summernote').summernote('code', '')
    $('#summernote').summernote('pasteHTML', '<%= hireBbs.getBbsContent() %>')
    $('#bbsState').val('<%= hireBbs.getBbsState() %>')
</script>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/hireBbsUpdate.js"></script>

<jsp:include page="/view/footer"/>