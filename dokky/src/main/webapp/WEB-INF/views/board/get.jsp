<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dokky</title>
<%@include file="../includes/left.jsp"%>
<style>
	body{
		background-color: #323639; 
	}
	.getWrapper { 
	    border-color: #e6e6e6; 
		border-style: solid; 
		background-color: #323639; 
		color: #e6e6e6;
		margin-left: 15%;
		margin-top: 1%; 
	}  
    #replyModForm{ 
      display:none;
    }  
    .page-item{
      display:inline;
    }  
    
    .uploadResult {
	  width:100%;
	  background-color: gray;
	}
	.uploadResult ul{
	  display:flex;
	  flex-flow: row;
	  justify-content: center;
	}
	.uploadResult ul li {
	  list-style: none;
	  padding: 10px;
	  align-content: center;
	  text-align: center;
	}
	.uploadResult ul li img{
	  width: 100px;
	}
	.uploadResult ul li span {
	  color:white;
	}
	.bigPictureWrapper {
	  position: absolute;
	  display: none;
	  justify-content: center;
	  align-items: center;
	  top:0%;
	  width:100%;
	  height:100%;
	  background-color: gray; 
	  z-index: 100;
	  background:rgba(255,255,255,0.5);
	}
	.bigPicture {
	  position: relative;
	  display:flex;
	  justify-content: center;
	  align-items: center;
	}
	
	.bigPicture img {
	  width:600px;
	}
</style>
</head>
<body> 
<div class="getWrapper"> 
	<div class="col-lg-12">
     <h1 class="page-header">
		 <c:choose>
		       <c:when test="${board.category == 1 }">
		          		 공지사항 
		       </c:when>
		       <c:when test="${board.category == 2 }">
		       			  자유게시판
		       </c:when>
		        <c:when test="${board.category == 3 }">
		     		 	  묻고답하기
		       </c:when>
		        <c:when test="${board.category == 4 }">
		   		   	  	  칼럼/Tech
		       </c:when>
		       <c:when test="${board.category == 5 }">
		   		   		  정기모임/스터디 
		       </c:when>
		        <c:when test="${board.category == 6 }"> 
		   		   		    마이페이지  
		       </c:when>
       </c:choose>
     </h1>
    </div>
    
    <div class='bigPictureWrapper'>
	  <div class='bigPicture'>
	  </div>
	</div>

	<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">

      <div class="panel-heading"></div>
      <div class="panel-body">
        <div class='uploadResult'> 
          <ul>
          </ul>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>

		<div class="form-group">
          <label>날짜</label>-<fmt:formatDate pattern="yyyy-MM-dd-HH:mm"
								value="${board.regDate}" />
        </div>
        <div class="form-group">
          <label>수정됨</label>-<fmt:formatDate pattern="yyyy-MM-dd-HH:mm"
								value="${board.updateDate}" />
        </div>						
		<div class="form-group">
          <label>닉네임</label>-<c:out value="${board.nickName }"/>  
        </div>
         <div class="form-group">
          <label>번호</label>-<c:out value="${board.num }"/>
        </div>
        <div class="form-group">
          <label>제목</label>-<c:out value="${board.title }"/>
        </div>   
        <div class="form-group">
          <label>내용</label>-${board.content }
        </div>
        
        <div class="form-group">
          <label>좋아요</label> <span id="likeCount"><c:out value="${board.likeCnt }"/></span>
          <button id="like" data-user_id="${board.userId }">좋아요</button>  
        </div> 
        <div class="form-group">
          <label>싫어요</label> <span id="dislikeCount"><c:out value="${board.dislikeCnt }"/></span>
          <button id="dislike" data-user_id="${board.userId }">싫어요</button> 
        </div>
        
        <div class="form-group">
          <label>기부금</label> <c:out value="${board.money }"/>
          <button id="giveMoney" data-user_id="${board.userId }">기부금,ajax구현</button> 
        </div>
        <div class="form-group">
          <label>조회수</label> <c:out value="${board.hitCnt }"/> 
        </div>
        <div id="replyCntVal" class="form-group"> 
          <%-- <label>댓글</label>-${board.replyCnt } --%>
        </div>
		<div> 
		
			<sec:authentication property="principal" var="userInfo"/>
		
		 	<sec:authorize access="isAuthenticated()">
		 		     <button id="scrap">스크랩 </button>
		 		     
		        <c:if test="${userInfo.username eq board.userId}">
		       		 <button id="modify_button">수정 </button> 
					 <button id="remove_button">삭제 </button>
		        </c:if>
	        </sec:authorize>
	        
					 <button id="list_button">목록보기 </button> 
	        
			<form id='operForm' action="/dokky/board/modify" method="get">
			  
				  <input type="hidden" id='csrf' name="${_csrf.parameterName}" value="${_csrf.token}"/>
				  
				  <input type='hidden' id='userId' name='userId' value='<c:out value="${board.userId}"/>'>    
				  
				  <input type='hidden' id='num' name='num' value='<c:out value="${board.num}"/>'>
				  <input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
				  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
				  <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
				  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
	  			  <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>  
			</form>

		</div>
	<!-- ///////////////////////////////////////////////////////// -->
	<div><!-- 댓글 목록 -->
        <ul class="replyList">
        </ul>
    </div>  
    <div class="replyPage"> <!-- 댓글페이지 -->
    </div>
    
      <div id="replyModForm" ><!-- 댓글 수정 폼+값 불러오기 --> 
              <input name='reply_content' value=''> 
              <button id='replyModFormModBtn' type="button" >수정</button> 
   			  <button id='replyModFormCloseBtn' type="button" >취소</button>
   			  
   			  <input type='hidden' name='nickName' value=''>
              <input type='hidden' name='reply_num' value=''>
      </div>
      
	<sec:authorize access="isAuthenticated()">
		<div class="replyWriteForm"><!--  댓글쓰기 폼 -->
		   <div> 
                <textarea id="reply_contents" rows="3" name='reply_content'></textarea> 
           </div>  
   		   <button id='replyRegisterBtn' type="button">등록</button>
		</div> 
	</sec:authorize>
		
