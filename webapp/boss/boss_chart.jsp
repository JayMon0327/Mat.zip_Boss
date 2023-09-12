<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link href="../resources/css/boss_chart.css?ver=1" rel="stylesheet">
<meta charset="UTF-8">

<title>Chart.js Test</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- <script src="../resources/js/boss_chart.js"></script>boss_chart.js파일을 추가 -->
	<link href="../resources/css/boss.css" rel="stylesheet"><!-- boss.css 파일을 추가 -->
	
<!-- 매출 차트  -->	
<script type="text/javascript">
$(document).ready(function(){
google.charts.load('current', {'packages':['line']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var storeId = '<%= session.getAttribute("store_id") %>'; // 세션에서 storeId 가져오기
  var encodedStoreId = encodeURIComponent(storeId);
  
  $.ajax({
    url: 'chart/' + encodedStoreId,
    type: 'GET',
    dataType: 'json',
    success: function(response) {
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'Day');
      data.addColumn('number', '이번달 총 매출');
      data.addColumn('number', '저번달 총 매출');
      data.addColumn('number', '2달 전 총 매출');

      
      var thisMonthData = response.thisMonthTotal;
      var lastMonthData = response.lastMonthTotal;
      var twoMonthsAgoData = response.twoMonthsAgoTotal;
      
      /* 최근7일간의 이번달과 저번달 매출액  */
      var thisMonthDataSince = response.thisMonth;
      var lastMonthDataSince = response.lastMonth;
      var twoMonthDataSince = response.twoMonth;
      /* reduce함수 */
      var thisMonthDays = thisMonthDataSince.reduce(function(total, item) { return total + item.total_amount; }, 0);
      var lastMonthDays = lastMonthDataSince.reduce(function(total, item) { return total + item.total_amount; }, 0);
      var twoMonthDays = twoMonthDataSince.reduce(function(total, item) { return total + item.total_amount; }, 0);
      var thisMonthTotalAmount = thisMonthData.reduce(function (total, item) {
		    return total + item.total_amount;
		}, 0);
	  var lastMonthTotalAmount = lastMonthData.reduce(function (total, item) {
		    return total + item.total_amount;
		}, 0);
	  var twoMonthTotalAmount = twoMonthsAgoData.reduce(function (total, item) {
		    return total + item.total_amount;
		}, 0);
      
   	 // HTML 태그에 매출액 설정
      document.getElementById('thisMonthTotal').textContent = '이번달 총매출: ' + thisMonthTotalAmount.toLocaleString('ko-KR') + '원';
      document.getElementById('lastMonthTotal').textContent = '1달전 총매출: ' + lastMonthTotalAmount.toLocaleString('ko-KR') + '원';
      document.getElementById('twoMonthTotal').textContent = '2달전 총매출: ' + twoMonthTotalAmount.toLocaleString('ko-KR') + '원';
      document.getElementById('thisMonthDays').textContent = '같은 기간 이번달 매출: ' + thisMonthDays.toLocaleString('ko-KR') + '원';
      document.getElementById('lastMonthDays').textContent = '같은 기간 1달전 매출: ' + lastMonthDays.toLocaleString('ko-KR') + '원'; 
      document.getElementById('twoMonthDays').textContent = '같은 기간 2달전 매출: ' + twoMonthDays.toLocaleString('ko-KR') + '원'; 


      // 데이터 행 추가
      for (var i = 0; i < thisMonthData.length; i++) {
        var day = i + 1;
        var thisMonthAmount = thisMonthData[i].total_amount;
        var lastMonthAmount = lastMonthData[i].total_amount;
        var twoMonthsAgoAmount = twoMonthsAgoData[i].total_amount;
        data.addRow([day, thisMonthAmount, lastMonthAmount, twoMonthsAgoAmount]);
      }

      var options = {
    		  chart: {
                  title: '<%= session.getAttribute("store_id") %>',
                  subtitle: '일별매출, 월별비교'
              },
              width: 1200,
              height: 400,
              hAxis: {
                //날짜 포맷설정 format:'D' 원하는 문자열 삽입
                 
              },
              vAxis: {
                  format: '#,###원'  // Y축 단위변경 
              },
              series: {
                  0: { color: '#0A6EFF' }, // 이번달 선 색상
                  1: { color: '#FFC81E' }, // 저번달 선 색상
                  2: { color: '#0A6E0A' }  // 2달전 선 색상
              }
          };

      var chart = new google.charts.Line(document.getElementById('linechart_material'));
      chart.draw(data, google.charts.Line.convertOptions(options));
    },
    error: function(error) {
      console.log(error);
    }
  });
}
});

