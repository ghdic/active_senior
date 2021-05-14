<%@ page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="고용 게시판 글쓰기"/>
</jsp:include>
<%
	String userID = null;
	PrintWriter script = response.getWriter();
	script.println("<script>");
	if (session.getAttribute("userID") != null) {
	    userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		script.println("alert('글을 쓰려면 로그인을 해주세요!')");
		script.println("location.href = 'login.jsp'");
	}
	script.println("</script>");
%>

<form action="hireBbsWriteAction.jsp" method="post">
	<table style="border: 1px solid #dddddd">
		<thead>
			<tr>
				<th>게시판 글쓰기</th>
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
					<input type="radio" name="bbsEventState" value="0">아무것도아님
					<input type="radio" name="bbsEventState" value="1">종료
					<input type="radio" name="bbsEventState" value="2">진행중
					<input type="radio" name="bbsEventState" value="3">마감
					<input type="radio" name="bbsEventState" value="4">공지
				</td>
			</tr>
			<tr>
				<td><label for="thumbnail">썸네일:</label><input type="file" id="thumbnail" name="bbsThumbnail" accept="image/*"></td>
			</tr>
			<tr>
				<td><label for="recruitmentNumber">모집 인원 :</label><input type="text" id="recruitmentNumber" name="bbsRecruitmentNumber"></td>
			</tr>
			<tr>
				<td><label for="start">Start date:</label><input type="date" id="start" name="bbsStartDate"><label for="end">End date:</label><input type="date" id="end" name="bbsEndDate"></td>
			</tr>
			<tr>
				<td><input type="submit" value="완료"></td>
			</tr>
		</tbody>
	</table>
</form>

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
</script>
<jsp:include page="View/footer.jsp"/>