</div> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/dokky/resources/js/reply.js"></script> <!--댓글 AJAX통신 -->
<script>

     function func_confirm(content){//단순 확인여부 함수
         if(confirm(content)){//true
         	return true;
         } else {//false
         	return false;
         }
     }
	/////////////////////////////////////////////////////////
	
	var operForm = $("#operForm"); 
	
	$("#list_button").on("click", function(e){//글 목록
	    operForm.find("#num").remove();
	    operForm.find("#userId").remove();
	    operForm.find("#csrf").remove();
	    operForm.attr("action","/dokky/board/list")
	    operForm.submit();
 	 }); 
	
	$("#modify_button").on("click", function(e){//글 수정
	    operForm.submit();   
 	 }); 
	   
	$("#remove_button").on("click", function(e){//글 삭제
		if(func_confirm('정말 삭제 하시겠습니까?')){
			operForm.attr("action","/dokky/board/remove").attr("method","post");
		    operForm.submit();
		}
 	 }); 
	
	/////////////////////////////////////////////////////////
 	 var numValue = '<c:out value="${board.num}"/>';// 글번호
 	 var replyList = $(".replyList");//댓글목록
	 var replyCnt ;
	 var username = null;
	 
	function showReplyList(page){ //댓글 목록 가져오기
	    replyService.getList({num:numValue, page: page || 1 }, function(data) {
	  		  replyCnt =  data.replyCnt;
	  		  
			  if(page == -1){
			  
		      pageNum = Math.ceil(replyCnt/10.0);
		      //alert(pageNum);
		      showReplyList(pageNum);//마지막페이지 찾아서 다시호출
		      return;
		    }
	        
	     var str="";
	     var len = data.list.length;
	     var nickName=""; 
	     var userId=""; 
	     var reply_nums=""; 
		     <sec:authorize access="isAuthenticated()">
		    	 username = '${userInfo.username}';
		     </sec:authorize>

	     if(data.list == null || len == 0){//댓글 리스트
	    	 replyList.html(str);//댓글삭제후 댓글이 하나도 없다면 목록안에 공백 채워주기
	    	 showReplyPage(0);//댓글이 없어서 페이지 번호 없애주기
	    	 return;  
	     }
	     for (var i = 0; i < len || 0; i++) {
	       nickName = data.list[i].nickName; 
	       userId = data.list[i].userId;  
	       reply_nums = data.list[i].reply_num;   
	       
	       str +="<div style='display:none' id=replace"+reply_nums+"></div><li data-reply_num='"+reply_nums+"'>"+reply_nums
	       +" " + nickName
	       +" " + data.list[i].reply_content
	       +" "+replyService.displayTime(data.list[i].replyDate)
	       +" "
	       if(username == userId){
			 str += "<button data-oper='modify' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>수정</button>"
		       +"<button data-oper='delete' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>삭제</button>"
	       } 
	  	        str += "  좋아요 <span id='replyLikeCount"+reply_nums+"'>"+data.list[i].likeCnt+"</span> "
				str += " <button data-oper='like' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>좋아요</button>" 
			       +"<button data-oper='dislike' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>싫어요</button>"
			       +"<button data-oper='giveMoney' type='button' data-user_id='"+userId+"' data-reply_num='"+reply_nums+"'>기부금</button>"
	       +"</li>";  
			    /*  str += "<sec:authorize access='isAuthenticated()'>" */
		       	/*   +"</sec:authorize>"  인증된사람만 보여주기*/
	     }
	     replyList.html(str);//댓글목록안에 채워주기
	     
	     showReplyPage(data.replyCnt);//댓글페이지 보여주기
	     
	     console.log("showReplyList끝");
	     
	     var replyCntVal = $("#replyCntVal");
	      
	     replyCntVal.html("댓글-"+replyCnt);   
	     
	   });//end function
	     
	 }//end showReplyList
	 
	 showReplyList(1);//댓글리스트 보여주기
		 
	/////////////////////////////////////////////////////////
	 var csrfHeaderName ="${_csrf.headerName}"; 
	 var csrfTokenValue="${_csrf.token}";
	    
	 $(document).ajaxSend(function(e, xhr, options) { 
        xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); //모든 AJAX전송시 CSRF토큰을 같이 전송하도록 셋팅
      });
	/////////////////////////////////////////////////////////
		 var replyRegisterBtn = $("#replyRegisterBtn");//댓글 등록 버튼
		 var reply_contents = $("#reply_contents");//댓글 내용
	 <sec:authorize access="isAuthenticated()">   
	     var reply_id = '${userInfo.username}';//댓글 작성자 아이디
	 	 var reply_nickName = '${userInfo.member.nickName}';//댓글 작성자 닉네임
   	</sec:authorize>

		 replyRegisterBtn.on("click",function(e){// 0. 댓글 등록 이벤트 설치
		    
		      var reply = {
		    		reply_content:reply_contents.val(), //댓글 내용
		    		userId:reply_id,//댓글 작성자 아이디
		            num:numValue, //글번호 
		            nickName:reply_nickName //작성자 닉네임
		          };
		      
		     	 replyService.add(reply, function(result){//댓글 등록
		        
				        //alert(result);
				        reply_contents.val("");//댓글등록후 폼 비우기
				        
				        showReplyList(-1);//댓글 목록 마지막 페이지 보여주기
			     }); 
		   });
	/////////////////////////////////////////////////////////이하는 댓글 수정,삭제,수정후 취소

	 	var RecentReplaceTag; //더미 <div>가 댓글 수정폼으로 교체되어지기전 백업해둔 현재 <div>태그
	 	var isReplaceTag = false;//더미 <div>가 댓글 수정폼으로 교체되었는지 체크여부
	 	var replyModFormId ;//현재 댓글 수정폼의 아이디
	     
	 	function checkUser(user_id,loginCheck,idCheck,likeCheck){
	 		
	 		if(!username){//로그인 체크
		  		  alert(loginCheck);
		  		  return true; 
		  	 } 
			
			if(idCheck){
				if(user_id  != username){
			 		  alert(idCheck);
			 		  return true; 
			 	 }
			}
			//alert(username); 
			if(likeCheck){//좋아요,싫어요,기부금 체크
				if(user_id  == username){
			 		  alert(likeCheck);
			 		  return true; 
			 	 }
			}
	 	}
	 	
	$(".replyList").on("click",'button[data-oper="modify"]', function(event){//1. 댓글목록의 수정버튼 이벤트,댓글 데이터 한줄 가져오기
		var loginCheck = "로그인후 수정이 가능합니다.";
		var idCheck = "자신이 작성한 댓글만 수정이 가능합니다.";
		var user_id = $(this).data("user_id");  
		//var orginal_nickname = $(this).data("orginal_nickname"); 
		 
		if(checkUser(user_id,loginCheck,idCheck)){
		return; 
		}
		
		if(isReplaceTag){//댓글 수정폼이 열려 있다면
			 RecentReplaceTag.replaceAll("#"+replyModFormId);//댓글 수정폼을  더미 <div>로 교체
			$(".selected").css("display", "list-item");//none해둔 수정 댓글은 다시 보이게하기 
		}  
		
		$(this.parentNode).addClass('selected').css("display","none");//수정할려는 댓글 한줄 안보이게
		
		  var reply_num = $(this).data("reply_num");//수정 할려는 댓글의 번호 가져오기
		  var currentReplyModForm = $('#replyModForm').clone();//모형 댓글 수정폼 복제해오기
		  
		  currentReplyModForm.attr('id', "replyModForm"+reply_num);//글번호 넣어서 아이디  바꿔주기
		  replyModFormId = currentReplyModForm.attr('id');//현재 댓글 수정폼의 아이디 저장 
		  
		  currentReplyModForm.find('#replyModFormCloseBtn').attr('id', "replyModFormCloseBtn"+reply_num); //댓글 수정폼 취소버튼 id 글번호 넣어서 바꿔주기
		  currentReplyModForm.find('#replyModFormModBtn').attr('id', "replyModFormModBtn"+reply_num); //댓글 수정폼 수정버튼 id 글번호 넣어서 바꿔주기
		  
		 RecentReplaceTag = $("#replace"+reply_num).clone();//더미 div를 복제해서 잠시 빼둠-추후 댓글 수정폼을 다시 되돌리기 위해
		    
		 currentReplyModForm.replaceAll("#replace"+reply_num);//더미 div를 댓글 수정폼 으로 교체    
		 
		 isReplaceTag = true;//교체 되어졌음을 확인 
		
		    var InputReply_content = currentReplyModForm.find("input[name='reply_content']");
		    var InputNickName = currentReplyModForm.find("input[name='nickName']");
		    var InputReply_num = currentReplyModForm.find("input[name='reply_num']");
		    
		  replyService.get(reply_num, function(Result){//1. 댓글 데이터 한줄 가져오기
			  InputReply_content.val(Result.reply_content);//ReplyVO의 reply_content
			  InputNickName.val(Result.nickName);//ReplyVO의 nickName
			  InputReply_num.val(reply_num);
			  
			  currentReplyModForm.css("display","block");//최종 댓글 수정 입력폼 사용자에게 보여주기   
			  
	/////////////////////////////////////////////////////// 

			  var replyModFormCloseBtn = $("#replyModFormCloseBtn"+reply_num); //댓글 수정폼 취소버튼 가져오기 
			  var replyModFormModBtn = $("#replyModFormModBtn"+reply_num);//댓글 수정폼 수정버튼 가져오기
			  
			  replyModFormModBtn.on("click", function(e){// 1-1. 댓글 수정 등록 
				   	 var reply = {
					  reply_num:InputReply_num.val(),
					  reply_content: InputReply_content.val(),
					  userId: user_id //시큐리티를 위해 넘겨줌
					   
					  };//수정폼의 값을 넘긴다
				   	  
				   	  replyService.update(reply, function(result){
				   	        
				   	    //alert(result); 
				   	      
				   	    showReplyList(pageNum);//수정후 댓글 페이지 유지하면서 리스트 다시불름
				   	 
				   	  });
				   	});
			    
			  replyModFormCloseBtn.on("click", function(e){//1-2. 댓글 수정 취소 
				  RecentReplaceTag.replaceAll("#replyModForm"+reply_num); //수정 취소시 댓글 수정폼을 다시  더미 <div>로 교체  
				 	    
				 	   $(".selected").css("display", "list-item");//숨겨둔 댓글 한줄 다시 보이게
				}); 
		  });
	});// 1.이벤트 함수 끝
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="delete"]', function(event){//2. 댓글 삭제 이벤트 설치
		
		var loginCheck = "로그인후 삭제가 가능합니다.";
		var idCheck = "자신이 작성한 댓글만 삭제가 가능합니다.";
		var user_id = $(this).data("user_id"); 
		
		if(checkUser(user_id,loginCheck,idCheck,null)){
			return;
		}
		
		if(func_confirm('정말 삭제 하시겠습니까?')){ 
			var reply_num = $(this).data("reply_num");
			//replyService.remove(reply_num,orginal_nickname, function(result){
			replyService.remove(reply_num,user_id, function(result){
		   	      //alert(result);
		   	      showReplyList(pageNum);//삭제후 댓글 페이지 유지하면서 리스트 다시불름 
	   	  }); 
		}
	});//2. 이벤트 함수 끝 
	
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="like"]', function(event){//3. 댓글 좋아요 버튼 이벤트 설치
		
		var loginCheck = "로그인후 좋아요를 눌러주세요.";
		var likeCheck = "자신의 댓글에는 좋아요를 할 수 없습니다.";
		var user_id = $(this).data("user_id");
		var reply_num = $(this).data("reply_num");
		
		if(checkUser(user_id,loginCheck,null,likeCheck)){ 
			return;
		}
		
		var likeData = {reply_num:reply_num,//댓글번호
						userId:username//접속 아이디
				};
		
		replyService.updateReplyLike(likeData, function(result){
		 
		var replyLikeCount = $("#replyLikeCount"+reply_num);
			replyLikeCount.html(result);
			//console.log(result); 
		  });
		//추후 좋아요를 눌르면 이미지변경까지 취소하면 이미지변경 추가해보자
	});//3. 댓글 좋아요 버튼 이벤트 설치
	
