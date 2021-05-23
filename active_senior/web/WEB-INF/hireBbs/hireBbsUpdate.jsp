<%@ page import="java.io.PrintWriter" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="controller.tool.DateManger" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="고용 게시판 수정하기"/>
</jsp:include>
<%
	String userID = null;
	PrintWriter script = response.getWriter();

	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}

	if (userID == null) {
		script.println("<script>");
		script.println("alert('글을 수정하려면 로그인을 해주세요!')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
	}

	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'hireBbs.jsp ");
	}
	HireBbs hireBbs = new HireBbsDAO().getPost(bbsID);
	if (!userID.equals(hireBbs.getUserID())) {
		script.println("alert('권한이 없습니다')");
		script.println("location.href = 'hireBbs.jsp'");
	}
	script.println("</script>");
%>

<form action="hireBbsUpdateAction.jsp" method="post">
	<table style="border: 1px solid #dddddd">
		<thead>
		<tr>
			<th>게시판 글쓰기</th>
		</tr>
		</thead>
		<tbody>
		<tr>
			<td><input type="text " placeholder="글 제목" name="bbsTitle" value="<%= hireBbs.getBbsTitle() %>"></td>
		</tr>
		<tr>
			<td><textarea id="summernote" name="bbsContent"></textarea></td>
		</tr>
		<tr>
			<td>
<%--				셀렉트로 고치기--%>
				<input type="radio" name="bbsEventState" value="0" <%= hireBbs.getBbsEventState() == 0 ? "checked":"" %>>아무것도아님
				<input type="radio" name="bbsEventState" value="1" <%= hireBbs.getBbsEventState() == 1 ? "checked":"" %>>종료
				<input type="radio" name="bbsEventState" value="2" <%= hireBbs.getBbsEventState() == 2 ? "checked":"" %>>진행중
				<input type="radio" name="bbsEventState" value="3" <%= hireBbs.getBbsEventState() == 3 ? "checked":"" %>>마감
				<input type="radio" name="bbsEventState" value="4" <%= hireBbs.getBbsEventState() == 4 ? "checked":"" %>>공지
			</td>
		</tr>
		<tr>
			<td><label for="thumbnail">썸네일:</label><input type="file" id="thumbnail" name="bbsThumbnail" accept="image/*"></td>
		</tr>
		<tr>
			<td><label for="recruitmentNumber">모집 인원 :</label><input type="text" id="recruitmentNumber" name="bbsRecruitmentNumber" value="<%= hireBbs.getBbsRecruitmentNumber() %>"></td>
		</tr>
		<tr>
			<td><label for="start">Start date:</label><input type="date" id="start" name="bbsStartDate" value="<%= DateManger.getDate(hireBbs.getBbsStartDate()) %>"><label for="end">End date:</label><input type="date" id="end" name="bbsEndDate" value="<%= DateManger.getDate(hireBbs.getBbsEndDate()) %>"></td>
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

    $('#summernote').summernote('pasteHTML', '<%= hireBbs.getBbsContent() %>')

    $(document).ready(function() {
        $('#summernote').summernote({
            lang: 'ko-KR' // default: 'en-US'
        });
    });
</script>
<jsp:include page="View/footer.jsp"/>