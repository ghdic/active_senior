<%@ page import="java.io.PrintWriter" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="고용 게시판 글쓰기"/>
	<jsp:param name="curTab" value="2"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
%>

<form action="/appWriteAction" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th class="write-title"><h2>고용 게시판 글쓰기</h2></th>
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
				<input type="button" style="margin-right: 100px;" class="blue-button" value="임시 저장" onclick="setContent()">
				<input type="button" class="blue-button" value="불러오기" onclick="getContent()">
			</td>
		</tr>
		<tr>
			<td>
				<div class="collocate-input">
					<div class="thumbnailSetting">
						<img src="/static/image/default/default-image.png" alt="프로필" id="profilePreview">
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
									<input type="text" id="recruitmentNumber" name="recruitNum" autocomplete="off">
								</div>
							</li>
							<li>
								<div>
									<label for="agency">기관명</label>
								</div>
								<div>
									<input type="text" id="agency" name="agency" autocomplete="off">
								</div>
							</li>
							<li>
								<div>
									<label for="department">담당부서</label>
								</div>
								<div>
									<input type="text" id="department" name="department" autocomplete="off">
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
									<input type="date" id="recruitStart" name="recruitStart">~<input type="date" id="recruitEnd" name="recruitEnd">
								</div>
							</li>
							<li>
								<div>
									<label>교육기간</label>
								</div>
								<div class="input-date">
									<input type="date" id="eduStart" name="eduStart">~<input type="date" id="eduEnd" name="eduEnd">
								</div>
							</li>
							<li>
								<div>
									<label>활동기간</label>
								</div>
								<div class="input-date">
									<input type="date" id="activeStart" name="activeStart">~<input type="date" id="activeEnd" name="activeEnd">
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
					<ul class="file-list"></ul>
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
<script src="/static/js/fileUpload.js"></script>
<script src="/static/js/profilePreview.js"></script>
<script src="/static/js/bbsWriteController.js"></script>
<jsp:include page="/view/footer"/>