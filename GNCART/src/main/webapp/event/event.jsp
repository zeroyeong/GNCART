<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="event.EventBean"%>
<%@ page import="java.util.Vector"%>
<jsp:useBean id="eMgr" class="event.EventMgr" />
<%
request.setCharacterEncoding("UTF-8");

int totalRecord = 0; //전체레코드수
int numPerPage = 10; // 페이지당 레코드 수 
int pagePerBlock = 15; //블럭당 페이지수 

int totalPage = 0; //전체 페이지 수
int totalBlock = 0; //전체 블럭수 

int nowPage = 1; // 현재페이지
int nowBlock = 1; //현재블럭

int start = 0; //디비의 select 시작번호
int end = 10; //시작번호로 부터 가져올 select 갯수

int listSize = 0; //현재 읽어온 게시물의 수

String keyWord = "", keyField = "";
Vector<EventBean> vlist = null;

if (request.getParameter("keyWord") != null) {
	keyWord = request.getParameter("keyWord");
	keyField = request.getParameter("keyField");
}
if (request.getParameter("reload") != null) {
	if (request.getParameter("reload").equals("true")) {
		keyWord = "";
		keyField = "";
	}
}

if (request.getParameter("nowPage") != null) {
	nowPage = Integer.parseInt(request.getParameter("nowPage"));
}

start = (nowPage * numPerPage) - numPerPage;
end = numPerPage;

totalRecord = eMgr.getTotalCount(keyField, keyWord);

totalPage = (int) Math.ceil((double) totalRecord / numPerPage); //전체페이지수
nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); //현재블럭 계산

totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); //전체블럭계산
%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GNC:ART</title>
	<link rel="stylesheet" href="../css/index.css">
	<link rel="stylesheet" href="../css/event.css?qwe">
	<!--Boxicons CDN Link-->
	<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'rel='stylesheet'>
</head>

<body>
	<!-- sidebar include -->
	<jsp:include page="../index/sidebar.jsp" flush="false" />

	<section class="home-section">
		<!-- top include -->
		<jsp:include page="../index/top.jsp" flush="false" />

		<!--home-content-->
		<div class="container-fluid">
			<div class="container">
				<div class="title">
					<h3>행사사진</h3>
				</div>
				<div class="content">
					<div class="photo">
						<%
						//BoardMgr 클래스 getBoardList() 메서드 호출 
						vlist = eMgr.getBoardList(keyField, keyWord, start, end);

						listSize = vlist.size();//브라우저 화면에 보여질 게시물갯수

						if (vlist.isEmpty()) {
							out.println("등록된 게시물이 없습니다.");

						} else {
						%>
						<%
						for (int i = 0; i < numPerPage; i++) {
							if (i == listSize)
								break;
							EventBean bean = vlist.get(i);
							int EVENT_NO = bean.getEVENT_NO();
							String EVENT_TITLE = bean.getEVENT_TITLE();
							String EVENT_DATE = bean.getEVENT_DATE();
							int EVENT_HIT = bean.getEVENT_HIT();
							String MEM_NAME = bean.getMEM_NAME();
							String EVENT_SUB = bean.getEVENT_SUB();
							String EVENT_FILENAME = bean.getEVENT_FILENAME();
							String[] filenames = EVENT_FILENAME.split(",");
						%>
						<table>
							<tr>
								<th colspan="4"><%=EVENT_NO%></th>
							</tr>
							<tr>
								<td colspan="4">
								<a href="javascript:read('<%=EVENT_NO%>')">
								<img src='../filestorage/<%=filenames[0]%>' onerror="" /></a>
								</td>
							</tr>
							<tr>
								<th>날짜</th>
								<td><%=EVENT_DATE%></td>
								<th>작성자</th>
								<td><%=MEM_NAME%></td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3"><%=EVENT_TITLE%></td>
							</tr>
							<%
							} //for
							%>
						</table>
						<%
						} //if
						%>
					</div>
					<div class="bottomMenu">
						<div class="empty"></div>
						<ul class="pagination">
							<li class="active"><a href="">1</a></li>
							<li><a href="">2</a></li>
							<li><a href="">3</a></li>
						</ul>
						<div class="button">
							<a href="eventWrite.jsp"><button>글쓰기</button></a>
							<button class="del">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script src="../script/indexScript.js"></script>
	<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
	<script>
		function pageing(page) {
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}

		function block(value) {
			document.readFrm.nowPage.value =
	<%=pagePerBlock%>
		* (value - 1)
					+ 1;
			document.readFrm.submit();
		}

		function read(EVENT_NO) {
			document.readFrm.EVENT_NO.value = EVENT_NO;
			document.readFrm.action = "eventView.jsp";
			document.readFrm.submit();
		}

		function check() {
			if (document.searchFrm.keyWord.value == "") {
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
	</script>
</body>
</html>