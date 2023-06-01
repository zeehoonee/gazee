<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap"
	rel="stylesheet">

<link href="../../resources/css/style2.css" rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">

	$('.pages').click(function() {
		//$('#result').empty()
		$.ajax({
			url : "csCategory", //views/bbsList2.jsp가 결과!
			data : {
				page : $(this).text(),
				mode : 2,
				category1 : '${categoryValue}'
			},
			success : function(result) { //결과가 담겨진 table부분코드
				$('#result').html(result)
			},
			error : function() {
				alert('실패.@@@')
			}
		}) //ajax
	})
	
	$('#csSearchBtn').click(function() {
			var search1=$('#csSearch').val();
			location.href="../../customerService/cs/csSearch?page=1&mode=1&search1="+search1;
			
		})//category
		
		
	$('#csWrite').click(function() {
		var sessionId = "<%=session.getAttribute("id")%>";
		$.ajax({
			url: "checkTemporaryCs",
			data:{
				csWriter: sessionId
			},
			success: function(x){
				$('#alert').html(x);
			},
			error: function(xhr, status, error){
				location.href = "../../customerService/cs/goToCsWrite?csWriter="+sessionId;
			}
			
		})
	})
</script>
<style>
.pages {
	width: 34px;
	height: 34px;
	background-color: white;
	border: 1px solid rgb(204, 204, 204);
	color: rgb(155, 153, 169);
	cursor: pointer;
}
.pages:active {
	background-color: #693FAA;
	color: white;
	border:1px solid #693FAA;
}
</style>
<table class="table table-striped"
	style="margin: 0 auto;">
	<tr>
		<td class="top">번호</td>
		<td class="top">제목</td>
		<td class="top">작성자</td>
		<td class="top">작성날짜</td>
		<td class="top">조회수</td>
	</tr>
	<c:forEach items="${category}" var="bag" varStatus="status">
										<%
											@SuppressWarnings("unchecked")
											List<String> nickname = (List<String>) request.getAttribute("nickname");
										%>
										<tr>
											<td class="down">${bag.csNo}</td>
											<c:choose>
												<c:when
													test="${sessionScope.id eq bag.csWriter}">
													<td class="down"><a
														href="csOne?id=${bag.csId}&csWriter=${bag.csWriter}">${bag.csTitle}</a></td>
												</c:when>
												<c:otherwise>
													<td class="down"><a
														href="csOne?id=${bag.csId}&csWriter=${bag.csWriter}">비밀글입니다.</a></td>
												</c:otherwise>
											</c:choose>
											<td class="down">${nickname[status.index]}</td>
											<td class="down">${bag.csDate}</td>
											<td class="down">${bag.csView}</td>
										</tr>
									</c:forEach>
</table>