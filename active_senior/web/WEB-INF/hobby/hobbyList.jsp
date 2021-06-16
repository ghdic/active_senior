<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="true" %>
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
	<div style="width: 100%;position: relative;top: -45px;left: 20px">
		<% if(userID != null) { %>
		<button class="hobby-write-button" type="button" onclick="location.href='/hobbyWrite?category=<%= category %>'">글쓰기</button>
		<% } %>
	</div>
	<%
		ArrayList<HobbyBbs> list = HobbyBbsDAO.getPostList(pageNumber, 20, category);
		for(int i = 0; i < list.size(); i++) {
	%>
	<div>
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
	</div>
	<% } %>
</section>

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
<script>

    function appendSnap (el) {
        var speed = 250,
            easing = mina.easeinout;
        var s = Snap(el.querySelector('div > a > figure > svg')),
            path = s.select('path'),
            pathConfig = {
                from: path.attr('d'),
                to: el.getAttribute('data-path-hover'),
            };

        el.addEventListener('mouseenter', function () {
            path.animate({ path: pathConfig.to }, speed, easing);
        });

        el.addEventListener('mouseleave', function () {
            path.animate({ path: pathConfig.from }, speed, easing);
        });
    }

    let pageNumber = 1
    let hobbyListRequest = new XMLHttpRequest();

    window.addEventListener(
        'scroll',
        (function () {
            var height = parseInt(document.querySelector('#response-grid').style.height);
            return function () {
                if (height - window.scrollY < 1000) {
                    pageNumber += 1
                    document.querySelector('#response-grid').style.height = String(height + 1000) + 'px'
                    getHobbyList()
                }
	            height = parseInt(document.querySelector('#response-grid').style.height);

            };
        })()
    )

    function getHobbyList() {
        pageNumber += 1
        hobbyListRequest.open("post", "/hobbyContent?pageNumber=" + encodeURIComponent(pageNumber), true)
        hobbyListRequest.onreadystatechange = updateHobbyList;
        hobbyListRequest.send(null)
    }

    function updateHobbyList() {
        if(hobbyListRequest.readyState == 4 && hobbyListRequest.status == 200) {
            let objects = JSON.parse(hobbyListRequest.responseText)

            for(let obj of objects) {
                var temp = document.createElement('div')
                var str = `
			    <a href="/hobbyView?bbsID=${obj['bbsID']}&category=${obj['category']}" class="response-grid-item" data-path-hover="m 0,0 0,47.7775 c 24.580441,3.12569 55.897012,-8.199417 90,-8.199417 34.10299,0 65.41956,11.325107 90,8.199417 L 180,0 z">
		<figure>
			<img src="${obj['bbsThumbnail']}" />
			<svg viewBox="0 0 180 320" preserveAspectRatio="none">
				<path d="m 0,0 0,171.14385 c 24.580441,15.47138 55.897012,24.75772 90,24.75772 34.10299,0 65.41956,-9.28634 90,-24.75772 L 180,0 0,0 z" />
			</svg>
			<figcaption>
				<h2>${obj['bbsTitle']}</h2>
				<p>${obj['summary']}</p>
				<button>View</button>
			</figcaption>
		</figure>
	</a>
			    `
                temp.innerHTML = str
                $('#response-grid').append(temp).masonry('appended', temp, true);
                appendSnap(temp)
            }
        }
    }

</script>
<jsp:include page="view/footer"/>