</script>


<!-- 재방문율 차트 -->
	 <!-- 이번달,지난달 재방문율 차트 조회 -->
	<script type="text/javascript">
	$(document).ready(function(){
	// 신규 고객 증가율과 재방문 고객 증가율 계산 함수
	function calculateGrowth(thisMonth, lastMonth) {
	    var growth;
	    if (lastMonth === 0) {
	        growth = thisMonth > 0 ? 100 : 0;
	    } else {
	        growth = (thisMonth - lastMonth) / lastMonth * 100; 
	    }
	    return Math.floor(growth); // 소수점 이하를 잘라냄.
	}

	// 양수면 ↑ , 음수면 ↓ 표시
	function formatGrowth(growth, elementId) {
	    var element = document.getElementById(elementId);
	    if(growth >= 0) {
	        element.innerHTML = '↑<span style="color:green; font-weight:bold;">' 
	        + growth + '%</span>';
	    } else {
	        element.innerHTML = '↓<span style="color:red; font-weight:bold;">' 
	        + Math.abs(growth) + '%</span>';
	    }
	}

	// Google 차트 로딩
	google.charts.load('current', { 'packages': ['corechart'] });
	google.charts.setOnLoadCallback(drawChart);

	// 차트 그리기 함수
	function drawChart() {
	    var storeId = '<%= session.getAttribute("store_id") %>';
	    var encodedStoreId = encodeURIComponent(storeId);
	    $.ajax({
	        url: 'returnCustomerCount/' + encodedStoreId,
	        type: 'GET',
	        dataType: 'json',
	        success: function (response) {
	        	console.log(response);

	        	var thisMonthNewCustomers = response.thisMonthNew.new_customers;
	        	var thisMonthReturningCustomers = response.thisMonthReturning.returning_customers;

	        	var lastMonthNewCustomers = response.lastMonthNew.new_customers;
	        	var lastMonthReturningCustomers = response.lastMonthReturning.returning_customers;

	        	// 신규 고객 증가율, 소수점 이하 잘라내기
	            var newCustomerGrowth = calculateGrowth(thisMonthNewCustomers, lastMonthNewCustomers);
	            // 재방문 고객 증가율, 소수점 이하 잘라내기
	            var returningCustomerGrowth = calculateGrowth(thisMonthReturningCustomers, lastMonthReturningCustomers);

	            var data = google.visualization.arrayToDataTable([
	                ['Customer', 'Count'],
	                ['신규주문', thisMonthNewCustomers],
	                ['재주문', thisMonthReturningCustomers]
	            ]);

	            var options = {
	                title: '재주문율 비교',
	                pieHole: 0.3,
	                stroke: {
	                    0: { color: '#0064FF' }, // 이번달 선 색상
	                    1: { color: '#FF9100' }  // 저번달 선 색상
	                }
	            };

	            var chart = new google.visualization.PieChart(document.getElementById('reorderChart'));
	            chart.draw(data, options);

	            // HTML 태그에 데이터 설정
	            formatGrowth(returningCustomerGrowth, 'returningCustomerGrowth');
	            formatGrowth(newCustomerGrowth, 'newCustomerGrowth');

	        },
	        error: function (error) {
	            console.log(error);
	        }
	    });
	}
	});
