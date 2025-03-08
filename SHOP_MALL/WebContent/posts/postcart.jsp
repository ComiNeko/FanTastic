<%@page import="Model.PostVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.*" %>
<%@ page session="true"%>
<%@ include file="../fragments/header.jsp"%>
<link rel="stylesheet" href="../css/postlist.css">

<!DOCTYPE html>
<html>
<head>
<title>장바구니</title>
</head>
<body>
	<h2>장바구니</h2>

	<table border="1">
		<tr>
			<th>상품명</th>
			<th>가격</th>
			<th>수량</th>
			<th>합계</th>
			<th>삭제</th>
		</tr>

		<%
			List<PostVo> cart = (List<PostVo>) session.getAttribute("cart");
		if (cart == null || cart.isEmpty()) {
			out.println("<tr><td colspan='5'>장바구니가 비어 있습니다.</td></tr>");
		} else {
			int total = 0;
			for (PostVo item : cart) {
				int itemTotal = item.getPrice() * item.getQuantity();
				total += itemTotal;
		%>
		<tr>
			<td><%=item.getProductName()%></td>
			<td><%=item.getPrice()%> 원</td>
			<td><%=item.getQuantity()%></td>
			<td><%=itemTotal%> 원</td>
			<td>
				<form action="CartRemoveServlet" method="post">
					<input type="hidden" name="productId"
						value="<%=item.getProductid()%>"> <input type="submit"
						value="삭제">
				</form>
			</td>
		</tr>
		<%
			}
		%>
		<tr>
			<td colspan="3">총 합계</td>
			<td colspan="2"><%=total%> 원</td>
		</tr>
		<%
			}
		%>
	</table>

	<a href="postsellinglist.jsp">계속 쇼핑하기</a>
</body>
</html>

<%@ include file="/fragments/footer.jsp"%>