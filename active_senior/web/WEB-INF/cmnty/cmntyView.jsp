<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="controller.tool.ScriptManager" %>
<%@ page import="model.dto.CommunityBbs" %>
<%@ page import="controller.dao.CommunityBbsDAO" %>
<%@ page import="model.dto.User" %>
<%@ page import="controller.dao.UserDAO" %>
<%@ page import="controller.dao.RecommendTableDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.dao.CommunityCommentDAO" %>
<%@ page import="model.dto.CommunityComment" %>
<jsp:include page="view/navbar">
	<jsp:param name="title" value="게시글"/>
	<jsp:param name="curTab" value="6"/>
</jsp:include>
<%
	String userID = ScriptManager.loginCheck(session, response, false);
	int bbsID = ScriptManager.checkBbs(request, response);
	CommunityBbs cmntyBbs = CommunityBbsDAO.getPost(bbsID);
	ScriptManager.checkPost(response, cmntyBbs);
	CommunityBbsDAO.viewIncrease(bbsID);
	User bbs_user = UserDAO.getUser(cmntyBbs.getUserID());
	User user = UserDAO.getUser(userID);
	ArrayList<String> recommendTable = RecommendTableDAO.getRecommends(bbsID);
%>


<div class="board">
	<h3 class="bbs-view-title"><%= cmntyBbs.getBbsTitle() %></h3>
	<ul class="info">
		<li>
			<img src="<%= bbs_user.getUserProfilePath() %>" alt="thumbnail" width="50" height="50">
		</li>
		<li>
			<i class="fas fa-user"></i><span>작성자: <%= cmntyBbs.getUserName() %></span>
		</li>
		<li>
			<i class="far fa-eye"></i></li><span>조회수: <%= cmntyBbs.getBbsView() + 1 %></span>
		<li>
			<i class="far fa-thumbs-up"></i><span>추천수: <%= recommendTable.size() %></span>
		</li>
		<li style="float:right;">
			<i class="far fa-clock"></i><span><%= cmntyBbs.getBbsDateSimple() %></span>
		</li>
		<% if(userID != null && userID.equals(cmntyBbs.getUserID())) { %>
		<li>
			<a href="/cmntyUpdate?bbsID=<%= bbsID %>" class="edit-button"><span>수정</span></a>
			<a href="/cmntyDeleteAction?bbsID=<%= bbsID %>" class="remove-button" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
		</li>
		<% } %>
	</ul>

	<div class="bbs-main-content">
		<%
			out.print(cmntyBbs.getBbsContent());
		%>
	</div>
	<div class="recommend-section">
		<% if (userID == null) { %>
		<a href="javascript:location.href = '/login'" onclick="return confirm('추천을 하시려면 로그인을 먼저해주세요!')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } else if (recommendTable.contains(userID)) {  %>
		<a href="javascript:recommend(false)" style="box-shadow: 10px 5px 5px cornflowerblue" onclick="return confirm('추천을 취소하시겠습니까??')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } else { %>
		<a href="javascript:recommend(true)" onclick="return confirm('이 게시글을 추천하시겠습니까?')"><span><%= recommendTable.size() %></span><br><span><i class="far fa-thumbs-up"></i></span></a>
		<% } %>
	</div>

	<%
		ArrayList<String> realFileNameArrayList = cmntyBbs.getRealFileNameArrayList();
		ArrayList<String> originalFileNameArrayList = cmntyBbs.getOriginalFileNameArrayList();
		if(realFileNameArrayList.size() != 0) {
	%>
	<div class="file-downloader">
		<div class="file-uploader__message-area">첨부파일 다운로드</div>
		<ul class="file-list">
			<%
				for(int i = 0; i < realFileNameArrayList.size(); i++) {
			%>
			<li><span class="file-list__name"><%= originalFileNameArrayList.get(i) %></span><a href="<%= realFileNameArrayList.get(i) %>" class="download-button" download="<%= originalFileNameArrayList.get(i) %>"></a></li>
			<%
				}
			%>
		</ul>
	</div>
	<% } %>

	<div>
		<p class="keywords">
			키워드: <span><%= cmntyBbs.getKeyword() %></span>
		</p>
		<p class="tags">
			태그: <span><%= cmntyBbs.getTag() %></span>
		</p>
	</div>

	<div class="comment_view">
		<strong>[댓글: 총 <%= CommunityCommentDAO.getCommentCount(bbsID) %>개]</strong>
		<table class="comment_table">
			<tbody>
			<%
				ArrayList<CommunityComment> comments = CommunityCommentDAO.getComments(bbsID);
				for(int i = 0; i < comments.size(); i++) {
			%>
			<tr>
				<td class="username">
					<% if(comments.get(i).getParentID() != 0) { %>
					<div class="reply"><i class="fas fa-reply fa-rotate-180"></i></div>
					<% } %>
					<div class="nickname"><%= comments.get(i).getUserName() %><br>(<%= comments.get(i).getUserID() %>)</div>
				</td>
				<td class="comment">
					<div class="text_wrapper" commentID="<%= comments.get(i).getCommentID() %>">
						<span><%= comments.get(i).getComment() %></span>
						<button class="btn-reply"><i class="fas fa-reply fa-rotate-180"></i>답글</button>
						<% if(user != null && user.getUserID().equals(comments.get(i).getUserID())) { %>
						<button class="btn-edit" onclick="edit_comment(this)"><i class="fas fa-edit"></i>수정</button>
						<button class="btn-delete" onclick="delete_comment(this)"><i class="fas fa-trash"></i>삭제</button>
						<% } %>
						<div class="comment-input disable" commentID="<%= comments.get(i).getCommentID() %>" parentID="<%= comments.get(i).getParentID() != 0 ? comments.get(i).getParentID() : comments.get(i).getCommentID() %>">
							<textarea name="comment_input"></textarea>
							<a href="javascript:void(0)" onclick="create_comment(this)" class="comment-btn">등록</a>
						</div>
					</div>
				</td>
			</tr>
			<% } %>
			<tr>
				<td class="comment-input" colspan="2" parentID="0">
					<textarea name="comment_input"></textarea>
					<a href="javascript:void(0)" onclick="create_comment(this)" class="comment-btn">등록</a>
				</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>

