<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Dokky - 메인</title> 
	<link href="/dokky/resources/css/main.css" rel="stylesheet" type="text/css"/>
</head>

<%@include file="../includes/left.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>
	<div class="bodyWrap">	 
		<div class="mainLists"> 
			실시간 게시글
			<table class=""> 
				<c:forEach items="${realtimeList}" var="board">
					<tr>
						<td>  
							<a class='move' href='/dokky/board/get?board_num=<c:out value="${board.board_num}"/>'> 
								<c:out value="${board.title}" /> 
								<span class="replyCnt">[<c:out value="${board.replyCnt}" />]</span>
							</a>
						</td> 
						<td>
							<img width="20px" src="/dokky/resources/img/read.png"/>
							<c:out value="${board.hitCnt}" />
						</td>
						<td>   
							<img width="20px" src="/dokky/resources/img/like.png"/>
							<c:out value="${board.likeCnt}" />
						</td>
						<td> 
							\<fmt:formatNumber type="number" maxFractionDigits="3" value="${board.money}"/>
						</td>
						<td> 
							<a href="#" class="userMenu" data-board_num="${board.board_num}" data-menu_kind="realtime">
								<img src="/dokky/resources/img/profile_img/<c:out value="${board.userId}" />.png"  class="memberImage hideUsermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
								<c:out value="${board.nickName}" /> 
							</a> 
							 <div id="userMenubar_realtime_${board.board_num}" class="userMenubar">
								<ul class="hideUsermenu"> 
									<li class="hideUsermenu"><a href="/dokky/userBoardList?userId=${board.userId}" class="hideUsermenu"><span class="hideUsermenu">게시글보기</span></a></li>
									<li class="hideUsermenu"><a href="#" class="hideUsermenu"><span class="hideUsermenu">쪽지보내기</span></a></li>
								</ul>  
						     </div>
						</td>
						<td>
							<fmt:formatDate value="${board.regDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
						</td>  
					</tr>
				</c:forEach>
			</table>
		</div>
		 
		<div class="mainLists">  
			monthly 인기글
			<table class=""> 
				<c:forEach items="${monthlyList}" var="board">
					<tr>
						<td>  
							<a class='move' href='/dokky/board/get?board_num=<c:out value="${board.board_num}"/>'> 
								<c:out value="${board.title}" /> 
								<span class="replyCnt">[<c:out value="${board.replyCnt}" />]</span>
							</a>
						</td> 
						<td>
							<img width="20px" src="/dokky/resources/img/read.png"/>
							<c:out value="${board.hitCnt}" />
						</td>
						<td>   
							<img width="20px" src="/dokky/resources/img/like.png"/>
							<c:out value="${board.likeCnt}" />
						</td>
						<td> 
							\<fmt:formatNumber type="number" maxFractionDigits="3" value="${board.money}"/>
						</td>
						<td> 
							<a href="#" class="userMenu" data-board_num="${board.board_num}" data-menu_kind="like">
								<img width="25px" src="/dokky/resources/img/profile_img/<c:out value="${board.userId}" />.png"  class="memberImage hideUsermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
								<c:out value="${board.nickName}" />
							</a> 
							 <div id="userMenubar_like_${board.board_num}" class="userMenubar">
								<ul class="hideUsermenu"> 
									<li class="hideUsermenu"><a href="/dokky/userBoardList?userId=${board.userId}" class="hideUsermenu"><span class="hideUsermenu">게시글보기</span></a></li>
									<li class="hideUsermenu"><a href="#" class="hideUsermenu"><span class="hideUsermenu">쪽지보내기</span></a></li>
								</ul>  
						     </div>
						</td>
						<td>
							<fmt:formatDate value="${board.regDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
						</td> 
					</tr>
				</c:forEach>
			</table>
		</div>
		
		<div class="mainLists"> 
			monthly 최다 기부글
			<table class="">
				<c:forEach items="${donationList}" var="board">
					<tr>
						<td>  
							<a class='move' href='/dokky/board/get?board_num=<c:out value="${board.board_num}"/>'> 
								<c:out value="${board.title}" /> 
								<span class="replyCnt">[<c:out value="${board.replyCnt}" />]</span>
							</a>    
						</td> 
						<td>
							<img width="20px" src="/dokky/resources/img/read.png"/>
							<c:out value="${board.hitCnt}" />
						</td>
						<td>   
							<img width="20px" src="/dokky/resources/img/like.png"/>
							<c:out value="${board.likeCnt}" />
						</td>
						<td> 
							\<fmt:formatNumber type="number" maxFractionDigits="3" value="${board.money}"/>
						</td>
						<td> 
							<a href="#" class="userMenu" data-board_num="${board.board_num}" data-menu_kind="donate"> 
								<img width="25px" src="/dokky/resources/img/profile_img/<c:out value="${board.userId}" />.png"  class="memberImage hideUsermenu" onerror="this.src='/dokky/resources/img/basicProfile.png'" />
								<c:out value="${board.nickName}" />
							</a> 
							 <div id="userMenubar_donate_${board.board_num}" class="userMenubar">
								<ul class="hideUsermenu"> 
									<li class="hideUsermenu"><a href="/dokky/userBoardList?userId=${board.userId}" class="hideUsermenu"><span class="hideUsermenu">게시글보기</span></a></li>
									<li class="hideUsermenu"><a href="#" class="hideUsermenu"><span class="hideUsermenu">쪽지보내기</span></a></li>
								</ul>  
						     </div>
						</td>
						<td> 
							<fmt:formatDate value="${board.regDate}" pattern="yyyy년 MM월 dd일 HH:mm" />
						</td> 
					</tr>
				</c:forEach>
			</table>
		</div>
		
		
	</div>
	<script>
	$(".userMenu").on("click",function(event){//해당 메뉴바 보이기 이벤트
		
		var	board_num = $(this).data("board_num");
		var	menu_kind = $(this).data("menu_kind");
		
		if(menu_kind == 'like'){
				var userMenu = $("#userMenubar_like_"+board_num);
		}else if(menu_kind == 'realtime'){
				var userMenu = $("#userMenubar_realtime_"+board_num);
		}else if(menu_kind == 'donate'){
				var userMenu = $("#userMenubar_donate_"+board_num);
		}
		if($(".addBlockClass").length > 0){
			$(".addBlockClass").css("display","none"); 
			$(".addBlockClass").removeClass('addBlockClass');
		}    
		userMenu.css("display","block"); 
		userMenu.addClass('addBlockClass'); 
		
	 });
	 
	$('html').click(function(e) { //html안 Usermenu, hideUsermenu클래스를 가지고있는 곳 제외하고 클릭하면 숨김 이벤트발생
		if( !$(e.target).is('.userMenu, .hideUsermenu') ) {  //("Usermenu") || $(e.target).hasClass("perid-layer")) { 	
		    var userMenu = $(".userMenubar");    
			userMenu.css("display","none"); 
		} 
	});
	 
	</script>
</body>

</html>