<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>

<html>

<%--head.jsp--%>
<%@ include file="include/head.jsp"%>

<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">

		<%--left_column.jsp--%>
		<%-- Left side column. contains the logo and sidebar --%>
		<%@ include file="include/left_column.jsp"%>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<%-- Main Header --%>
				<%@ include file="include/main_header.jsp"%>

				<!-- Begin Page Content -->
				<div class="container-fluid">
						<!-- Content Row -->
						<div class="row" id="postRow">
							<div class="col-md-12 mb-4">
								<div class="card">
									<div class="card-body">
										<!-- title -->
										<div>
											<h3 class="px-2">${post.postSubject}</h3>
											<input id="postId" type="hidden" value="${post.postId}" />
											<input id="replyYn" type="hidden" value="${post.replyYn}" />
										</div>
										<!-- contents -->
										<div>
											<div class="border-bottom">
												<div class="d-flex justify-content-between px-2">
													<div>${post.wrtrId}</div>
													<div>${post.hitCnt}${post.wrtrDt}</div>
												</div>
											</div>
											<div class="p-2">${post.postConts}</div>
										</div>
										<!-- comment -->
										<div>
											<div class="border-top px-2">comment</div>
											<div id="replyList">

											</div>
											<div id="CreateComment" class="input-group mt-2">
												<input id="replyConts" class="form-control" type="text" placeholder="comment Contents"></input>
												<div class="input-group-append">
													<button class="btn btn-outline-secondary" onclick="createReply()">insert</button>
												</div>
											</div>
										</div>
										<c:if test="${post.wrtrId eq login.userId}">
											<div class="d-flex float-right mt-3">
												<a href="#" class="btn btn-sm btn-primary mr-1">답글</a>
												<a href="/updatePost/${post.postId}" class="btn btn-sm btn-info mr-1" onclick="updatePost()">수정</a>
												<button onclick="deletePost()" class="btn btn-sm btn-danger">삭제</button>
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</div>
						<!-- End Content Row -->

					<!-- Content Row -->
					<div class="row">
						<div class="col-md-12 mb-4">
							<div class="card">
								<div class="card-body">
									<!-- Page Heading -->
									<div
										class="d-sm-flex align-items-center justify-content-between mb-4">
										<p class="h3 mb-0 text-gray-800">${menuDt[post.brdCd].menuNm}</p>
										<input id="menuCd" type="hidden" value="${post.brdCd}" />
									</div>

									<table class="table table-hover table-sm">
										<thead>
											<tr class="d-flex text-center">
												<th class="col-1">번호</th>
												<th class="col-7">제목</th>
												<th class="col-2">작성자</th>
												<th class="col-1">조회수</th>
												<th class="col-1">작성일</th>
											</tr>
										</thead>
										<tbody>
											<tr class="d-flex">
												<td class="col-1 text-center">col 1</td>
												<td class="col-7">col 2</td>
												<td class="col-2 text-center">col 3</td>
												<td class="col-1 text-center">col 4</td>
												<td class="col-1 text-center">col 5</td>
											</tr>
										</tbody>
									</table>

									<div>
										<ul id="page" class="pagination pagination-sm justify-content-center mb-0">
											<li class="page-item"><a class="page-link" href>&laquo;</a></li>
											<li class="page-item"><a class="page-link" href>1</a></li>
											<li class="page-item"><a class="page-link" href>2</a></li>
											<li class="page-item"><a class="page-link" href>3</a></li>
											<li class="page-item"><a class="page-link" href>4</a></li>
											<li class="page-item"><a class="page-link" href>5</a></li>
											<li class="page-item"><a class="page-link" href>&raquo;</a></li>
										</ul>
									</div>
									
									<c:if test="${authMappInfo[post.brdCd += login.userGrpCd].updtYn eq 'Y'}">
										<div class="float-right">
											<a href="/bbs/${post.brdCd}/create" class="btn btn-sm btn-primary">글쓰기</a>
										</div>
									</c:if>
							</div>
						</div>
					</div>
					<!-- End Content Row -->
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End Main Content -->

			<%-- Main Footer --%>
			<%@ include file="include/main_footer.jsp"%>

		</div>
		<!-- End Content Wrapper -->

	</div>
	<!-- End Page Wrapper -->

	<%--plugin_js.jsp--%>
	<%@ include file="include/plugin_js.jsp"%>
	<script>
		$(document).ready(function() {
			getReplyList();
			getPostList();
		});
		
		/* function get_query(){
		    var url = document.location.href;
		    var qs = url.substring(url.indexOf('?') + 1).split('&');
		    for(var i = 0, result = {}; i < qs.length; i++){
		        qs[i] = qs[i].split('=');
		        result[qs[i][0]] = decodeURIComponent(qs[i][1]);
		    }
		    return result;
		} */
		
		function setReplyYn() {
			const replyYn = $('#replyYn').attr('value');
			
			if ("N" == replyYn) {
				$.ajax({
					url : "/setReplyYn",
					type : "POST",
					dataType : "json",
					data : {
						postId : $('#postId').attr('value'),
						replyYn : "Y"
					},
					success : function(response) {
						/* log */
						console.info(response);
					}
				});
			}
		}
		
		function createReply() {
			setReplyYn();
			
			console.log($('#replyConts').val());
			console.log($('#replyConts').attr('value'));
			
			$.ajax({
				url : "/createReply",
				type : "POST",
				dataType : "json",
				data : {
					postId : $('#postId').attr('value'),
					replyConts : $('#replyConts').val(),
				},
				success : function(response) {
					/* log */
					console.info(response);
					location.reload()
				}
			});
		}

		function getReplyList() {
			const postId = $('#postId').attr('value');
			const replyYn = $('#replyYn').attr('value');
			const userId = $('#userId').attr('value');
			
			if ("Y" == replyYn) {
				$.ajax({
					/* url : `/getReplyList/${postId}`, */
					url : "/getReplyList/" + postId,
					type : "GET",
					dataType : "json",
					success : function(response) {
						/* log */
						console.info(response);
						$('#replyList').html('');
						$.each(response, function(index, value) {
							const date = new Date(value.wrtrDt);
							updateAndDelete = '';
							
							if (userId == value.replyWrtrId) {
								updateAndDelete = '<div class="px-2"><span class="small" onclick="replyUpdateForm(this)">수정</span>&nbsp;<span class="small" onclick="replyDeleteAlert(this)">삭제</span></div>'
							}
							
							$('#replyList').append(
								'<div class="border-top py-2">' +
									'<input type="hidden" value="' + value.replyId + '" />' +
									'<div class="font-weight-bold px-2">' + value.replyWrtrId + '</div>' +
									'<div class="px-2">' + value.replyConts + '</div>' +
									updateAndDelete +
								'</div>'
							);
						});
					}
				});
			}
		}
		
		function replyUpdateForm(e) {
			const replyId = $(e).parent().parent().children().first().attr('value');
			const replyConts = $(e).parent().prev().text();

			const updateInput = '<div class="input-group">' + 
					'<input id="replyId' + replyId + '" class="form-control" type="text" value="' + replyConts + '" />' +
					'<div class="input-group-append">' +
						'<button class="btn btn-outline-secondary" onclick="replyUpdate(' + replyId + ')">update</button>' +
					'</div>'
				'</div>';
				
			$(e).parent().prev().replaceWith(updateInput);
		}
		
		function replyUpdate(replyId) {
			const updateReplyId = '#replyId' + replyId;
			
			$.ajax({
				url : "/updateReply",
				type : "POST",
				dataType : "json",
				data : {
					replyId : replyId,
					replyConts : $(updateReplyId).val()
				},
				success : function(response) {
					console.info(response);
					alert(response.resultMsg);
					getReplyList();
				}
			});
		}
		
		function replyDeleteAlert(e) {
			const replyId = $(e).parent().parent().children().first().attr('value');
			
			const delYn = confirm("댓글을 삭제하시겠습니까?");
			
			if (delYn) {
				$.ajax({
					url : "/deleteReply",
					type : "POST",
					dataType : "json",
					data : {
						replyId : replyId
					},
					success : function(response) {
						console.info(response);
						alert(response.resultMsg);
						getReplyList();
					}
				});
			}
		}
		
		function deletePost() {
			const delYn = confirm("게시글을 삭제하시겠습니까?");
			
			if (delYn) {
				$.ajax({
					url : "/deletePost",
					type : "POST",
					dataType : "json",
					data : {
						postId : $('#postId').attr('value'),
						brdCd : $('#menuCd').attr('value')
					},
					success : function(response) {
						console.info(response);
						alert(response.resultMsg);
						/* getTestTableList(); */
						history.back();
					}
				});
			}
		}
		
		function getQuery() {
			var url = document.location.href;
		    var qs = url.substring(url.indexOf('?'));
		    
		    if (url.length == qs.length)
		    	return '';
		    return qs;
		}
		
		function getPostList() {
			const menuCd = $('#menuCd').attr('value');
			const get = getQuery();

			$.ajax({
				/* url : `/getPostList/${menuCd}`, */
				url : "/getPostList/" + menuCd + get,
				type : "GET",
				dataType : "json",
				success : function(response) {
					/* log */
					console.info(response);
					$('tbody').html('');
					$.each(response, function(index, value) {
						const date = new Date(value.wrtrDt);
						$('tbody').append(
							'<tr class="d-flex">'
							+ '<td class="col-1 text-center">'
								+ value.postId
							+ '</td>'
							+ '<td class="col-7">'
								+ '<a href="/post/' + value.postId + get + '">'
									+ value.postSubject
								+ '</a>'
							+ '</td>'
							+ '<td class="col-2 text-center">'
								+ value.wrtrId
							+ '</td>'
							+ '<td class="col-1 text-center">'
								+ value.hitCnt
							+ '</td>'
							+ '<td class="col-1 text-center">'
								+ date.getMonth() + '/'	+ date.getDate()
							+ '</td>'
							+ '</tr>'
						);
					});
				}
			});
		}
	</script>
</body>
</html>