///////////////////////////////////////////////////////
	$(".replyList").on("click",'button[data-oper="dislike"]', function(event){//4. 댓글 싫어요 버튼 이벤트 설치
		
		var loginCheck = "로그인후 싫어요를 눌러주세요.";
		var likeCheck = "자신의 댓글에는 싫어요를 할 수 없습니다.";
		var user_id = $(this).data("user_id");
		
		if(checkUser(user_id,loginCheck,null,likeCheck)){
			return;
		}
		alert("싫어요 하였습니다."); 
		/* var reply_num = $(this).data("reply_num");//앞으로 댓글 싫어요 구현해야함
		 
		 replyService.like(reply_num, function(result){
	   	      //alert(result);
	   	      showReplyList(pageNum);//삭제후 댓글 페이지 유지하면서 리스트 다시불름 
	   	  }); 
		} */
	});//4. 댓글 싫어요 버튼 이벤트 설치
	
	$(".replyList").on("click",'button[data-oper="giveMoney"]', function(event){//4. 댓글 기부금 버튼 이벤트 설치
			
			var loginCheck = "로그인후 기부를 해주세요.";
			var giveCheck = "자신의 댓글에는 기부를 할 수 없습니다.";
			var user_id = $(this).data("user_id");
			
			if(checkUser(user_id,loginCheck,null,giveCheck)){
				return; 
			}
			alert("기부 하였습니다."); 
			
		});//4. 댓글 기부금 버튼 이벤트 설치
		
		$("#like").on("click",function(event){//3. 좋아요 버튼 이벤트 설치
			var loginCheck = "로그인후 좋아요를 눌러주세요.";
			var likeCheck = "자신의 글에는 좋아요를 할 수 없습니다.";
			var user_id = $(this).data("user_id");
			
			if(checkUser(user_id,loginCheck,null,likeCheck)){
				return;  
			}
			
			var likeData = {num:numValue,//글번호
							userId:username//접속 아이디
							};
			
		   	replyService.updateLike(likeData, function(result){
		   	 
		   	var likeCount = $("#likeCount");
		  	likeCount.html(result);
		   		//console.log(result); 
		   	  });
		   	//추후 좋아요를 눌르면 이미지변경까지 취소하면 이미지변경 추가해보자
		   	});
	   	
	   	$("#dislike").on("click",function(event){//3. 싫어요 버튼 이벤트 설치
			
			var loginCheck = "로그인후 싫어요를 눌러주세요.";
			var likeCheck = "자신의 글에는 싫어요를 할 수 없습니다.";
			var user_id = $(this).data("user_id");
			
			if(checkUser(user_id,loginCheck,null,likeCheck)){
				return; 
			}
			var dislikeData = {num:numValue,//글번호
					userId:username//접속 아이디
					};
			
			replyService.updateDisLike(dislikeData, function(result){
			   	 
			   	var dislikeCount = $("#dislikeCount");
			   	dislikeCount.html(result);
			   		//console.log(result); 
	   	    });
	   	});
	   	
   		$("#giveMoney").on("click",function(event){//3. 기부금 버튼 이벤트 설치
		
		var loginCheck = "로그인후 기부를 해주세요.";
		var giveCheck = "자신에게는 기부를 할 수 없습니다."; 
		var user_id = $(this).data("user_id");
		
		if(checkUser(user_id,loginCheck,null,giveCheck)){
			return; 
		}
		alert("기부 하였습니다."); 
	   	});
