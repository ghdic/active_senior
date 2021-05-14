<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="model.dto.HireBbs" %>
<%@ page import="controller.dao.HireBbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.DateManger" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="일자리 지원"/>
</jsp:include>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
	    userID = (String) session.getAttribute("userID");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
	    pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<table style="border: 1px solid #dddddd; text-align: center">
	<thead>
		<tr>
			<th>섬네일</th>
			<th>제목</th>
			<th>운영기관</th>
			<th>문의처</th>
			<th>모집인원</th>
			<th>모집기간</th>
			<th>공고모집상태</th>
		</tr>
	</thead>
	<tbody>
		<%
			HireBbsDAO bbsDAO = new HireBbsDAO();
			DateManger dateManger = new DateManger();
			ArrayList<HireBbs> list = bbsDAO.getPostList(pageNumber, 10);
			for(int i = 0; i < list.size(); i++) {
		%>

			<tr>
				<td><%= list.get(i).getBbsThumbnail() %></td>
				<td><a href="/hireBbsView.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
				<td><%= list.get(i).getBbsInstitution() %></td>
				<td><%= list.get(i).getBbsContactInformation() %></td>
				<td><%= list.get(i).getBbsRecruitmentNumber() %></td>
				<td><%= dateManger.getSimpleDate(list.get(i).getBbsStartDate()) + " ~ " + dateManger.getSimpleDate(list.get(i).getBbsEndDate()) %></td>
				<td><%= list.get(i).getBbsEventState() %></td>
			</tr>

		<%
			}
		%>
	</tbody>
</table>
<button type="button" onclick="location.href='hireBbsWrite.jsp' ">글쓰기</button>
<jsp:include page="View/footer.jsp"/>