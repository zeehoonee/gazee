<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700;900&display=swap"
	rel="stylesheet">
<link href="../../resources/css/style2.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		var sessionId = "<%=session.getAttribute("id")%>";
		
		$('#reportList')
				.click(
						function() {
							location.href = "../../customerService/report/reportList?page=1&mode=1";
						})//report목록으로 돌아가기

		$('#goToReportUpdate').click(function() {
			 location.href = "../../customerService/report/goToReportUpdate?reportWriter="+sessionId+"&id="+${bag.reportId};
		})//report update
						
						
		$('#reportDelete').click(function() {
			$.ajax({
				url:"reportDelete",
				data:{
					reportId:${bag.reportId}
				},
				success:function(x){
					alert('삭제되었습니다.');
                    location.href = "../report/reportList?page=1&mode=1";
				}
			})
		})//reportDelete

	})
</script>

</head>
<body>
	<div id="wrap">
		<div id="header">
			<jsp:include page="/home/Header.jsp" flush="true" />
		</div>
		<div id="content_wrap">
			<div id="content">
				<div id="customerServiceMain">
					<div id="customerHead" style="text-align: left;">
						<h1 style="color: #693FAA">고객센터</h1>
					</div>
					<div id="customerMenu1" style="margin-top: 30px">

						<div class="FAQ">
							<div style="display: flex; justify-content: space-between;">

								<h3 style="color: #693FAA">
									<a href="reportList?page=1&mode=1"
										style="color: #693FAA !important;">신고 게시판</a>
								</h3>
								<div
									style="display: flex; justify-content: space-between; align-items: center; gap: 10px">

									<button id="reportList">목록으로</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<% if(session.getAttribute("id").equals(request.getAttribute("reportWriter"))){  %>
				<div id=result>
					<label>제목</label><label> ${bag.reportTitle}</label>
					<hr>
					<label>내용</label><label> ${bag.reportContent}</label>
					<hr>
					<label>답글</label><label> ${bag.reportReply}</label>
					<div style="display: flex; justify-content: right">
						<button id="goToReportUpdate">수정하기</button>
					</div>
					<div style="display: flex; justify-content: right">
						<button id="reportDelete">삭제하기</button>
					</div>
				</div>
				<%} else {%>
				<div id=result>
					<h1>작성자가 아니면 열람하실 수 없습니다.</h1>
					
				</div>
				<%} %>
				
			</div>
		</div>
		<jsp:include page="/home/Footer.jsp" flush="true" />
	</div>
</body>
</html>