<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<link rel="stylesheet" href="/static/main.css">
</head>
	<body>
		<form action="/cmntyCommentAction" method="post" onsubmit="return closeWindow(this)">
			<div class="comment-edit">
				<textarea id="comment" name="comment"></textarea>
				<input type="hidden" name="method" value="update">
				<input type="hidden" id="commentID" name="commentID">
				<input type="submit" class="comment-btn">
			</div>
		</form>
		<script>
			function closeWindow(f) {
			    f.submit()
			}
		</script>
	</body>
</html>