<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="uri" value="${pageContext.request.requestURI}" />
<!-- BREADCRUMB -->
<script>
    $(function() {
		let uri = "${uri}";
		let afterUri = uri.split("/views/")[1];
		afterUri = afterUri.replace(".jsp", "");
		let uriArray = afterUri.split("/");
		let link = "/olympic/";
		$.each(uriArray, function(index, item) {
		    let html = '<li class="breadcrumb-item">';
		    link += item;
		    if(index == uriArray.length - 1) {
		    	html += '<a class="text-gray-400" href="'+ link +'.do">';
		    }
		    else {
				link += '/';
		    	html += '<a class="text-gray-400" href="'+ link +'index.do">';
		    }
		    html += item;
		    html += '</a></li>';
		    $("#breadcrumb").append(html);
		});
		$("#breadcrumb").children().last().addClass("active");
    });
</script>
<nav class="py-5">
	<div class="container">
		<div class="row">
			<div class="col-12">
				<!-- Breadcrumb -->
				<ol class="breadcrumb mb-0 fs-xs text-gray-400" id="breadcrumb">
					<li class="breadcrumb-item">
						<a class="text-gray-400" href="/olympic/index.do">Home</a>
					</li>
				</ol>

			</div>
		</div>
	</div>
</nav>
