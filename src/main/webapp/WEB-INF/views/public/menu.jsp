<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ASM News</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
:root {
    --primary-gradient: linear-gradient(45deg, #667eea, #764ba2);
}

.navbar {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
    padding: 1rem 0;
    position: sticky;
    top: 0;
    z-index: 1000;
    transition: all 0.3s ease;
}

.navbar.scrolled {
    padding: 0.5rem 0;
    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.15);
}

.navbar-brand {
    font-size: 1.8rem;
    font-weight: 700;
    background: var(--primary-gradient);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    transition: transform 0.3s ease;
}

.navbar-brand:hover {
    transform: scale(1.05);
}

.navbar-nav .nav-link {
    color: #334155 !important;
    font-weight: 500;
    margin: 0 0.5rem;
    position: relative;
    transition: all 0.3s ease;
}

.navbar-nav .nav-link::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    width: 0;
    height: 2px;
    background: var(--primary-gradient);
    transition: all 0.3s ease;
    transform: translateX(-50%);
}

.navbar-nav .nav-link:hover::after,
.navbar-nav .nav-link.active::after {
    width: 80%;
}

.navbar-nav .nav-link:hover {
    color: #667eea !important;
    transform: translateY(-2px);
}
</style>

</head>
<body>

<!-- Navbar trên -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-newspaper"></i> ASM News
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <ul class="navbar-nav ms-auto">
            <c:choose>
                <c:when test="${sessionScope.currentUser != null}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                            role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user"></i> ${sessionScope.currentUser.fullname}
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin">
                                <i class="fas fa-tachometer-alt"></i> Quản trị
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt"></i> Đăng xuất
                            </a></li>
                        </ul>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i> Đăng nhập
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<!-- Navbar menu dưới -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <ul class="navbar-nav d-flex flex-row justify-content-center w-100">
            <li class="nav-item mx-2">
                <a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a>
            </li>
            <li class="nav-item mx-2">
                <a class="nav-link" href="${pageContext.request.contextPath}/news">Tin tức</a>
            </li>
            <c:forEach var="category" items="${categories}">
                <li class="nav-item mx-2">
                    <a class="nav-link" href="${pageContext.request.contextPath}/news?action=category&id=${category.id}">
                        ${category.name}
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
</nav>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
window.addEventListener('scroll', function () {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.classList.add('scrolled');
    } else {
        navbar.classList.remove('scrolled');
    }
});
</script>

</body>
</html>
