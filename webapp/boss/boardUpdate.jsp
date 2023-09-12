<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!--JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.mat.zip.boss.model.BoardVO"%>
<%@page import="com.mat.zip.boss.model.ComVO"%>
<%@page import="com.mat.zip.boss.model.Boss_memberVO"%>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="../resources/images/favicon.png" type="">

  <title>Mat.zip </title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="../resources/css/bootstrap.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <!-- nice select  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
  <!-- font awesome style -->
  <link href="../resources/css/font-awesome.min.css" rel="stylesheet" />

  <!-- Custom styles for this template -->
  <link href="../resources/css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="../resources/css/responsive.css" rel="stylesheet" />
  <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
  <link href="../resources/css/boss.css?ver=1" rel="stylesheet">
  <!-- boss.css 파일을 추가 -->
  <style>@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@300&display=swap'); </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  <!-- 댓글작성관련 -->
<script type="text/javascript">
	$(function() {
		$('#b1').click(function() {
			content = $('#com').val()
			writer = "${user_id}"
			/* regdate = '${bag.regdate}' */
			$.ajax({
				url : "Board_insertcom",
				data : {
					board_id : '${bag.board_id}',
					content : content,
					writer : writer

				},
				success : function(x) {
					$('#result').load(location.href + ' #result')
					/* $('#result').empty();
					$('#result').append(x); */
					/* location.reload(); */
					/* $('#result').append(
						"- " + content + ", " + writer + "<br>") */
				},
				error : function() {
					alert('computer요청 실패!')
				}//error
			})//ajax
		})//b1
	})//$
</script>
<!-- 댓글수정,삭제관련 -->
<!-- <script type="text/javascript">
$(function() {
    // 댓글 메뉴 열기/닫기
    $(document).on('click', '.menu-icon', function() {
        var menuOptions = $(this).closest('tr').find('.menu-options');
        menuOptions.toggle();
    });

    // 수정 버튼 클릭 시
    $(document).on('click', '.edit-option', function() {
        var commentContent = $(this).closest('tr').find('.comment-content');
        var editInput = $(this).closest('tr').find('.edit-comment');

        commentContent.hide();
        editInput.val(commentContent.text()).show().focus();
    });

    // 수정된 내용 저장 버튼 클릭 시
    $(document).on('focusout', '.edit-comment', function() {
        var commentContent = $(this).closest('tr').find('.comment-content');
        var editInput = $(this).closest('tr').find('.edit-comment');
        var commentId = $(this).closest('tr').data('comment-id');
        var updatedContent = editInput.val();

        // AJAX 요청을 보내서 수정된 내용 저장 및 적용
        $.ajax({
            url: 'Com_update',
            method: 'POST',
            data: {
                reply_id: commentId,
                content: updatedContent
            },
            success: function(response) {
                commentContent.text(updatedContent).show();
                editInput.hide();
            },
            error: function() {
                alert('Failed to update comment!');
            }
        });
    });

    // 삭제 옵션 클릭 시
    $(document).on('click', '.delete-option', function() {
        var commentId = $(this).closest('tr').data('comment-id');

        // AJAX 요청을 보내서 댓글 삭제
        $.ajax({
            url: 'Com_delete',
            method: 'POST',
            data: {
                reply_id: commentId
            },
            success: function(response) {
                // 삭제된 댓글 표시를 갱신하는 등의 작업 수행
                location.reload();
            },
            error: function() {
                alert('Failed to delete comment!');
            }
        });
    });
});
</script> -->

<!-- 좋아요 -->
<script>
$(document).ready(function(){
    $('.like-form').on('submit', function(event){
        event.preventDefault();
        var form = $(this);
        var board_id = form.find('input[name="board_id"]').val();
        var likeButton = form.find('.like-button');
        var heartIcon = likeButton.find('i.bi-heart-fill, i.bi-heart');
        var likeText = likeButton.find('span');

        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: {
                board_id: board_id
            },
            success: function(response) {
                console.log(response);
                console.log(heartIcon);
                // '좋아요' 카운트를 업데이트
                likeText.text('좋아요 ' + response.count);
                // '좋아요' 상태를 업데이트
                if (response.isLiked) {
                    heartIcon.removeClass('bi-heart').addClass('bi-heart-fill');
                } else {
                    heartIcon.removeClass('bi-heart-fill').addClass('bi-heart');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("Error: " + textStatus + ", " + errorThrown);
            }
        });
    });
});

</script>

</head>

