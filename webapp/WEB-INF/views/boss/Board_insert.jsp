<%@page import="com.mat.zip.boss.model.BoardVO"%>
<%@page import="com.mat.zip.boss.model.ComVO"%>
<%@page import="com.mat.zip.boss.model.Boss_memberVO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="../../resources/css/boss.css" rel="stylesheet">

<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "Board_list",
			data : {
				board_id : '${bag.board_id}',
			},
			success : function(x) {
				window.location.href = "board_index.jsp"
			},
			error : function() {
				alert('computer요청 실패!')
			}//error
		})//ajax
	})//$
</script>