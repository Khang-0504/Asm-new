<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý tin tức - ASM News Admin</title>

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

                    .main-content {
                        background-color: #f8f9fa;
                        min-height: 100vh;
                    }

                    .navbar-admin {
                        background: white;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                    }

                    .news-image-preview {
                        max-width: 200px;
                        max-height: 150px;
                        border-radius: 8px;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                    }

                    .upload-area {
                        border: 2px dashed #dee2e6;
                        border-radius: 8px;
                        padding: 2rem;
                        text-align: center;
                        transition: all 0.3s ease;
                        cursor: pointer;
                    }

                    .upload-area:hover {
                        border-color: #007bff;
                        background-color: #f8f9fa;
                    }

                    .upload-area.dragover {
                        border-color: #007bff;
                        background-color: #e3f2fd;
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
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                        <i class="fas fa-tachometer-alt"></i> Dashboard
                                    </a>
                                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin/news">
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
                                    <h4 class="mb-0">Quản lý tin tức</h4>
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

                            <!-- Content -->
                            <div class="container-fluid p-4">
                                <!-- Add News Button -->
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <a href="${pageContext.request.contextPath}/admin/news/add"
                                            class="btn btn-primary">
                                            <i class="fas fa-plus"></i> Thêm tin tức mới
                                        </a>
                                    </div>
                                </div>

                                <!-- News List -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-list"></i> Danh sách tin tức
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty newsList}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Hình ảnh</th>
                                                                        <th>Tiêu đề</th>
                                                                        <th>Tác giả</th>
                                                                        <th>Chuyên mục</th>
                                                                        <th>Ngày đăng</th>
                                                                        <th>Lượt xem</th>
                                                                        <th>Trạng thái</th>
                                                                        <th>Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="news" items="${newsList}">
                                                                        <tr>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not empty news.image}">
                                                                                        <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                                                            class="news-image-preview"
                                                                                            alt="${news.title}">
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div class="bg-light p-2 rounded text-center"
                                                                                            style="width: 80px; height: 60px;">
                                                                                            <i
                                                                                                class="fas fa-image text-muted"></i>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <strong>${news.title}</strong>
                                                                                <br>
                                                                                <small
                                                                                    class="text-muted">${news.getShortContent(50)}...</small>
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
                                                                                <c:choose>
                                                                                    <c:when test="${news.home}">
                                                                                        <span
                                                                                            class="badge bg-warning">Trang
                                                                                            chủ</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge bg-info">Thường</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <div class="btn-group" role="group">
                                                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                                                                        class="btn btn-sm btn-outline-info"
                                                                                        target="_blank" title="Xem">
                                                                                        <i class="fas fa-eye"></i>
                                                                                    </a>
                                                                                    <a href="${pageContext.request.contextPath}/admin/news/edit?id=${news.id}"
                                                                                        class="btn btn-sm btn-outline-primary"
                                                                                        title="Sửa">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </a>
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-outline-danger"
                                                                                        onclick="deleteNews('${news.id}', '${news.title}')"
                                                                                        title="Xóa">
                                                                                        <i class="fas fa-trash"></i>
                                                                                    </button>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-5">
                                                            <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                                            <h5 class="text-muted">Chưa có tin tức nào</h5>
                                                            <p class="text-muted">Hãy thêm tin tức đầu tiên của bạn</p>
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

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xóa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa tin tức "<span id="newsTitle"></span>"?</p>
                                <p class="text-danger"><small>Hành động này không thể hoàn tác!</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-danger" id="confirmDelete">Xóa</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap JS -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

                <script>
                    function deleteNews(newsId, newsTitle) {
                        document.getElementById('newsTitle').textContent = newsTitle;
                        document.getElementById('confirmDelete').onclick = function () {
                            // Tạo form để submit DELETE request
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/news/delete';

                            const idInput = document.createElement('input');
                            idInput.type = 'hidden';
                            idInput.name = 'id';
                            idInput.value = newsId;

                            form.appendChild(idInput);
                            document.body.appendChild(form);
                            form.submit();
                        };

                        const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
                        modal.show();
                    }
                </script>
            </body>

            </html>