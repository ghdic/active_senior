<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="controller.dao.HobbyBbsDAO" %>
<%@ page import="model.dto.HobbyBbs" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="취미 게시판"/>
	<jsp:param name="curTab" value="5"/>

</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int pageNumber = ScriptManager.pageNumberCheck(request);
	int category = ScriptManager.categoryCheck(request, response, false);
%>


<section id="response-grid" class="response-grid">
	<%
		ArrayList<HobbyBbs> list = HobbyBbsDAO.getPostList(pageNumber, 20, category);
		for(int i = 0; i < list.size(); i++) {
	%>
	<a href="/hobbyView?bbsID=<%= list.get(i).getBbsID() %>&category=<%= category %>" class="response-grid-item" data-path-hover="m 0,0 0,47.7775 c 24.580441,3.12569 55.897012,-8.199417 90,-8.199417 34.10299,0 65.41956,11.325107 90,8.199417 L 180,0 z">
		<figure>
			<img src="<%= list.get(i).getBbsThumbnailPath() %>" />
			<svg viewBox="0 0 180 320" preserveAspectRatio="none">
				<path d="m 0,0 0,171.14385 c 24.580441,15.47138 55.897012,24.75772 90,24.75772 34.10299,0 65.41956,-9.28634 90,-24.75772 L 180,0 0,0 z" />
			</svg>
			<figcaption>
				<h2><%= list.get(i).getBbsTitle() %></h2>
				<p><%= list.get(i).getSummarySlice(50) %></p>
				<button>View</button>
			</figcaption>
		</figure>
	</a>
	<% } %>
</section>
<div style="width: 100%;background-color: #EFEFEF;">
	<% if(userID != null) { %>
	<button type="button" onclick="location.href='/hobbyWrite?category=<%= category %>'">글쓰기</button>
	<% } %>
	<br>
	<% if (pageNumber > 1) { %>
	<button onclick="location.href='/hobbyList?pageNumber=<%= pageNumber - 1 %>&category=<%= category %>'">이전</button>
	<% } if (HobbyBbsDAO.nextPage(pageNumber, 20, category)) { %>
	<button onclick="location.href='/hobbyList?pageNumber=<%= pageNumber + 1 %>&category=<%= category %>'">다음</button>
	<% } %>
</div>

<script src="/static/js/snap-svg.js"></script>
<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.imagesloaded/4.1.4/imagesloaded.pkgd.min.js"
		integrity="sha512-S5PZ9GxJZO16tT9r3WJp/Safn31eu8uWrzglMahDT4dsmgqWonRY9grk3j+3tfuPr9WJNsfooOR7Gi7HL5W2jw=="
		crossorigin="anonymous"
		referrerpolicy="no-referrer"
></script>
<script
		src="https://cdnjs.cloudflare.com/ajax/libs/masonry/4.2.2/masonry.pkgd.min.js"
		integrity="sha512-JRlcvSZAXT8+5SQQAvklXGJuxXTouyq8oIMaYERZQasB8SBDHZaUbeASsJWpk0UUrf89DP3/aefPPrlMR1h1yQ=="
		crossorigin="anonymous"
		referrerpolicy="no-referrer"
></script>
<script
		src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.1.3/TweenMax.min.js"
		integrity="sha512-DkPsH9LzNzZaZjCszwKrooKwgjArJDiEjA5tTgr3YX4E6TYv93ICS8T41yFHJnnSmGpnf0Mvb5NhScYbwvhn2w=="
		crossorigin="anonymous"
		referrerpolicy="no-referrer"
></script>
<script src="/static/js/responseCard.js"></script>
<jsp:include page="view/footer"/>

