<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Dashboard - ASM News Admin</title>

                <!-- Bootstrap CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Font Awesome -->
                <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

                <style>
                    .sidebar {
                        min-height: 100vh;
                        background: linear-gradient(180deg, #343a40 0%, #495057 100%);
                    }

                    .sidebar .nav-link {
                        color: #adb5bd;
                        padding: 0.75rem 1rem;
                        border-radius: 0.375rem;
                        margin: 0.125rem 0;
                    }

                    .sidebar .nav-link:hover,
                    .sidebar .nav-link.active {
                        color: white;
                        background-color: rgba(255, 255, 255, 0.1);
                    }

                    .stat-card {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        border-radius: 15px;
                        padding: 1.5rem;
                        margin-bottom: 1rem;
                    }

                    .stat-card.success {
                        background: linear-gradient(135deg, #56ab2f 0%, #a8e6cf 100%);
                    }

                    .stat-card.warning {
                        background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
                    }

                    .stat-card.info {
                        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    }

                    .stat-icon {
                        font-size: 2.5rem;
                        opacity: 0.8;
                    }

                    .main-content {
                        background-color: #f8f9fa;
                        min-height: 100vh;
                    }

                    .navbar-admin {
                        background: white;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    }
                </style>
            </head>

            <body>
                <div class="container-fluid">
                    <div class="row">
                        <!-- Sidebar -->
                        <div class="col-md-3 col-lg-2 px-0 sidebar">
                            <div class="p-3">
                                <h5 class="text-white mb-3">
                                    <i class="fas fa-newspaper"></i> ASM News Admin
                                </h5>

                                <nav class="nav flex-column">
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
                                        <i class="fas fa-newspaper"></i> Quản lý tin tức
                                    </a>
                                    <c:if test="${sessionScope.currentUser.role}">
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                            <i class="fas fa-tags"></i> Quản lý chuyên mục
                                        </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                            <i class="fas fa-users"></i> Quản lý người dùng
                                        </a>
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/newsletters">
                                            <i class="fas fa-envelope"></i> Quản lý Newsletter
                                        </a>
                                    </c:if>
                                    <hr class="text-white-50">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                                        <i class="fas fa-home"></i> Về trang chủ
                                    </a>
                                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                    </a>
                                </nav>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-md-9 col-lg-10 main-content">
                            <!-- Top Navbar -->
                            <nav class="navbar navbar-expand-lg navbar-admin">
                                <div class="container-fluid">
                                    <h4 class="mb-0">Dashboard</h4>
                                    <div class="navbar-nav ms-auto">
                                        <span class="navbar-text">
                                            <i class="fas fa-user"></i> Xin chào, ${sessionScope.currentUser.fullname}
                                        </span>
                                    </div>
                                </div>
                            </nav>

                            <!-- Messages -->
                            <c:if test="${sessionScope.successMessage != null}">
                                <div class="container-fluid mt-3">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </div>
                                <c:remove var="successMessage" scope="session" />
                            </c:if>

                            <c:if test="${sessionScope.errorMessage != null}">
                                <div class="container-fluid mt-3">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </div>
                                <c:remove var="errorMessage" scope="session" />
                            </c:if>

                            <!-- Dashboard Content -->
                            <div class="container-fluid p-4">
                                <!-- Statistics Cards -->
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="stat-card">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="mb-0">${totalNews}</h3>
                                                    <p class="mb-0">Tin tức</p>
                                                </div>
                                                <i class="fas fa-newspaper stat-icon"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="stat-card success">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="mb-0">${totalCategories}</h3>
                                                    <p class="mb-0">Chuyên mục</p>
                                                </div>
                                                <i class="fas fa-tags stat-icon"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="stat-card warning">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="mb-0">${totalUsers}</h3>
                                                    <p class="mb-0">Người dùng</p>
                                                </div>
                                                <i class="fas fa-users stat-icon"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-3">
                                        <div class="stat-card info">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <h3 class="mb-0">${totalNewsletters}</h3>
                                                    <p class="mb-0">Đăng ký tin</p>
                                                </div>
                                                <i class="fas fa-envelope stat-icon"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Latest News -->
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-clock"></i> Tin tức mới nhất
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty latestNews}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Tiêu đề</th>
                                                                        <th>Tác giả</th>
                                                                        <th>Chuyên mục</th>
                                                                        <th>Ngày đăng</th>
                                                                        <th>Lượt xem</th>
                                                                        <th>Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="news" items="${latestNews}">
                                                                        <tr>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                                                    class="text-decoration-none"
                                                                                    target="_blank">
                                                                                    ${news.title}
                                                                                </a>
                                                                                <c:if test="${news.home}">
                                                                                    <span
                                                                                        class="badge bg-warning ms-2">Trang
                                                                                        chủ</span>
                                                                                </c:if>
                                                                            </td>
                                                                            <td>${news.authorName}</td>
                                                                            <td>
                                                                                <span
                                                                                    class="badge bg-secondary">${news.categoryName}</span>
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatDate
                                                                                    value="${news.postedDate}"
                                                                                    pattern="dd/MM/yyyy" />
                                                                            </td>
                                                                            <td>
                                                                                <i class="fas fa-eye"></i>
                                                                                ${news.viewCount}
                                                                            </td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/admin/news/edit?id=${news.id}"
                                                                                    class="btn btn-sm btn-outline-primary">
                                                                                    <i class="fas fa-edit"></i>
                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-4">
                                                            <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                                            <p class="text-muted">Chưa có tin tức nào</p>
                                                            <a href="${pageContext.request.contextPath}/admin/news/add"
                                                                class="btn btn-primary">
                                                                <i class="fas fa-plus"></i> Thêm tin tức đầu tiên
                                                            </a>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>