<body class="sub_page">

  <div class="hero_area">
    <div class="bg-box">
      <img src="../resources/images/hero-bg.jpg" alt="">
    </div>
    <!-- header 섹션 시작 -->
    <header class="header_section" style="z-index: 100;">
      <div class="container">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
          <a class="navbar-brand" href="../index.jsp">
            <span>
              Mat.zip
            </span>
          </a>

         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav  mx-auto ">
              <li class="nav-item active">
              	
                <a class="nav-link" href="../index.jsp">Home </a><!-- <span class="sr-only">(current)</span> 원래 a태그 안에있던것 -->
              </li>
              <li class="nav-item">
                <a class="nav-link" href="../boss/board_index.jsp">사장님 커뮤니티</a>
              </li>
              
              <li class="nav-item">
                <a class="nav-link" href="../board/boardIndex.jsp">회원 커뮤니티</a>
              </li>
              
            </ul>
            <div class="user_option">
                  <g>
                    <g>
                      <path d="M345.6,338.862c-29.184,0-53.248,23.552-53.248,53.248c0,29.184,23.552,53.248,53.248,53.248
                   c29.184,0,53.248-23.552,53.248-53.248C398.336,362.926,374.784,338.862,345.6,338.862z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M439.296,84.91c-1.024,0-2.56-0.512-4.096-0.512H112.64l-5.12-34.304C104.448,27.566,84.992,10.67,61.952,10.67H20.48
                   C9.216,10.67,0,19.886,0,31.15c0,11.264,9.216,20.48,20.48,20.48h41.472c2.56,0,4.608,2.048,5.12,4.608l31.744,216.064
                   c4.096,27.136,27.648,47.616,55.296,47.616h212.992c26.624,0,49.664-18.944,55.296-45.056l33.28-166.4
                   C457.728,97.71,450.56,86.958,439.296,84.91z" />
                    </g>
                  </g>
                  <g>
                    <g>
                      <path d="M215.04,389.55c-1.024-28.16-24.576-50.688-52.736-50.688c-29.696,1.536-52.224,26.112-51.2,55.296
                   c1.024,28.16,24.064,50.688,52.224,50.688h1.024C193.536,443.31,216.576,418.734,215.04,389.55z" />
                    </g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  <g>
                  </g>
                  
          <!--캘린더 들어갈 위치 -->
          <div style="width: 50px; height: 50px; ">
	          <a href="../resources/images/c.png" data-title="오늘의 캘린더" data-lightbox="example-set" style="margin: 0px 0px;">
	          	<img src="../resources/images/cal.png" style="width: 50px">
	          </a>
          </div>
          
        <!-- 로그인했을 시에 마이페이지 버튼 표시 -->
		<div class="client_section">
		  <div class="box" style="margin: 10px;">
		    <div class="user-img-box">
		      <% if (session.getAttribute("user_id") == null) { %>
		        <a href="../mz_member/signUp">
		          <img src="../resources/images/basic.png" alt="" class="box-img" style="width: 50px;">
		        </a>
		      <% } %>
		      <% if (session.getAttribute("user_id") != null) { %>
		        <a href="../mz_member/myPage">
		          <img src="../resources/images/basic.png" alt="" class="box-img" style="width: 50px;">
		        </a>
		      <% } %>
		    </div>
		  </div>
		</div>
		<% if (session.getAttribute("user_id") == null) { %>
		  <a href="../mz_member/login" class="order_online">
		    LOGIN
		  </a>
		<% } %>
		<% if (session.getAttribute("user_id") != null) { %>
		  <a href="../mz_member/logout" class="order_online">
		    LOGOUT
		  </a>
		<% } %>
            	
            </div>
          </div>
        </nav>
      </div>
    </header>
    <!-- 헤더 섹션 종료 -->
  </div>

	<br>
	<div class="container">
		<!--컨테이너  -->
		<div class="row" class="col-md-9">
			<!-- 로우설정  -->
			<h3>
				<strong><em><span
						class="badge rounded-pill text-bg-warning p-3">글 수정</span></em></strong>
			</h3>
		</div>
		<br>
		<div class="row" class="col-md-9">
			<!-- 로우설정  -->
			<form action="Board_update" method="post">
			<input name="board_id" value= "${sessionScope.board_id}"
			type="hidden" style="width: 600px;"><br>
			<input name="title" value="${sessionScope.title}" placeholder="제목을 입력해주세요"
				style="width: 600px;"><br> <input name="content"
				value="${sessionScope.content}" placeholder="내용을 입력해주세요" maxlength="1000"
				style="width: 600px; height: 350px;"><br>
			<hr>
			<button type="submit" class="btn btn-warning" style="margin-bottom: 500px;">등록</button>
		</form>
			</div>
			</div>
			

  <!-- end body section -->

  <!-- footer section -->
  <footer class="footer_section">
    <div class="container">
      <div class="row">
        <div class="col-md-4 footer-col">
          <div class="footer_contact">
            <h4>
              Contact Us
            </h4>
            <div class="contact_link_box">
              <a href="">
                <i class="fa fa-map-marker" aria-hidden="true"></i>
                <span>
                  Location
                </span>
              </a>
              <a href="">
                <i class="fa fa-phone" aria-hidden="true"></i>
                <span>
                  Call +01 1234567890
                </span>
              </a>
              <a href="">
                <i class="fa fa-envelope" aria-hidden="true"></i>
                <span>
                  demo@gmail.com
                </span>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 footer-col">
          <div class="footer_detail">
            <a href="" class="footer-logo">
              Feane
            </a>
            <p>
              Necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with
            </p>
            <div class="footer_social">
              <a href="">
                <i class="fa fa-facebook" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-twitter" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-linkedin" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-instagram" aria-hidden="true"></i>
              </a>
              <a href="">
                <i class="fa fa-pinterest" aria-hidden="true"></i>
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 footer-col">
          <h4>
            Opening Hours
          </h4>
          <p>
            Everyday
          </p>
          <p>
            10.00 Am -10.00 Pm
          </p>
        </div>
      </div>
      <div class="footer-info">
        <p>
          &copy; <span id="displayYear"></span> All Rights Reserved By
          <a href="https://html.design/">Free Html Templates</a><br><br>
          &copy; <span id="displayYear"></span> Distributed By
          <a href="https://themewagon.com/" target="_blank">ThemeWagon</a>
        </p>
      </div>
    </div>
  </footer>
  <!-- footer section -->

  <!-- jQery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script src="../resources/js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- isotope js -->
  <script src="https://unpkg.com/isotope-layout@3.0.4/dist/isotope.pkgd.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <!-- custom js -->
  <script src="../resources/js/custom.js"></script>
  <!-- End Google Map -->
 <!--  <script src="../resources/js/boss_menu.js?ver=3"></script>
  커뮤니티메뉴 js 파일을 추가  -->
</body>

</html>