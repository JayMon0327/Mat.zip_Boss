<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300&display=swap')
	;

 body {
	font-family: 'IBM Plex Sans KR', sans-serif;
}

#boardinsert {
	text-align: center;
	right: 100px;

}
.table a {
    color: black;
    text-decoration: none;
}

.table a:hover {
    text-decoration: underline;
}
</style>
<meta charset="UTF-8">
<title>맛.zip</title>
<!--페이징처리 -->
<script>
$(document).ready(function() {
  // 페이지 버튼 클릭 시
  $(document).on('click', '.page-link', function(e) {
    e.preventDefault(); // 기본 동작인 페이지 이동을 막음

    var page = $(this).attr('href').split('=')[1]; // 페이지 번호 추출
    loadPage(page); // AJAX 요청을 보내서 페이지 내용을 갱신
  });

  // 페이지를 로드하는 함수
  function loadPage(page) {
    $.ajax({
      url: "Board_list",
      method: "GET",
      data: { page: page }, // 페이지 번호를 요청 파라미터로 전달
      success: function(response) {
        $("#content").html(response); // 내용을 갱신할 공간에 응답 받은 내용 삽입
      },
      error: function(xhr, status, error) {
        console.log("Error: " + error);
      }
    });
  }
});
</script>

</head>
<body>
	<div class="container">
		<!--컨테이너  -->
		<div class="row">
			<!-- 로우설정  -->
			<br>
			<table class="table"
				style="text-align: center; border: 1px solid #dddddd">
				<tr style="background:#FFC31E;">
					<td><input type="hidden" id></td>
					<div class="col-md-4">
						<td>제목</td>
					</div>
					<div class="col-md-1">
						<td>글쓴이</td>
					</div>
					<div class="col-md-3">
						<td>작성시간</td>
					</div>
					<div class="col-md-1">
						<td>조회수</td>
					</div>
					<div class="col-md-1">
						<td>좋아요</td>
					</div>
				</tr>
				<!-- 게시판 리스트 출력되는 부분 -->
				<c:forEach items="${Board_list}" var="bag">
				  <tr>
				    <td><input type="hidden" ${bag.board_id}></td>
				    <td><a href="Board_detail?board_id=${bag.board_id}">${bag.title}
                <span class="comment-count" style="color:red">[${bag.commentCount}]</span></a></td>
				    <td>${bag.writer}</td>
				    <td><fmt:formatDate value="${bag.regdate}" pattern="yyyy-MM-dd HH:mm" /></td>
				    <td>${bag.viewscount}</td>
				    <td>${bag.likecount}</td>
				  </tr>
				</c:forEach>

			</table>
		</div>
	</div>
	<!--글쓰기기능  -->
	<%
		if (session.getAttribute("boss_id") != null) {
	%>
	<a href="boardInsert.jsp"><button type="button" class="btn btn-outline-dark" id="boardinsert">글쓰기</button></a>
	<%
		}
	%>
	<div class="container">
    <!-- 컨테이너  -->
    <div class="row">
        <!-- 페이지네이션 버튼 -->
        <nav aria-label="Page navigation" >
            <ul class="pagination justify-content-center">
                <c:forEach begin="1" end="${totalPages}" var="pageNumber" >
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a class="page-link" href="Board_list?page=${pageNumber}">${pageNumber}</a>
                    </li>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>
<br>
	
	<div class="container">
    <!--컨테이너  -->
    <div class="row">
        <!-- 로우설정  -->
        <form action="Board_search" method="get" id="search">
            <input name="keyword" type="text" size="40" placeholder="제목이나 내용을 입력해주세요">
            <button type="submit" class="btn btn-outline-dark">
                검색
            </button>
        </form>
    </div>
</div>



	
</body>