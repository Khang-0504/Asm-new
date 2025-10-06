<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${pageTitle != null ? pageTitle : 'ASM News'} - Tin tức 24h</title>

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

                    .alert-dismissible {
                        position: relative;
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
                    <jsp:include page="${contentPage}" />
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