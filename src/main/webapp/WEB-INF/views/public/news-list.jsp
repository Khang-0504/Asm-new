<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${pageTitle} - ASM News</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Font Awesome -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    .navbar-brand {
                        font-weight: bold;
                        color: #007bff !important;
                    }

                    .news-card {
                        transition: transform 0.2s;
                        height: 100%;
                    }

                    .news-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .news-image {
                        height: 200px;
                        object-fit: cover;
                    }

                    .news-meta {
                        color: #6c757d;
                        font-size: 0.9em;
                    }

                    .footer {
                        background-color: #343a40;
                        color: white;
                        padding: 40px 0;
                        margin-top: 50px;
                    }
                </style>
            </head>

            <body>
                <!-- Header -->
                <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
                    <div class="container">
                        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-newspaper"></i> ASM News
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/">Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/news">Tin
                                        tức</a>
                                </li>
                                <c:forEach var="category" items="${categories}">
                                    <li class="nav-item">
                                        <a class="nav-link"
                                            href="${pageContext.request.contextPath}/news?action=category&id=${category.id}">
                                            ${category.name}
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>

                            <ul class="navbar-nav">
                                <c:choose>
                                    <c:when test="${sessionScope.currentUser != null}">
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown">
                                                <i class="fas fa-user"></i> ${sessionScope.currentUser.fullname}
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/admin">
                                                        <i class="fas fa-tachometer-alt"></i> Quản trị
                                                    </a></li>
                                                <li>
                                                    <hr class="dropdown-divider">
                                                </li>
                                                <li><a class="dropdown-item"
                                                        href="${pageContext.request.contextPath}/logout">
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
                    </div>
                </nav>

                <!-- Main Content -->
                <main class="container my-4">
                    <!-- Page Title -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <h1 class="mb-3">
                                <c:if test="${not empty category}">
                                    <i class="fas fa-tag text-primary"></i> ${pageTitle}
                                </c:if>
                                <c:if test="${empty category}">
                                    <i class="fas fa-newspaper text-primary"></i> ${pageTitle}
                                </c:if>
                            </h1>
                        </div>
                    </div>

                    <!-- News List -->
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty newsList}">
                                <c:forEach var="news" items="${newsList}">
                                    <div class="col-lg-6 mb-4">
                                        <div class="card news-card h-100">
                                            <c:if test="${not empty news.image}">
                                                <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                    class="card-img-top news-image" alt="${news.title}">
                                            </c:if>
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                        class="text-decoration-none">
                                                        ${news.title}
                                                    </a>
                                                </h5>
                                                <p class="card-text flex-grow-1">${news.getShortContent(150)}</p>
                                                <div class="news-meta mt-auto">
                                                    <small>
                                                        <i class="fas fa-user"></i> ${news.authorName} |
                                                        <i class="fas fa-calendar"></i>
                                                        <fmt:formatDate value="${news.postedDate}"
                                                            pattern="dd/MM/yyyy" /> |
                                                        <i class="fas fa-eye"></i> ${news.viewCount} lượt xem |
                                                        <i class="fas fa-tag"></i> ${news.categoryName}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="col-12">
                                    <div class="text-center py-5">
                                        <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                        <h5 class="text-muted">Chưa có tin tức nào</h5>
                                        <p class="text-muted">
                                            <c:if test="${not empty category}">
                                                Chưa có tin tức nào trong chuyên mục ${category.name}
                                            </c:if>
                                            <c:if test="${empty category}">
                                                Chưa có tin tức nào được đăng
                                            </c:if>
                                        </p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </main>

                <!-- Footer -->
                <footer class="footer">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <h5><i class="fas fa-newspaper"></i> ASM News</h5>
                                <p>Website tin tức 24h cập nhật nhanh nhất</p>
                            </div>
                            <div class="col-md-6">
                                <h5>Đăng ký nhận tin</h5>
                                <form action="${pageContext.request.contextPath}/newsletter" method="post"
                                    class="d-flex">
                                    <input type="hidden" name="action" value="subscribe">
                                    <input type="email" name="email" class="form-control me-2"
                                        placeholder="Email của bạn" required>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-paper-plane"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <hr class="my-4">
                        <div class="row">
                            <div class="col-12 text-center">
                                <p>&copy; 2025 ASM News. All rights reserved. | Developed by FPT Polytechnic Student</p>
                            </div>
                        </div>
                    </div>
                </footer>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>