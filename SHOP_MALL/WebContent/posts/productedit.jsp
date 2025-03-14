<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<meta charset="UTF-8">
<title>상품 수정</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f5f5f5;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	background: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 400px;
	text-align: center;
}

h2 {
	margin-bottom: 20px;
	color: #333;
}

label {
	display: block;
	margin: 10px 0 5px;
	font-weight: bold;
	text-align: left;
}

input, textarea {
	width: 100%;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 14px;
}

button {
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px;
	width: 100%;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	margin-top: 10px;
}

button:hover {
	background-color: #0056b3;
}

.back-btn {
	background-color: #6c757d;
}

.back-btn:hover {
	background-color: #5a6268;
}

.image-preview {
	margin-top: 10px;
}
</style>
<script>
	function redirectToMyPage(event) {
		event.preventDefault(); // 기본 폼 제출 방지
		alert("상품 수정이 완료되었습니다.");
		document.getElementById("editForm").submit(); // 폼 제출
		window.location.href = "/mypage.do"; // 마이페이지로 이동
	}

	function previewImage(event) {
		const reader = new FileReader();
		reader.onload = function() {
			const output = document.getElementById('imagePreview');
			output.src = reader.result;
			output.style.display = "block";
		};
		reader.readAsDataURL(event.target.files[0]);
	}
</script>
</head>
<body>
	<div class="container">
		<h2>상품 수정</h2>

		<c:choose>
			<c:when test="${product == null}">
				<p style="color: red; font-weight: bold;">상품을 등록하지 않았습니다.</p>
				<button class="back-btn"
					onclick="location.href='/post/mysellinglist.do'">목록으로 돌아가기</button>
			</c:when>
			<c:otherwise>
				<form id="editForm" action="/post/productupdate.do" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="productid" value="${product.productid}">
					<input type="hidden" name="existingProductImage"
						value="${product.productImage}"> <label>카테고리</label> <select
						name="categoryid" required>
						<c:forEach var="category" items="${categoryList}">
							<option value="${category.categoryid}"
								<c:if test="${category.categoryid == product.categoryid}">selected</c:if>>
								${category.categoryname}</option>
						</c:forEach>
					</select> <label>상품명</label> <input type="text" name="productName"
						value="${product.productName}" required> <label>가격</label>
					<input type="number" name="productPrice"
						value="${product.productPrice}" required> <label>재고</label>
					<input type="number" name="productStock"
						value="${product.productStock}" required> <label>상품
						설명</label>
					<textarea name="productInfo" required>${product.productInfo}</textarea>

					<label>대표 이미지</label> <input type="file" name="productImage"
						accept="image/*">
					<c:if test="${not empty product.productImage}">
						<p>현재 이미지:</p>
						<img src="${product.productImage}" width="100">
					</c:if>

					<button type="submit" onclick="alert('상품 수정이 완료되었습니다.')">수정
						완료</button>
				</form>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
