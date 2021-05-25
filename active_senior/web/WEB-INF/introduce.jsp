<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<jsp:include page="/view/navbar">
	<jsp:param name="title" value="소개페이지"/>
</jsp:include>
<div id="introduce">
	<section class="hero">
		<div class="content">
			<div class="header">
				<h1>Active Senior</h1>
			</div>
		</div>
	</section>
	<section class="about-myself">
		<div class="person">
			<div class="container">
				<div class="container-inner">
					<img src="static/circlebackground.jpg" alt="circle" class="circle">
					<img src="static/jiwon.png" alt="이지원" class="img img1">
				</div>
			</div>
			<div class="divider"></div>
			<div class="name">이지원</div>
			<div class="title">Backend Developer</div>
		</div>
		<div class="content">
			<h2>Active Senior !</h2>
			<p>
				인간의 활동 가능 연령대와 생존기간은 높아지고 있는데, 사회가 아직 그것을 못받아 들이고 있다.
				정년 후에도 아직 일을하고 싶은 사람도 있을 것이고, 취미로 사람들과 모여 엔터테인먼트를 하고 싶은 사람도 잇을 것이다.<br>
				하지만 시니어 구직에 대한 정보도 인터넷에서 찾기도 힘들고, 정보 취합도 잘 되어있지 않다. 그리고 따로 커뮤니티 같은 것도 없었다.
				은퇴를 하고 나이를 먹으면 활동량이 자연스럽게 줄고, 움직임이 적어지고 우울증에 시달리는 사람이 많다.
				자신이 여전히 가용성 있는 사람이라는 것을 인식할 수 있게 하고, 활동적으로 할 수 있는 무언가 할일을 제공하는게 본 사이트의 취지이다.
				은퇴 후에도 이전에 일했던 기술력이 사라지는것이 아닌데도 본인의 기술을 활용하지 못한 채 일하는 시니어들도 많았다. <br><br>
				이러한 <span>액티브 시니어</span>들이 활동할 수 있는 커뮤니티 + 정보를 제공하는 사이트를 만들고자 한다.
				스마트폰을 사용하지 못하던 시니어들을 갔다. 신규 시니어들은 50대때 부터 스마트폰을 사용해왔던 세대이기 때문에 시니어 대상 플랫폼을 만들어도 충분히 참여 가능할 수 있을거라 생각한다.<br><br>
				<span>액티브 시니어</span>는 정년 퇴직 이후 시간적, 경제적인 여유를 기반으로 사회활동에 적응적으로 참여하는 50~60대를 말합니다. 새로운 제품이나 유행을 흡수하는데 적극적이며 가격보다 품질을 중요하게 생각하고,
				생활의 안정을 추구하는 특성이 있다.<br><br>
				우리 홈페이지는 이러한 <span>액티브 시니어</span>들의 정보 공유를 위한 홈페이지 입니다.</p>
		</div>
	</section>
	<section class="produce">
		<div class="content">
			<h1>Produce</h1>
			<ul>
				<li>
					<div class="produce-content hidden">
						<h2>Mainpage</h2>
						<div class="produce-time">Information</div>
						<p>추천글 & 인기글 & + a</p>
					</div>
				</li>
				<li>
					<div class="produce-content hidden">
						<h2>Navbar</h2>
						<div class="produce-time">Information</div>
						<p>Logo, 구인 & 고용 게시판, 소개, 교육, 정보알리미, 취미, 커뮤니티 등으로 이루어져 있다.</p>
					</div>
				</li>
				<li>
					<div class="produce-content hidden">
						<h2>Details</h2>
						<div class="produce-time">Information</div>
						<p>
							구인 & 고용 게시판 : 아이 돌보기, 집 청소 등 단순한 단발성 업무 또 한 가능하며 정부 사업 등 구인 정보 업로드<br>
							취미 게시판 : 취미로 같이 등산, 축구 등 사교활동 목적의 게시판<br>
							정보 공유(헤택, 행사 정보) : 시니어들이 힘들어 하는 키오스크 결제, 나라지원금 신청, 손자들이 좋아하는 물건 등 정보공유<br>
							커뮤니티 게시판 : 시니어들이 자유롭게 대화를 나눌 수 있는 게시판<br>
						</p>
					</div>
				</li>
			</ul>
		</div>
	</section>
	<section class="skills">
		<div class="content">
			<div class="development-wrapper">
				<h2 class="development-title">Development</h2>
				<ul class="skills-bar-container">
					<li>
						<div class="progressbar-title">
							<h3>HTML5</h3>
							<span class="percent" id="html-pourcent"></span>
						</div>
						<div class="bar-container" data-percent="95">
							<span class="progressbar" id="progress-html"></span>
						</div>
					</li>
					<li>
						<div class="progressbar-title">
							<h3>CSS</h3>
							<span class="percent" id="css-pourcent"></span>
						</div>
						<div class="bar-container" data-percent="85">
							<span class="progressbar" id="progress-css"></span>
						</div>
					</li>
					<li>
						<div class="progressbar-title">
							<h3>JavaScript / jQuery / Servlet</h3>
							<span class="percent" id="javascript-pourcent"></span>
						</div>
						<div class="bar-container" data-percent="80">
							<span class="progressbar" id="progress-javascript"></span>
						</div>
					</li>
					<li>
						<div class="progressbar-title">
							<h3>mysql</h3>
							<span class="percent" id="php-pourcent"></span>
						</div>
						<div class="bar-container" data-percent="65">
							<span class="progressbar" id="progress-php"></span>
						</div>
					</li>
					<li>
						<div class="progressbar-title">
							<h3>Adobe XD</h3>
							<span class="percent" id="angular-pourcent"></span>
						</div>
						<div class="bar-container" data-percent="70">
							<span class="progressbar" id="progress-angular"></span>
						</div>
					</li>
				</ul>
			</div>
			<div class="tools-knowledge-wrapper">
				<div class="tools-wrapper">
					<h2 class="title">Tools</h2>
					<ul class="tools">
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							Intellij
						</li>
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							Visual Studio Code
						</li>
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							Github
						</li>
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							mysql
						</li>
					</ul>
				</div>
				<div class="knowledge-wrapper">
					<h2 class="title">Knowledge</h2>
					<ul class="knowledge">
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							Database utilization
						</li>
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							CSS, HTML5 integration
						</li>
						<li>
							<i class="fa fa-check" aria-hidden="true"></i>
							...
						</li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	</section>
	<section class="resume">
		<div class="content">
			<a href="https://github.com/ghdic/active_senior" target="_blank">
				<div class="btn-resume">
					<i class="fa fa-download fa-2x" aria-hidden="true"></i>
					<span>Development information</span>
				</div>
			</a>
		</div>
	</section>
	<section class="portfolio">
		<div class="content">

			<h1>Activity</h1>

			<div class="Activities">

				<div class="Activity">
					<div class="Activity-image">
						<img src="static/yoga.jpg" alt="요가"/>
					</div>
					<div class="Activity-title">
						<h2>Activity #1</h2>
					</div>
					<div class="Activity-description">
						<p>혼자서 하기에는 부담이 되는 운동 중 요가를 남녀노소 구분 없이 함께 모여 나란히 요가하는 모습을 보며 건강을 챙기는 시니어들의 활동적인 모습이다. 이러한 마음이 맞는
							시니어들이 갑자기 모여지는 것이 아니기 때문에 커뮤니티를 활용한다면 더욱 수월히 진행해 나갈 수 있다.
						</p>
					</div>
				</div>
				<div class="Activity">
					<div class="Activity-image">
						<img src="static/shopping.jpg" alt="쇼핑"/>
					</div>
					<div class="Activity-title">
						<h2>Activity #2</h2>
					</div>
					<div class="Activity-description">
						<p>나이가 들었다고 쇼핑을 하지 않는다는 생각은 버려라! <span>액티브 시니어</span>는 외모에 관심이 많다. 시니어의 이러한 소비 패턴은 평생 자식을 위해 헌신했지만 이젠
							자신을 위해 쓰겠다는 자각에서 비롯된다.
						</p>
					</div>
				</div>
				<div class="Activity">
					<div class="Activity-image">
						<img src="static/Digital.jpg" alt="정보력"/>
					</div>
					<div class="Activity-title">
						<h2>Activity #3</h2>
					</div>
					<div class="Activity-description">
						<p>디지털 채널에 대한 의존도가 높진 않지만, 적극적으로 디지털 환경을 수용하는 편으로 50대 이상 <span>액티브시니어</span>의 경우 관심분야의 전문적인 정보들을
							인터넷을 통해 배우기도 하고, 모바일 결제를 선호하기도 하는 등, 30~40대 젊은 연령대보다 더 적극적으로 디지털 환경을 수용한다.
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script src="/static/introduce.js"></script>
<jsp:include page="/view/footer"/>