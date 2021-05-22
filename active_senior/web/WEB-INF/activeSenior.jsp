<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="View/navbar.jsp">
	<jsp:param name="title" value="Introduce - ActiveSenior"/>
</jsp:include>
<div id="section1" class="section">
	<div id="text">
		<div id="text1" class="drawsvg">
			<svg version="1.1" viewBox="0 0 300 200">
				<symbol id="fade-text">
					<text x="45%" y="30%" text-anchor="middle">Active</text>
					<text x="55%" y="70%" text-anchor="middle">Senior</text>
				</symbol>
				<g>
					<use class="stroke" xlink:href="#fade-text"/>
					<use class="fill" xlink:href="#fade-text"/>
				</g>
			</svg>
		</div>
	</div>
	<video id="active_senior1" class="scroll-video" src="active_senior1.mp4"></video>
</div>
<div id="section2" class="section">
	<h2 id="text2">나이는 숫자에 불과하다!</h2>
	<video id="active_senior2" class="scroll-video" src="active_senior2.mp4"></video>
</div>
<div id="section3" class="section">
	<video id="active_senior3" class="scroll-video" src="active_senior3.mp4"></video>
	<h2 id="text3">활동적인 생활을 가져보자</h2>
</div>
<div id="section4" class="section">
	<video id="active_senior4" class="scroll-video" src="active_senior4.mp4"></video>
	<h2 id="text4">문화를 즐기자</h2>
</div>
<div id="section5" class="section">
	<video id="active_senior5" class="scroll-video" src="active_senior5.mp4"></video>
	<h2 id="text5">추억을 쌓아가자</h2>
</div>
<div id="section6" class="section">
	<video id="active_senior6" class="scroll-video" src="active_senior6.mp4"></video>
	<h2 id="text6">LIVE FOR YOUR LIFE</h2>
</div>
<section id="introduce_active_senior">
	<h1 class="test">액티브 시니어란?</h1>
	<h2>액티브 시니어는 정년퇴직 이후 시간적, 경제적인 여유를 기반으로 사회활동에 적응적으로 참여하는 50~60대를 말한다. 새로운 제품이나 유행을 흡수하는데 적극적이며 가격보다 품질을 중요하게 생각하고, 생활의 안정을 추구하는 특성이 있다. 특정 세대를 통칭하는 개념이라기보다는 비슷한 연령대의 라이프스타일이라고 이해하면 쉬운데, 현재 이 액티브 시니어에 대한 높은 관심은 전 세계적인 흐름으로 자리 잡고 있다.

		이러한 관심은 TV에서도 쉽게 찾아볼 수 있다. tvN에서 방영되었던 할배들의 여행기 ‘꽃보다 할배’와 노년들의 청춘을 아름답게 담아낸 드라마 ‘디어 마이 프렌즈’가 대표적이며, 최근에는 SBS ‘불타는 청춘’에서 중년 스타들이 대활약하고 있다. 단순히 예능이나 드라마라고 여기기에는 이미 ‘액티브 시니어’가 큰 트렌드로 자리 잡았음을 느낄 수 있다.

		대표적인 인물로 패션에 관심이 있는 사람이라면 들어봤을 ‘닉 우스터’가 있다. 패션 디렉터 출신으로 많은 경력을 가진 그는 60세를 넘는 나이에도 불구하고, 다양한 패션 감각을 선보이며 젊은 사람들의 워너비 스타로 자리매김했다. 특히나 스트릿 패션의 종결자로 불리며 다양한 활동을 하고 있다. 한국 연예인으로는 가왕 ‘조용필’을 꼽을 수 있다. 2013년 발매한 앨범 ‘Hello’는 거대한 팬덤을 가진 아이돌 가수들을 제치고 1위를 석권했으며, 한국갤럽이 조사한 ‘올 한해 활동한 가수 중 가장 좋아하는 가수’에서 1위를 차지하기도 했다. 조용필은 기존에 해왔던 음악이 아닌 세련된 리듬과 힙합 아티스트 및 해외 작곡가들과의 작업 통하여, 세대 간의 장벽을 허물고 세대통합을 이루었다는 찬사를 받기도 했다.</h2>
</section>



<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.1.3/TweenMax.min.js" integrity="sha512-DkPsH9LzNzZaZjCszwKrooKwgjArJDiEjA5tTgr3YX4E6TYv93ICS8T41yFHJnnSmGpnf0Mvb5NhScYbwvhn2w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/plugins/animation.gsap.min.js" integrity="sha512-5/OHwmQzDSBS0Ous4/hlYoWLHd06/d2r7LdKZQVBXOA6PvOqWVXtdboiLTU7lQTGyVoKVTNkwi0ol4gHGlw5ww==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/plugins/debug.addIndicators.min.js" integrity="sha512-RvUydNGlqYJapy0t4AH8hDv/It+zKsv4wOQGb+iOnEfa6NnF2fzjXgRy+FDjSpMfC3sjokNUzsfYZaZ8QAwIxg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="introduce.js"></script>
<jsp:include page="View/footer.jsp"/>