<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Trang chủ - ASM News</title>

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

                    .sidebar-widget {
                        background: #f8f9fa;
                        border-radius: 8px;
                        padding: 20px;
                        margin-bottom: 20px;
                    }

                    .widget-title {
                        color: #007bff;
                        border-bottom: 2px solid #007bff;
                        padding-bottom: 10px;
                        margin-bottom: 15px;
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
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/">Trang chủ</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/news">Tin tức</a>
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

                <!-- Messages -->
                <c:if test="${sessionScope.successMessage != null}">
                    <div class="container mt-3">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                    <c:remove var="successMessage" scope="session" />
                </c:if>

                <c:if test="${sessionScope.errorMessage != null}">
                    <div class="container mt-3">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                    <c:remove var="errorMessage" scope="session" />
                </c:if>

                <!-- Main Content -->
                <main class="container my-4">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <!-- Hero Section -->
                            <c:if test="${not empty homeNews}">
                                <div class="row mb-4">
                                    <div class="col-12">
                                        <h2 class="mb-3">
                                            <i class="fas fa-star text-warning"></i> Tin nổi bật
                                        </h2>
                                    </div>
                                    <c:forEach var="news" items="${homeNews}" varStatus="status">
                                        <c:if test="${status.index < 3}">
                                            <div class="col-md-${status.index == 0 ? '12' : '6'} mb-3">
                                                <div class="card news-card">
                                                    <c:if test="${not empty news.image}">
                                                        <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                            class="card-img-top news-image" alt="${news.title}">
                                                    </c:if>
                                                    <div class="card-body">
                                                        <h5 class="card-title">
                                                            <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                                class="text-decoration-none">
                                                                ${news.title}
                                                            </a>
                                                        </h5>
                                                        <p class="card-text">${news.getShortContent(150)}</p>
                                                        <div class="news-meta">
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
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </c:if>

                            <!-- Latest News -->
                            <div class="row">
                                <div class="col-12">
                                    <h3 class="mb-3">
                                        <i class="fas fa-clock text-primary"></i> Tin mới nhất
                                    </h3>
                                </div>
                                <c:forEach var="news" items="${latestNews}">
                                    <div class="col-md-6 mb-3">
                                        <div class="card news-card h-100">
                                            <c:if test="${not empty news.image}">
                                                <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                    class="card-img-top news-image" alt="${news.title}">
                                            </c:if>
                                            <div class="card-body d-flex flex-column">
                                                <h6 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                        class="text-decoration-none">
                                                        ${news.title}
                                                    </a>
                                                </h6>
                                                <p class="card-text flex-grow-1">${news.getShortContent(100)}</p>
                                                <div class="news-meta mt-auto">
                                                    <small>
                                                        <i class="fas fa-calendar"></i>
                                                        <fmt:formatDate value="${news.postedDate}"
                                                            pattern="dd/MM/yyyy" /> |
                                                        <i class="fas fa-eye"></i> ${news.viewCount}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-4">
                            <!-- Most Viewed News -->
                            <div class="sidebar-widget">
                                <h5 class="widget-title">
                                    <i class="fas fa-fire text-danger"></i> Tin được xem nhiều
                                </h5>
                                <c:forEach var="news" items="${mostViewedNews}" varStatus="status">
                                    <div class="d-flex mb-3 ${status.last ? '' : 'border-bottom pb-3'}">
                                        <div class="flex-shrink-0">
                                            <span class="badge bg-primary rounded-pill">${status.index + 1}</span>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="mb-1">
                                                <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                    class="text-decoration-none">
                                                    ${news.title}
                                                </a>
                                            </h6>
                                            <small class="text-muted">
                                                <i class="fas fa-eye"></i> ${news.viewCount} lượt xem
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <!-- Categories -->
                            <div class="sidebar-widget">
                                <h5 class="widget-title">
                                    <i class="fas fa-list text-success"></i> Chuyên mục
                                </h5>
                                <div class="list-group list-group-flush">
                                    <c:forEach var="category" items="${categories}">
                                        <a href="${pageContext.request.contextPath}/news?action=category&id=${category.id}"
                                            class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                                            ${category.name}
                                            <i class="fas fa-chevron-right"></i>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Newsletter Signup -->
                            <div class="sidebar-widget">
                                <h5 class="widget-title">
                                    <i class="fas fa-envelope text-info"></i> Đăng ký nhận tin
                                </h5>
                                <p class="mb-3">Nhận tin tức mới nhất qua email của bạn</p>
                                <form action="${pageContext.request.contextPath}/newsletter" method="post">
                                    <input type="hidden" name="action" value="subscribe">
                                    <div class="mb-3">
                                        <input type="email" name="email" class="form-control"
                                            placeholder="Nhập email của bạn" required>
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-paper-plane"></i> Đăng ký
                                    </button>
                                </form>
                            </div>
                        </div>
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