</script>
<!-- 재방문율 -->
	 <!-- 2~5번 방문한 단골고객의 수 차트 -->
	<script type="text/javascript">
	 google.charts.load("current", {packages:['corechart']});
	    google.charts.setOnLoadCallback(drawChart);
	    function drawChart() {
	    	var storeId = '<%= session.getAttribute("store_id") %>';
	        var encodedStoreId = encodeURIComponent(storeId);
	        $.ajax({
	            url: 'orderCount/' + encodedStoreId,
	            type: 'GET',
	            dataType: 'json',
	            success: function (response) {
	            	console.log(response);
	            	var twoOrders = response.twoOrders.twoOrderCustomers;  /* 2번주문한 고객 수 */
	            	var threeOrders = response.threeOrders.threeOrderCustomers; /* 3번주문한 고객 수 */
	            	var fourOrders = response.fourOrders.fourOrderCustomers; /* 4번주문한 고객 수 */
	            	var fiveOrders = response.fiveOrders.fiveOrderCustomers; /* 5번주문한 고객 수 */
	            	
				      var data = google.visualization.arrayToDataTable([
				        ["Element", "방문횟수", { role: "style" } ],
				        ["2번", twoOrders, "#b87333"],
				        ["3번", threeOrders, "silver"],
				        ["4번", fourOrders, "gold"],
				        ["5번", fiveOrders, "color: #e5e4e2"]
				      ]);
			
				      var view = new google.visualization.DataView(data);
				      view.setColumns([0, 1,
				                       { calc: "stringify",
				                         sourceColumn: 1,
				                         type: "string",
				                         role: "annotation" },
				                       2]);
			
				      var options = {
				        title: "여러번 방문한 단골손님",
				        width: 600,
				        height: 400,
				        bar: {groupWidth: "95%"},
				        legend: { position: "none" },
				      };
				      var chart = new google.visualization.ColumnChart(document.getElementById("여러번주문차트"));
				      chart.draw(view, options);
				  },
				  error: function (error) {
		                console.log(error);
		            }
		        });
		    }
