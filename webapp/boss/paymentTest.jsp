<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://js.tosspayments.com/v1/payment"></script>

<script>
  var clientKey = 'test_ck_Wd46qopOB89oxwWnw2OVZmM75y0v'
  var tossPayments = TossPayments('test_ck_Wd46qopOB89oxwWnw2OVZmM75y0v')

  function generateOrderId() {
  // 영문 대소문자, 숫자, 특수문자 (-, _)로 이루어진 문자열
  const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
  
  let orderId = "";
  
  // 길이가 10인 주문 ID 생성
  for (let i = 0; i < 10; i++) {
    // characters 문자열에서 무작위로 문자 선택
    const randomIndex = Math.floor(Math.random() * characters.length);
    // 선택된 문자를 주문 ID에 추가
    orderId += characters.charAt(randomIndex);
  }
  
  return orderId;
}

  // 결제 요청 함수 김치찌개
  function requestPayment() {
    <% if (session.getAttribute("user_id") != null) { %>
      var userId = '<%= session.getAttribute("user_id") %>';
      var orderId = generateOrderId();
      console.log("생성된 orderId:", orderId);
      tossPayments.requestPayment('카드', {
        amount: 8900,
        orderId: orderId,
        orderName:'백채김치찌개 김치찌개',
        customerName: userId,
        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
      });
    <% } else { %>
      // 세션에 user_id가 없는 경우에 대한 처리
      console.log("세션에 user_id가 없습니다.");
      // 적절한 대체 처리 방식을 추가
    <% } %>
  }
  function requestPayment2() {
	    <% if (session.getAttribute("user_id") != null) { %>
	      var userId = '<%= session.getAttribute("user_id") %>';
	      var orderId = generateOrderId();
	      console.log("생성된 orderId:", orderId);
	      tossPayments.requestPayment('카드', {
	        amount: 12900,
	        orderId: orderId,
	        orderName:'헤비스테이크 더블함박스테이크',
	        customerName: userId,
	        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
	        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
	      });
	    <% } else { %>
	      // 세션에 user_id가 없는 경우에 대한 처리
	      console.log("세션에 user_id가 없습니다.");
	      // 적절한 대체 처리 방식을 추가
	    <% } %>
	  }
  function requestPayment3() {
	    <% if (session.getAttribute("user_id") != null) { %>
	      var userId = '<%= session.getAttribute("user_id") %>';
	      var orderId = generateOrderId();
	      console.log("생성된 orderId:", orderId);
	      tossPayments.requestPayment('카드', {
	        amount: 14900,
	        orderId: orderId,
	        orderName:'감성타코 쉬림프타코',
	        customerName: userId,
	        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
	        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
	      });
	    <% } else { %>
	      // 세션에 user_id가 없는 경우에 대한 처리
	      console.log("세션에 user_id가 없습니다.");
	      // 적절한 대체 처리 방식을 추가
	    <% } %>
	  }
  function requestPayment4() {
	    <% if (session.getAttribute("user_id") != null) { %>
	      var userId = '<%= session.getAttribute("user_id") %>';
	      var orderId = generateOrderId();
	      console.log("생성된 orderId:", orderId);
	      tossPayments.requestPayment('카드', {
	        amount: 18900,
	        orderId: orderId,
	        orderName:'구구당 홍콩파스타',
	        customerName: userId,
	        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
	        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
	      });
	    <% } else { %>
	      // 세션에 user_id가 없는 경우에 대한 처리
	      console.log("세션에 user_id가 없습니다.");
	      // 적절한 대체 처리 방식을 추가
	    <% } %>
	  }
  function requestPayment5() {
	    <% if (session.getAttribute("user_id") != null) { %>
	      var userId = '<%= session.getAttribute("user_id") %>';
	      var orderId = generateOrderId();
	      console.log("생성된 orderId:", orderId);
	      tossPayments.requestPayment('카드', {
	        amount: 12900,
	        orderId: orderId,
	        orderName:'나폴리회관 피자라자냐',
	        customerName: userId,
	        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
	        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
	      });
	    <% } else { %>
	      // 세션에 user_id가 없는 경우에 대한 처리
	      console.log("세션에 user_id가 없습니다.");
	      // 적절한 대체 처리 방식을 추가
	    <% } %>
	  }
  function requestPayment6() {
	    <% if (session.getAttribute("user_id") != null) { %>
	      var userId = '<%= session.getAttribute("user_id") %>';
	      var orderId = generateOrderId();
	      console.log("생성된 orderId:", orderId);
	      tossPayments.requestPayment('카드', {
	        amount: 10900,
	        orderId: orderId,
	        orderName:'은행골 연어초밥 결제하기',
	        customerName: userId,
	        successUrl: 'http://localhost:8887/MAT_ZIP/boss/tossSuccess',
	        failUrl: 'http://localhost:8887/MAT_ZIP/boss/tossFail', 
	      });
	    <% } else { %>
	      // 세션에 user_id가 없는 경우에 대한 처리
	      console.log("세션에 user_id가 없습니다.");
	      // 적절한 대체 처리 방식을 추가
	    <% } %>
	  }
</script>
<% if(session.getAttribute("user_id")!=null){ %>
<button class="btn btn-success" onclick="requestPayment()">백채김치찌개 김치찌개 결제하기</button>
<button class="btn btn-success" onclick="requestPayment2()">헤비스테이크 더블함박스테이크 결제하기</button>
<button class="btn btn-success" onclick="requestPayment3()">감성타코 쉬림프타코 결제하기</button>
<button class="btn btn-success" onclick="requestPayment4()">구구당 홍콩파스타 결제하기</button>
<button class="btn btn-success" onclick="requestPayment5()">나폴리회관 피자라자냐 결제하기</button>
<button class="btn btn-success" onclick="requestPayment6()">은행골 연어초밥 결제하기</button>
<%}else{ %>
<a href="boss_login.jsp"> <span class="id"><button class="btn btn-success">로그인</button></span></a>
<%} %>
</body>
</html>