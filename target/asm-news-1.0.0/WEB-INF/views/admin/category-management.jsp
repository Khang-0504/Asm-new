<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý chuyên mục - ASM News Admin</title>

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
                                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/news">
                                        <i class="fas fa-newspaper"></i> Quản lý tin tức
                                    </a>
                                    <c:if test="${sessionScope.currentUser.role}">
                                        <a class="nav-link active"
                                            href="${pageContext.request.contextPath}/admin/categories">
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
                                    <h4 class="mb-0">Quản lý chuyên mục</h4>
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
                                <div class="row">
                                    <!-- Add Category Form -->
                                    <div class="col-md-4">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-plus"></i> Thêm chuyên mục mới
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <form action="${pageContext.request.contextPath}/admin/categories/save"
                                                    method="post">
                                                    <div class="mb-3">
                                                        <label for="categoryId" class="form-label">
                                                            <i class="fas fa-key"></i> Mã chuyên mục <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="categoryId"
                                                            name="id" required maxlength="50"
                                                            placeholder="VD: SPORT, TECH">
                                                    </div>
                                                    <div class="mb-3">
                                                        <label for="categoryName" class="form-label">
                                                            <i class="fas fa-tag"></i> Tên chuyên mục <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="categoryName"
                                                            name="name" required maxlength="255"
                                                            placeholder="VD: Thể thao, Công nghệ">
                                                    </div>
                                                    <button type="submit" class="btn btn-primary w-100">
                                                        <i class="fas fa-save"></i> Thêm chuyên mục
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Categories List -->
                                    <div class="col-md-8">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-list"></i> Danh sách chuyên mục
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty categories}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Mã chuyên mục</th>
                                                                        <th>Tên chuyên mục</th>
                                                                        <th>Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="category" items="${categories}">
                                                                        <tr>
                                                                            <td><code>${category.id}</code></td>
                                                                            <td><strong>${category.name}</strong></td>
                                                                            <td>
                                                                                <button type="button"
                                                                                    class="btn btn-sm btn-outline-primary"
                                                                                    onclick="editCategory('${category.id}', '${category.name}')"
                                                                                    title="Sửa">
                                                                                    <i class="fas fa-edit"></i>
                                                                                </button>
                                                                                <button type="button"
                                                                                    class="btn btn-sm btn-outline-danger"
                                                                                    onclick="deleteCategory('${category.id}', '${category.name}')"
                                                                                    title="Xóa">
                                                                                    <i class="fas fa-trash"></i>
                                                                                </button>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="text-center py-5">
                                                            <i class="fas fa-tags fa-3x text-muted mb-3"></i>
                                                            <h5 class="text-muted">Chưa có chuyên mục nào</h5>
                                                            <p class="text-muted">Hãy thêm chuyên mục đầu tiên</p>
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

                <!-- Edit Modal -->
                <div class="modal fade" id="editModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Sửa chuyên mục</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/categories/save" method="post">
                                <div class="modal-body">
                                    <input type="hidden" id="editId" name="id">
                                    <div class="mb-3">
                                        <label for="editName" class="form-label">Tên chuyên mục</label>
                                        <input type="text" class="form-control" id="editName" name="name" required>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Modal -->
                <div class="modal fade" id="deleteModal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Xác nhận xóa</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p>Bạn có chắc chắn muốn xóa chuyên mục "<span id="deleteName"></span>"?</p>
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
                    function editCategory(id, name) {
                        document.getElementById('editId').value = id;
                        document.getElementById('editName').value = name;
                        const modal = new bootstrap.Modal(document.getElementById('editModal'));
                        modal.show();
                    }

                    function deleteCategory(id, name) {
                        document.getElementById('deleteName').textContent = name;
                        document.getElementById('confirmDelete').onclick = function () {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/categories/delete';

                            const idInput = document.createElement('input');
                            idInput.type = 'hidden';
                            idInput.name = 'id';
                            idInput.value = id;

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