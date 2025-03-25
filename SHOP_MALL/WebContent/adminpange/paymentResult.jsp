<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fragments/header.jsp"%>
<link rel="stylesheet" href="../css/payresult.css">

<section class="payresult-section">
    <div class="payresult-header">
        <div class="container">
            <h2 class="payresult-title">결제 결과</h2>
        </div>
    </div>
    <div class="payresult-content">
        <div class="container">
   			<p>${message}</p>
  		</div>
	</div>
</section>
<%@ include file="/fragments/footer.jsp"%>