</script>
<!-- 재방문율 차트 -->
	 <!-- 이번달,저번달 신규고객, 재주문 고객 총액  -->
 <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawOrderTotalChart);

      function drawOrderTotalChart() {
        var storeId = '<%= session.getAttribute("store_id") %>';
        var encodedStoreId = encodeURIComponent(storeId);
        $.ajax({
            url: 'orderTotal/' + encodedStoreId,
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                /* 신규고객 */
                var thisMonthNewTotal = response.thisMonthNewTotal.newOrderTotalThisMonth; //이번달 신규고객 결제금액
                var lastMonthNewTotal = response.lastMonthNewTotal.newOrdersTotalLastMonth; //저번달 신규고객 결제금액 
                /* 재주문고객  */
                var thisMonthReturnTotal = response.thisMonthReturnTotal.returningOrderTotalThisMonth; //이번달 재주문 고객 결제금액
                var lastMonthReturnTotal = response.lastMonthReturnTotal.returningOrderTotalLastMonth; //저번달 재주문 고객 결제금액

                var dataOrderTotal = google.visualization.arrayToDataTable([
                	  ['고객 타입', '지난 달', '이번 달'],
                	  ['신규고객 주문금액', lastMonthNewTotal, thisMonthNewTotal],
                	  ['재주문고객 주문금액', lastMonthReturnTotal, thisMonthReturnTotal]
                	]);
                
                var formatter = new google.visualization.NumberFormat( //단위지정
                        {pattern: '#,###원'}
                    );
                    formatter.format(dataOrderTotal, 1); // Apply formatter to second column.
                    formatter.format(dataOrderTotal, 2); // Apply formatter to third column.

                var options = {
                  chart: {
                    title: '<%= session.getAttribute("store_id") %>',
                    subtitle: '신규고객, 재주문고객 금액비교',
                  },
                  bars: 'horizontal',
                  colors: ['#76A7FA', '#703593'] // 색지정
                };

                var chart = new google.charts.Bar(document.getElementById('MonthTotal'));

                chart.draw(dataOrderTotal, google.charts.Bar.convertOptions(options));
            },
            error: function (error) {
                console.log(error);
            }
        });
      }
    </script>
    <!-- 재방문율 차트 -->
	 <!-- 이번달, 저번달 재주문 회원 주문건수, 총액 -->
 <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawOrderCountChart);

      function drawOrderCountChart() {
        var storeId = '<%= session.getAttribute("store_id") %>';
        var encodedStoreId = encodeURIComponent(storeId);
        $.ajax({
            url: 'orderTotal/' + encodedStoreId,
            type: 'GET',
            dataType: 'json',
            success: function (response) {
                /* 신규고객 */
                var thisMonthNewOrder = response.thisMonthNewTotal.newOrdersThisMonth; //이번달 신규고객 주문수
                var lastMonthNewOrder = response.lastMonthNewTotal.newOrdersLastMonth; //저번달 신규고객 주문 수
                /* 재주문고객  */
                var thisMonthReturnOrder = response.thisMonthReturnTotal.returningOrdersThisMonth;//이번달 재주문 고객 주문수
                var lastMonthReturnOrder = response.lastMonthReturnTotal.returningOrdersLastMonth; //저번달 재주문 고객 주문수

                var dataOrderCount = google.visualization.arrayToDataTable([
                	  ['고객 타입', '지난 달', '이번 달'],
                	  ['신규고객 주문 수', lastMonthNewOrder, thisMonthNewOrder],
                	  ['재방문고객 주문 수', lastMonthReturnOrder, thisMonthReturnOrder]
                	]);
                var formatter = new google.visualization.NumberFormat( //단위지정
                        {pattern: '#명'}
                    );
                    formatter.format(dataOrderCount, 1); // Apply formatter to second column.
                    formatter.format(dataOrderCount, 2); // Apply formatter to third column.

                var options = {
                  chart: {
                    title: '<%= session.getAttribute("store_id") %>',
                    subtitle: '신규고객, 재주문고객 주문 수 비교',
                  },
                  bars: 'horizontal',
                  colors: ['#c2a91f', '#092073'] // 여기서 색상을 지정합니다
                };

                var chart = new google.charts.Bar(document.getElementById('MonthOrder'));

                chart.draw(dataOrderCount, google.charts.Bar.convertOptions(options));
            },
            error: function (error) {
                console.log(error);
            }
        });
      }
    </script>
    <!-- 신규고객,재방문고객 결제금액 증가율  -->
    <script type="text/javascript">

    $(document).ready(function() {
        var storeId = '<%= session.getAttribute("store_id") %>';
        var encodedStoreId = encodeURIComponent(storeId);
        $.ajax({
            url: 'orderTotal/' + encodedStoreId,
            type: 'GET',
            dataType: 'json',
            success: function (response) {
            	/* 신규고객 */
            	var thisMonthNewOrder = response.thisMonthNewTotal.newOrdersThisMonth;  /* 이번달 신규 고객 주문수 */
            	var thisMonthNewTotal = response.thisMonthNewTotal.newOrderTotalThisMonth;  /* 이번달 신규 고객 총 결제금액 */
            	var lastMonthNewOrder = response.lastMonthNewTotal.newOrdersLastMonth; /* 지난달 신규 고객 주문수 */
            	var lastMonthNewTotal = response.lastMonthNewTotal.newOrdersTotalLastMonth; /* 지난달 신규 고객 총 결제금액 */
				/* 재주문고객  */
            	var thisMonthReturnOrder = response.thisMonthReturnTotal.returningOrdersThisMonth; /* 이번달 재주문 고객 주문수 */
            	var thisMonthReturnTotal = response.thisMonthReturnTotal.returningOrderTotalThisMonth; /* 이번달 재주문 고객 총 결제금액 */
            	var lastMonthReturnOrder = response.lastMonthReturnTotal.returningOrdersLastMonth; /* 저번달 재주문 고객 주문수 */
            	var lastMonthReturnTotal = response.lastMonthReturnTotal.returningOrderTotalLastMonth; /* 저번달 재주문 고객 총 결제금액 */
            	/* 여기서부터 로직 짜야댐 */
            	/* 신규 고객 결제금액 증가율 */
				var newOrderTotalGrowth; 
				if (lastMonthNewTotal === 0) {
				    newOrderTotalGrowth = thisMonthNewTotal > 0 ? 100 : 0;
				} else {
				    newOrderTotalGrowth = (thisMonthNewTotal - lastMonthNewTotal) / lastMonthNewTotal * 100; 
				}
				
				/* 신규 고객 주문건 증가율 */
				var newOrderCountGrowth; 
				if (lastMonthNewOrder === 0) {
				    newOrderCountGrowth = thisMonthNewOrder > 0 ? 100 : 0;
				} else {
				    newOrderCountGrowth = (thisMonthNewOrder - lastMonthNewOrder) / lastMonthNewOrder * 100; 
				}
				
				/* 재주문 고객 결제 금액증가율 */
				var returnOrderTotalGrowth; 
				if (lastMonthReturnTotal === 0) {
				    returnOrderTotalGrowth = thisMonthReturnTotal > 0 ? 100 : 0;
				} else {
				    returnOrderTotalGrowth = (thisMonthReturnTotal - lastMonthReturnTotal) / lastMonthReturnTotal * 100;
				}
				console.log(returnOrderTotalGrowth);
				
				/* 재주문 고객 주문건 증가율 */
				var returnOrderCountGrowth; 
				if (lastMonthReturnOrder === 0) {
				    returnOrderCountGrowth = thisMonthReturnOrder > 0 ? 100 : 0;
				} else {
				    returnOrderCountGrowth = (thisMonthReturnOrder - lastMonthReturnOrder) / lastMonthReturnOrder * 100;
				}
				console.log(returnOrderCountGrowth);
				
				// 신규 고객 결제금액 증가율, 소수점 이하 잘라내기
	            var newOrderTotalGrowth = calculateGrowth(thisMonthNewTotal, lastMonthNewTotal);
	            // 신규 고객 주문건 증가율, 소수점 이하 잘라내기
	            var newOrderCountGrowth = calculateGrowth(thisMonthNewOrder, lastMonthNewOrder);
	            // 재주문 고객 결제 금액증가율, 소수점 이하 잘라내기
	            var returnOrderTotalGrowth = calculateGrowth(thisMonthReturnTotal, lastMonthReturnTotal);
	            // 재주문 고객 주문건 증가율, 소수점 이하 잘라내기
	            var returnOrderCountGrowth = calculateGrowth(thisMonthReturnOrder, lastMonthReturnOrder);

	            /* HTML 태그에 데이터 설정 */
	            formatGrowth(newOrderTotalGrowth, 'newOrderTotalGrowth');
	            formatGrowth(newOrderCountGrowth, 'newOrderCountGrowth');
	            formatGrowth(returnOrderTotalGrowth, 'returnOrderTotalGrowth');
	            formatGrowth(returnOrderCountGrowth, 'returnOrderCountGrowth');

	        },
	        error: function (error) {
	            console.log(error);
	        }
	    });
	});
    //소수점 자르고, 양수면 ↑ , 음수면 ↓ 표시
	function calculateGrowth(thisMonth, lastMonth) {
	    var growth;
	    if (lastMonth === 0) {
	        growth = thisMonth > 0 ? 100 : 0;
	    } else {
	        growth = (thisMonth - lastMonth) / lastMonth * 100; 
	    }
	    return Math.floor(growth); // 소수점 이하를 잘라냅니다.
	}

	function formatGrowth(growth, elementId) {
	    var element = document.getElementById(elementId);
	    if(growth >= 0) {
	        element.innerHTML = '↑<span style="color:green; font:bold;">' + growth + '%</span>';
	    } else {
	        element.innerHTML = '↓<span style="color:red; font:bold;">' + Math.abs(growth) + '%</span>';
	    }
	}

