<%@ page import="controller.dao.HobbyBbsDAO" %>
<%@ page import="model.dto.HobbyBbs" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="model.dto.InfoBbs" %>
<%@ page import="controller.dao.InfoBbsDAO" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="메인페이지"/>
	<jsp:param name="curTab" value="0"/>
</jsp:include>
<!-- 메인 이미지 포스터-->
<div class="image-container">
	<div class="carousel">
		<%
			ArrayList<InfoBbs> info_list = InfoBbsDAO.getPostList(1, 6, 2);
			ArrayList<String> divId = new ArrayList<>(Arrays.asList("a", "b", "c", "d", "e", "f"));
			for(int i = 0; i < info_list.size(); i++) {
		%>
		<div id="<%= divId.get(i) %>">
			<div class="image-item"><img src="<%= info_list.get(i).getBbsThumbnailPath() %>"><span class="title-item"><%= info_list.get(i).getBbsTitle()%></span></div>

		</div>
		<%
			}
		%>
		</div>
	</div>
</div>

<!--바로가기 링크-->
<div class="site__wrapper">
	<div class="grid">
		<div class="card">
			<div class="card__image">
				<img src="https://bit.ly/3ubxo8U" alt="" />

				<div class="card__overlay card__overlay--indigo">
					<div class="card__overlay-content">
						<ul class="card__meta">
							<li>
								<a href="/infoList"><i class="fa fa-tag"></i> INFORMATION</a>
							</li>
						</ul>

						<a href="/infoList" class="card__title">정보알리미</a>

						<ul class="card__meta card__meta--last">
							<a href="/infoList">
								<button class="rink_button"><span>바로가기</span></button>
							</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="grid">
		<div class="card">
			<div class="card__image">
				<img src="https://bit.ly/3oEO5Zj" alt="" />

				<div class="card__overlay card__overlay--blue">
					<div class="card__overlay-content">
						<ul class="card__meta">
							<li>
								<a href="/hobbyList"><i class="fa fa-tag"></i> HOBBY</a>
							</li>
						</ul>

						<a href="/hobbyList" class="card__title"> 취미 </a>

						<ul class="card__meta card__meta--last">
							<!--버튼-->
							<a href="/hobbyList">
								<button class="rink_button"><span>바로가기</span></button>
							</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="grid">
		<div class="card">
			<div class="card__image">
				<img src="https://bit.ly/3u4U5vC" alt="" />

				<div class="card__overlay card__overlay--indigo">
					<div class="card__overlay-content">
						<ul class="card__meta">
							<li>
								<a href="/appList"><i class="fa fa-tag"></i> </a>JOB
							</li>
						</ul>

						<a href="/appList" class="card__title">일자리</a>

						<ul class="card__meta card__meta--last">
							<a href="/appList">
								<button class="rink_button"><span>바로가기</span></button>
							</a>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- @end site__wrapper -->

<!--slick_slider-->
<div>
	<section class="regular slider">
		<%
			ArrayList<HobbyBbs> hobby_list = HobbyBbsDAO.getPostList(1, 10);
			for(int i = 0; i < hobby_list.size(); i++) {
		%>
		<div class="image-card">
			<a href="/hobbyView?bbsID=<%=hobby_list.get(i).getBbsID()%>">
				<h2><%=hobby_list.get(i).getBbsTitle()%></h2>
				<img src="<%= hobby_list.get(i).getBbsThumbnailPath() %>"/>
			</a>
		</div>
		<% } %>
	</section>
</div>

<script>
    var carousel = $('.carousel'),
        items = $('.image-item'),
        currdeg = 0;

    let item_id = { 0: '#a', 300: '#b', 240: '#c', 180: '#d', 120: '#e', 60: '#f' };
    let url_array = ['/infoView?bbsID=<%= info_list.get(0).getBbsID() %>',
        '/infoView?bbsID=<%= info_list.get(1).getBbsID() %>',
        '/infoView?bbsID=<%= info_list.get(2).getBbsID() %>',
        '/infoView?bbsID=<%= info_list.get(3).getBbsID() %>',
        '/infoView?bbsID=<%= info_list.get(4).getBbsID() %>',
        '/infoView?bbsID=<%= info_list.get(5).getBbsID() %>']
    let curIndex = 0

    $('#b').on('click', { d: 'n' }, rotate);
    $('#a').on('click', () => {
        location.href = url_array[curIndex];
    });
    $('#f').on('click', { d: 'p' }, rotate);

    function rotate(e) {
        $(item_id[(((currdeg - 60) % 360) + 360) % 360]).off('click');
        $(item_id[((currdeg % 360) + 360) % 360]).off('click');
        $(item_id[(((currdeg + 60) % 360) + 360) % 360]).off('click');

        if (e.data.d == 'n') {
            currdeg = currdeg - 60;
            curIndex++;
        }
        if (e.data.d == 'p') {
            currdeg = currdeg + 60;
            curIndex--;
        }
        curIndex = (curIndex + 6) % 6;

        $(item_id[(((currdeg - 60) % 360) + 360) % 360]).on('click', { d: 'n' }, rotate);
        $(item_id[((currdeg % 360) + 360) % 360]).on('click', () => {
            location.href = url_array[curIndex];
        });
        $(item_id[(((currdeg + 60) % 360) + 360) % 360]).on('click', { d: 'p' }, rotate);

        carousel.css({
            '-webkit-transform': 'rotateY(' + currdeg + 'deg)',
            '-moz-transform': 'rotateY(' + currdeg + 'deg)',
            '-o-transform': 'rotateY(' + currdeg + 'deg)',
            transform: 'rotateY(' + currdeg + 'deg)',
        });
        items.css({
            '-webkit-transform': 'rotateY(' + -currdeg + 'deg)',
            '-moz-transform': 'rotateY(' + -currdeg + 'deg)',
            '-o-transform': 'rotateY(' + -currdeg + 'deg)',
            transform: 'rotateY(' + -currdeg + 'deg)',
        });

    }

</script>
<script src="static/js/slick.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.regular.slider').slick({
            infinite: true,
            slidesToShow: 3,
            slidesToScroll: 2,
            autoplay : true,
            autoplaySpeed : 5000, 		// 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
            pauseOnHover : true,
            draggable : true
        });
    });
</script>
<jsp:include page="/view/footer"/>