///////////////////////////////////////////////////////	
	  
	 	var pageNum = 1;
	    var replyPage = $(".replyPage");
	    
    function showReplyPage(replyCnt){//댓글 페이지 함수
    	if(replyCnt == 0){//댓글삭제후 댓글이 하나도없다면
    		replyPage.html("");
    		return;
    	}
    
      var endNum = Math.ceil(pageNum / 10.0) * 10; 
      /* Math.ceil() : 소수점 이하를 올림한다. */ 
      var startNum = endNum - 9;
      var prev = startNum != 1; 
      var next = false; 
      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	       					 /* 10.0은 보여줄 댓글의 갯수 */
	      }
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	  var str = "<ul>";
	      	
	      if(prev){ 
	    	  
	        	str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(var i = startNum ; i <= endNum; i++){
	        
		        var active = pageNum == i? "active":"";
		          
		        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'> " +i+ " </a></li>"; 
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
      str += "</ul></div>";
      
      //console.log(str);
      
      replyPage.html(str);
    }
	     
	    replyPage.on("click","li a", function(e){//4. 페이지 링크 클릭시 이벤트
		       e.preventDefault();
		       
		       var targetPageNum = $(this).attr("href");
		       
		       //console.log("targetPageNum: " + targetPageNum);
		       
		        pageNum = targetPageNum;
		        
		       showReplyList(pageNum);
	     });    
	    
	    $(document).ready(function(){//첨부파일 즉시 함수
	    	  
	    	  (function(){
	    	  
	    	    var num = '<c:out value="${board.num}"/>';
	    	   
	    	    $.getJSON("/dokky/board/getAttachList", {num: num}, function(arr){
	    	        
	    	       //console.log(arr);
	    	       
	    	       var str = "";
	    	       
	    	       $(arr).each(function(i, attach){
	    	       
	    	         if(attach.fileType){ //image type
	    	           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
	    	           
	    	           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	    	           str += "<img src='/dokky/display?fileName="+fileCallPath+"'>";
	    	           str += "</div>";
	    	           str +"</li>";
	    	         }else{
	    	           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
	    	           str += "<span> "+ attach.fileName+"</span><br/>";
	    	           str += "<img src='/dokky/resources/img/attach.png'></a>";
	    	           str += "</div>"; 
	    	           str +"</li>";
	    	         }
	    	       });
	    	       
	    	       $(".uploadResult ul").html(str);
	    	       
	    	     });//end getjson
	    	    
	    	  })();//end function
	    	  
	    	  $(".uploadResult").on("click","li", function(e){
	    	      
	    	    //console.log("view image");
	    	    
	    	    var liObj = $(this);
	    	    
	    	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
	    	    
	    	    if(liObj.data("type")){
	    	      showImage(path.replace(new RegExp(/\\/g),"/"));
	    	    }else {
	    	      self.location ="/dokky/download?fileName="+path
	    	    }
	    	    
	    	  });
	    	  
	    	  function showImage(fileCallPath){
	    	    
	    	    $(".bigPictureWrapper").css("display","flex").show();
	    	    
	    	    $(".bigPicture")
	    	    .html("<img src='/dokky/display?fileName="+fileCallPath+"' >")
	    	    .animate({width:'100%', height: '100%'}, 1000);
	    	  }

	    	  $(".bigPictureWrapper").on("click", function(e){
	    	    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
	    	    setTimeout(function(){
	    	      $('.bigPictureWrapper').hide();
	    	    }, 1000);
	    	  });
	    	  
	    	});
	    
</script>
</body>
</html>


 