</script>
<!-- 감성분석 차트 -->
    <script>
    $(document).ready(function() {
            var storeId = '<%= session.getAttribute("store_id") %>';
            var encodedStoreId = encodeURIComponent(storeId);

            $.ajax({
                url: 'analyze/' + encodedStoreId,
                type: 'GET',
                dataType: 'json',
                contentType: 'application/json; charset=UTF-8',
                success: function(response) {
                   /*  console.log("성공시 응답받은 데이터: " + JSON.stringify(response, null, 2)); */
                    // 필드들을 표시할 <div> 요소 가져오기
                    var resultElement = $("#result");

                    // 기존 결과 초기화
                    resultElement.empty();

                    // 통계 변수 초기화
                    var totalCount = response.length;
                    var positiveCount = 0;
                    var negativeCount = 0;
                    var neutralCount = 0;

                    // response 객체를 순회하며 필드들을 <div>에 표시
                    for (var i = 0; i < response.length; i++) {
                        var review = response[i];
                        /* resultElement.append("<p>리뷰 내용: " + review.sentences[0].content + ", 감정 분석 결과: " + review.document.sentiment); */

                        // 통계 카운트 계산
                        if (review.document.sentiment === "positive") {
                            positiveCount++;
                        } else if (review.document.sentiment === "negative") {
                            negativeCount++;
                        } else {
                            neutralCount++;
                        }
                    }

                    var positivePercentage = (positiveCount / totalCount) * 100;
                    var negativePercentage = (negativeCount / totalCount) * 100;
                    var neutralPercentage = (neutralCount / totalCount) * 100;
                    
                    google.charts.load("current", {packages:["corechart"]});
                    google.charts.setOnLoadCallback(drawChart);
                    function drawChart() {
                      var data = google.visualization.arrayToDataTable([
                        ['Task', 'Hours per Day'],
                        ['좋아요', positivePercentage],
                        ['아쉬워요', negativePercentage],
                        ['나쁘지않아요', neutralPercentage]
                      ]);

                      var options = {
                        title: '<%= session.getAttribute("store_id") %>'+ ' 리뷰 감정분석',
                        is3D: true,
                      };

                      var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
                      chart.draw(data, options);
                    }
                },

                error: function(error) {
                    alert('감정 분석 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
</script>
	<!-- 감정분석 긍정탑5 부정탑5 -->
	<script>
$(document).ready(function() {
    var storeId = '<%= session.getAttribute("store_id") %>';
    var encodedStoreId = encodeURIComponent(storeId);

    $.ajax({
        url: 'analyze/' + encodedStoreId,
        type: 'GET',
        dataType: 'json',
        contentType: 'application/json; charset=UTF-8',
        success: function(response) {
            console.log("성공시 응답받은 데이터: " + JSON.stringify(response, null, 2));

            // 긍정 리뷰와 부정 리뷰를 분리하기
            var positiveReviews = response.filter(function(review) {
                return review.document.sentiment === "positive";
            });
            var negativeReviews = response.filter(function(review) {
                return review.document.sentiment === "negative";
            });

            // 각각의 리스트를 정렬하기
            positiveReviews.sort(function(a, b) {
                return b.document.confidence.positive - a.document.confidence.positive;
            });
            negativeReviews.sort(function(a, b) {
                return b.document.confidence.negative - a.document.confidence.negative;
            });

            // 최대 5개의 긍정 리뷰와 부정 리뷰 선택하기
            var maxPositiveReviews = positiveReviews.slice(0, 5);
            var maxNegativeReviews = negativeReviews.slice(0, 5);

            // 최대 긍정 점수가 높은 리뷰 표시
            var positiveReviewElement = $("#positiveReviews");
            positiveReviewElement.empty(); // 로딩될때마다 이전데이터 삭제되게 함
            for (var i = 0; i < maxPositiveReviews.length; i++) {
                var review = maxPositiveReviews[i];
                var reviewElement = $("<p>").text("리뷰 내용: " + decodeURIComponent(review.sentences[0].content) 
                		+ ", 감정 분석 결과: " + review.document.sentiment);
                positiveReviewElement.append(reviewElement);
            }

            // 최대 부정 점수가 높은 리뷰 표시
            var negativeReviewElement = $("#negativeReviews");
            negativeReviewElement.empty(); // 로딩될때마다 이전데이터 삭제되게 함 
            for (var i = 0; i < maxNegativeReviews.length; i++) {
                var review = maxNegativeReviews[i];
                var reviewElement = $("<p>").text("리뷰 내용: " + decodeURIComponent(review.sentences[0].content) 
                		+ ", 감정 분석 결과: " + review.document.sentiment);
                negativeReviewElement.append(reviewElement);
            }
        },

        error: function(error) {
            alert('감정 분석 중 오류가 발생했습니다. 다시 시도해주세요.');
        }
    });

});
</script>



</head>
<body>
<div class="container-fluid">
  <div class="row">
    <!-- 사이드바 시작 -->
    <div id="uniqueSidebar" class="col-md-3 d-flex flex-column flex-shrink-0 p-3 text-bg-light" style="width: 200px; height:300px; position: fixed; top: 116px; right: 0; left: auto;">
     <a href="/" class="d-flex align-items-center mb-md-0 me-md-auto text-black text-decoration-none">
        <svg class="bi pe-none me-2" width="40" height="32" style="fill: black;"><use xlink:href="#bi bi-shop"></use></svg>
        <span class="fs-4">매출<br>장부</span>
      </a>
      <hr style="background-color:black">
      <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
          <button id="salesChartBtn" class="btn nav-link text-black" style="font:bold;">
            <svg class="bi bi-shop me-2" width="16" height="16" style="fill: black;"><use xlink:href="#home"></use></svg>
            매출
          </button>
        </li>
        <li>
          <button id="reorderChartBtn" class="btn nav-link text-black" style="font:bold;">
            <svg class="bi pe-none me-2" width="16" height="16" style="fill: black;"><use xlink:href="#speedometer2"></use></svg>
            또슐랭
          </button>
        </li>
        <li>
          <button id="emotionChartBtn" class="btn nav-link text-black" style="font:bold;">
            <svg class="bi pe-none me-2" width="16" height="16" style="fill: black;"><use xlink:href="#table"></use></svg>
            감정분석
          </button>
          </ul>
      <hr>
    </div>
    </div>
    </div>
	
	<br>
	<div class="container">
    <!--매출차트 시작-->
    <div class="card1" style="position: relative; margin-bottom: 20px;">
        <div class="card-body">
            <h1 class="card-title"><i class="bi bi-shop"> <span style="color:#0938d6; font:bold"><%= session.getAttribute("store_id") %></span> 매출 차트</i></h1>
            <div id="linechart_material" style="width: 90%; height: 500px"></div>
            <h5 class="red-underline">저번달과 매출비교</h5>
            <div class="row">
                <div class="col-md-6 mb-2">
                    <h5>총매출</h5>
                    <div id="thisMonthTotal" class="text-bg-primary p-3"></div>  <!-- 이번달 총매출 -->
                    <div id="lastMonthTotal" class="text-bg-warning p-3"></div>  <!-- 저번달 총매출 -->
                    <div id="twoMonthTotal" class="text-bg-success p-3"></div>  <!-- 저번달 총매출 -->
                </div>
                <div class="col-md-6 mb-2">
                    <h5>최근 7일간 매출</h5>
                    <div id="thisMonthDays" class="text-bg-primary p-3"></div>  <!-- 같은기간 이번달 매출 -->
                    <div id="lastMonthDays" class="text-bg-warning p-3"></div>  <!-- 같은기간 저번달 매출 -->
                    <div id="twoMonthDays" class="text-bg-success p-3"></div>  <!-- 같은기간 저번달 매출 -->
                </div>
            </div>
        </div>
    </div>
</div>

	
	<!-- <hr style="border: dashed 10px #121d40;" align="center"> -->
	<br>
<div class="container">
    <div class="card2" style="position: relative; margin-bottom: 20px;">
        <div class="card-body">
            <h1 class="card-title" style="width:1200px; height:80px;"><i class="bi bi-shop"> <span style="color:#0938d6; font:bold"><%= session.getAttribute("store_id") %></span> 신규고객,재주문고객 금액 비교</i></h1>
            <div id="MonthTotal" style="width: 900px; height: 500px;"></div>
        </div>
    </div>
</div>

<div class="container">
    <div class="card2" style="position: relative;">
        <div class="card-body">
            <div id="MonthOrder" style="width: 900px; height: 500px;"></div>
        </div>
    </div>
</div>
	<!-- 매출차트 끝 -->
	
	<!-- 또슐랭 차트 시작 -->
<br>
<div class="container">
    <div class="row">
        <div class="card4" style="position: relative; margin-bottom: 20px;">
            <div class="card-body">
                <h1 class="card-title" style="width:1200px; height:80px;"><i class="bi bi-shop"> <span style="color:#0938d6; font:bold"><%= session.getAttribute("store_id") %></span> 또슐랭 차트</i></h1>
                <div class="row">
                    <div class="col-md-6">
                        <div id="reorderChart" style="width: 100%; height: 500px;"></div>
                    </div>
                    <div class="col-md-6">
                    	<h5>주문율 비교</h5>
                    	<ul>
                    	<li>재주문 고객 증가율 <div id="returningCustomerGrowth" class="text-bg-light p-3"></div></li>
                    	<li>신규 고객 증가율 <div id="newCustomerGrowth" class="text-bg-warning p-3"></div></li>
                    	</ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div id="여러번주문차트" style="width: 100%; height: 500px;"></div>
                    </div>
                    <div class="col-md-6">
                    	<h5>결제금액 비교</h5>
                        <ul>
	                    <li>신규고객 결제금액 증가율<div id="newOrderTotalGrowth" class="text-bg-warning p-3"></div></li>
	                    <li>재주문 고객 결제금액 증가율<div id="returnOrderTotalGrowth" class="text-bg-light p-3"></div></li>
	                    </ul>
	                    <h5>주문건 수 비교</h5>
	                    <ul>
	                    <li>신규 고객 주문 건 증가율<div id="newOrderCountGrowth" class="text-bg-warning p-3"></div></li>
	                    <li>재주문 고객 주문 건 증가율<div id="returnOrderCountGrowth" class="text-bg-light p-3"></div></li>
                		</ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
	<!-- 또슐랭차트 끝 -->
	
	<!-- 감정분석 차트 시작-->
<div class="container">
    <div class="card5" style="position: relative; margin-bottom: 20px;">
        <div class="card-body">
            <h1 class="card-title" style="width:1200px; height:80px;"><i class="bi bi-shop"> <span style="color:#0938d6; font:bold"><%= session.getAttribute("store_id") %></span> 리뷰 감정분석 차트</i></h1>
            <div id="piechart_3d" style="width: 1000px; height: 500px;"></div>
            <div id="positiveReviewsContainer" class="text-bg-light p-3">
		    <h3><span style="color: blue;">긍정</span> 리뷰 <span style="color: blue;">TOP 5</span></h3>
		    <div id="positiveReviews"></div>
			</div>
			<hr>
			<div id="negativeReviewsContainer" class="text-bg-light p-3">
		    <h3><span style="color: red;">부정</span> 리뷰 <span style="color: red;">TOP 5</span></h3>
		    <div id="negativeReviews"></div>
			</div>

        </div>
    </div>
</div>

	<script src="../resources/js/boss_scroll.js?ver=11"></script>
</body>

</html>