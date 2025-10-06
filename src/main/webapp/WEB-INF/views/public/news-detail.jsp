<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${news.title} - ASM News</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Font Awesome -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    .navbar-brand {
                        font-weight: bold;
                        color: #007bff !important;
                    }

                    .news-image {
                        width: 100%;
                        height: 400px;
                        object-fit: cover;
                        border-radius: 8px;
                    }

                    .news-content {
                        font-size: 1.1em;
                        line-height: 1.8;
                    }

                    .news-meta {
                        color: #6c757d;
                        font-size: 0.9em;
                    }

                    .related-news-card {
                        transition: transform 0.2s;
                    }

                    .related-news-card:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
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

                <!-- Main Content -->
                <main class="container my-4">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-8">
                            <!-- Breadcrumb -->
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Trang
                                            chủ</a></li>
                                    <li class="breadcrumb-item"><a
                                            href="${pageContext.request.contextPath}/news?action=category&id=${news.categoryId}">${news.categoryName}</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">${news.title}</li>
                                </ol>
                            </nav>

                            <!-- News Detail -->
                            <article class="card">
                                <div class="card-body">
                                    <h1 class="card-title mb-3">${news.title}</h1>

                                    <div class="news-meta mb-4">
                                        <i class="fas fa-user"></i> ${news.authorName} |
                                        <i class="fas fa-calendar"></i>
                                        <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm" /> |
                                        <i class="fas fa-eye"></i> ${news.viewCount} lượt xem |
                                        <i class="fas fa-tag"></i> ${news.categoryName}
                                    </div>

                                    <c:if test="${not empty news.image}">
                                        <div class="mb-4">
                                            <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                class="news-image" alt="${news.title}">
                                        </div>
                                    </c:if>

                                    <div class="news-content">
                                        ${news.content}
                                    </div>
                                </div>
                            </article>

                            <!-- Related News -->
                            <c:if test="${not empty relatedNews}">
                                <div class="mt-5">
                                    <h3 class="mb-4">
                                        <i class="fas fa-newspaper text-primary"></i> Tin liên quan
                                    </h3>
                                    <div class="row">
                                        <c:forEach var="relatedNews" items="${relatedNews}">
                                            <div class="col-md-6 mb-3">
                                                <div class="card related-news-card h-100">
                                                    <c:if test="${not empty relatedNews.image}">
                                                        <img src="${pageContext.request.contextPath}/upload/${relatedNews.image}"
                                                            class="card-img-top"
                                                            style="height: 200px; object-fit: cover;"
                                                            alt="${relatedNews.title}">
                                                    </c:if>
                                                    <div class="card-body d-flex flex-column">
                                                        <h6 class="card-title">
                                                            <a href="${pageContext.request.contextPath}/news?action=detail&id=${relatedNews.id}"
                                                                class="text-decoration-none">
                                                                ${relatedNews.title}
                                                            </a>
                                                        </h6>
                                                        <p class="card-text flex-grow-1">
                                                            ${relatedNews.getShortContent(100)}</p>
                                                        <div class="news-meta mt-auto">
                                                            <small>
                                                                <i class="fas fa-calendar"></i>
                                                                <fmt:formatDate value="${relatedNews.postedDate}"
                                                                    pattern="dd/MM/yyyy" /> |
                                                                <i class="fas fa-eye"></i> ${relatedNews.viewCount}
                                                            </small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-4">
                            <!-- Categories -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-list text-success"></i> Chuyên mục
                                    </h5>
                                </div>
                                <div class="card-body">
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
                            </div>

                            <!-- Newsletter Signup -->
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="mb-0">
                                        <i class="fas fa-envelope text-info"></i> Đăng ký nhận tin
                                    </h5>
                                </div>
                                <div class="card-body">
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