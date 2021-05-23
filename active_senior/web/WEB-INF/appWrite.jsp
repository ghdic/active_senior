<%@ page import="java.io.PrintWriter" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="고용 게시판 글쓰기"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, true);
%>

<form action="/appWriteAction.jsp" id="form" method="post" enctype="multipart/form-data">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th>고용 게시판 글쓰기</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" name="bbsTitle"></td>
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
				<input type="radio" name="bbsState" value="종료">종료
				<input type="radio" name="bbsState" value="신청·접수중">신청·접수중
				<input type="radio" name="bbsState" value="마감">마감
				<input type="radio" name="bbsState" value="공지">공지
			</td>
		</tr>
		<tr>
			<td>
				<label for="profile">썸네일:</label><input type="file" id="profile" name="bbsThumbnail" accept="image/*">
				<img src="/static/image/default/default-image.png" alt="프로필" id="profilePreview" width="100px" height="100px">
			</td>
		</tr>
		<tr>
			<td><label for="recruitmentNumber">모집 인원 :</label><input type="text" id="recruitmentNumber" name="bbsRecruitmentNumber"></td>
		</tr>
		<tr>
			<td><label for="agency">기관명 :</label><input type="text" id="agency" name="agency"></td>
		</tr>
		<tr>
			<td><label for="department">담당부서 :</label><input type="text" id="department" name="department"></td>
		</tr>
		<tr>
			<td><label>모집기간 > </label><input type="date" name="recruitStart">~<input type="date" name="recruitEnd"></td>
		</tr>
		<tr>
			<td><label>교육기간 > </label><input type="date" name="eduStart">~<input type="date" name="activeEnd"></td>
		</tr>
		<tr>
			<td><label>활동기간 > </label><input type="date" name="activeStart">~<input type="date" name="eduEnd"></td>
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
<script src="/static/profilePreview.js"></script>

<script>
    $('#summernote').summernote({
        placeholder: '',
        tabsize: 2,
        width: '80vw',
        height: '60vh',
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['fullscreen', 'codeview', 'help']]
        ]
    });



    $(document).ready(function() {
        $('#summernote').summernote({
            lang: 'ko-KR' // default: 'en-US'
        });
    });


    $(window).on('beforeunload', () => {
        return '변경사항이 저장되지 않을 수 있습니다.';
    })

    $('#form').submit(() => {
        $(window).unbind('beforeunload');
    })

    function setContent() {
        localStorage.setItem("hirebbsWrite", $('#summernote').summernote('code'))
    }

    function getContent() {
        let getValue = localStorage.getItem("hirebbsWrite")
        $('#summernote').summernote('code', '<p><br></p>')
        $('#summernote').summernote('pasteHTML', getValue)
    }


    // window.onload = (e) => {
    //     let getValue = localStorage.getItem("hirebbsWrite")
    //
    //     console.log(getValue)
    //     $('#summernote').summernote('pasteHTML', getValue)
    // }
</script>
<jsp:include page="/view/footer"/>