<script>
    function recommend(check) {
        let form = document.createElement("form")
        form.method = "post"
        if (check === true) {
            form.action = '/setRecommend'
        } else {
            form.action = '/cancelRecommend'
        }

        let input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "bbsID")
        input.setAttribute("value", "<%= bbsID %>")
        form.appendChild(input)

        input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "userID")
        input.setAttribute("value", "<%= userID %>")
        form.appendChild(input)

        document.body.appendChild(form)
        form.submit()
    }

    $(".btn-reply").on('click', function () {
	    $(this).siblings('.comment-input').toggleClass('disable')
    })

    function create_comment(registerBox) {
        let form = document.createElement("form")
        form.method = "post"
        form.action = '/cmntyCommentAction'

        let input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "method")
        input.setAttribute("value", "create")
        form.appendChild(input)

        input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "bbsID")
        input.setAttribute("value", "<%= bbsID %>")
        form.appendChild(input)

        input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "parentID")
        input.setAttribute("value", registerBox.parentNode.getAttribute("parentID"))
        form.appendChild(input)

        input = document.createElement("input")
        input.setAttribute("type", "hidden")
        input.setAttribute("name", "comment")
        input.setAttribute("value", registerBox.parentNode.querySelector("textarea").value)
        form.appendChild(input)

        document.body.appendChild(form)
        form.submit()
    }

    function edit_comment(editBtn) {
        let commentID = editBtn.parentNode.getAttribute("commentID")
	    let comment = editBtn.parentNode.querySelector("span").innerText
	    window.name = "댓글 수정"
	    let openWin = window.open("/editComment", 'childForm', "width=570px, height=350px, resizable = no, scrollbars = no")
	    openWin.onload = () => {
            openWin.document.getElementById("commentID").value = commentID
            openWin.document.getElementById("comment").value = comment
        }
    }

    function delete_comment(deleteBtn) {
        if(confirm("정말로 댓글을 삭제하시겠습니까?")) {
            let form = document.createElement("form")
            form.method = "post"
            form.action = '/cmntyCommentAction'

            let input = document.createElement("input")
            input.setAttribute("type", "hidden")
            input.setAttribute("name", "method")
            input.setAttribute("value", "delete")
            form.appendChild(input)

            input = document.createElement("input")
            input.setAttribute("type", "hidden")
            input.setAttribute("name", "commentID")
            input.setAttribute("value", deleteBtn.parentNode.getAttribute("commentID"))
            form.appendChild(input)

            document.body.appendChild(form)
            form.submit()
        }
    }

</script>
<jsp:include page="view/footer"/>