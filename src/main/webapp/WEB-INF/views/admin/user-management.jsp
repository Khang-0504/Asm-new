<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý người dùng - ASM News Admin</title>

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
                                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/categories">
                                            <i class="fas fa-tags"></i> Quản lý chuyên mục
                                        </a>
                                        <a class="nav-link active"
                                            href="${pageContext.request.contextPath}/admin/users">
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
                                    <h4 class="mb-0">Quản lý người dùng</h4>
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
                                <!-- Add User Button -->
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <button type="button" class="btn btn-primary" onclick="showAddUserModal()">
                                            <i class="fas fa-plus"></i> Thêm người dùng mới
                                        </button>
                                    </div>
                                </div>

                                <!-- Users List -->
                                <div class="row">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-list"></i> Danh sách người dùng
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${not empty users}">
                                                        <div class="table-responsive">
                                                            <table class="table table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>ID</th>
                                                                        <th>Họ tên</th>
                                                                        <th>Email</th>
                                                                        <th>Ngày sinh</th>
                                                                        <th>Giới tính</th>
                                                                        <th>Điện thoại</th>
                                                                        <th>Vai trò</th>
                                                                        <th>Thao tác</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="user" items="${users}">
                                                                        <tr>
                                                                            <td><code>${user.id}</code></td>
                                                                            <td><strong>${user.fullname}</strong></td>
                                                                            <td>${user.email}</td>
                                                                            <td>
                                                                                <c:if test="${user.birthday != null}">
                                                                                    <fmt:formatDate
                                                                                        value="${user.birthday}"
                                                                                        pattern="dd/MM/yyyy" />
                                                                                </c:if>
                                                                            </td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${user.gender}">
                                                                                        <i
                                                                                            class="fas fa-mars text-primary"></i>
                                                                                        Nam
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <i
                                                                                            class="fas fa-venus text-danger"></i>
                                                                                        Nữ
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>${user.mobile}</td>
                                                                            <td>
                                                                                <c:choose>
                                                                                    <c:when test="${user.role}">
                                                                                        <span
                                                                                            class="badge bg-danger">Quản
                                                                                            trị</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge bg-info">Phóng
                                                                                            viên</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                            <td>
                                                                                <div class="btn-group" role="group">
                                                                                    <button type="button"
                                                                                        class="btn btn-sm btn-outline-primary"
                                                                                        onclick="editUser('${user.id}', '${user.fullname}', '${user.email}', '${user.birthday}', '${user.gender}', '${user.mobile}', '${user.role}')"
                                                                                        title="Sửa">
                                                                                        <i class="fas fa-edit"></i>
                                                                                    </button>
                                                                                    <c:if
                                                                                        test="${user.id != sessionScope.currentUser.id}">
                                                                                        <button type="button"
                                                                                            class="btn btn-sm btn-outline-danger"
                                                                                            onclick="deleteUser('${user.id}', '${user.fullname}')"
                                                                                            title="Xóa">
                                                                                            <i class="fas fa-trash"></i>
                                                                                        </button>
                                                                                    </c:if>
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
                                                            <i class="fas fa-users fa-3x text-muted mb-3"></i>
                                                            <h5 class="text-muted">Chưa có người dùng nào</h5>
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

                <!-- Add/Edit User Modal -->
                <div class="modal fade" id="userModal" tabindex="-1">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="userModalTitle">Thêm người dùng mới</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
                                <div class="modal-body">
                                    <input type="hidden" id="userId" name="id">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="userFullname" class="form-label">Họ tên <span
                                                        class="text-danger">*</span></label>
                                                <input type="text" class="form-control" id="userFullname"
                                                    name="fullname" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="userEmail" class="form-label">Email <span
                                                        class="text-danger">*</span></label>
                                                <input type="email" class="form-control" id="userEmail" name="email"
                                                    required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="userPassword" class="form-label">Mật khẩu <span
                                                        class="text-danger">*</span></label>
                                                <input type="password" class="form-control" id="userPassword"
                                                    name="password" required>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="userMobile" class="form-label">Điện thoại</label>
                                                <input type="text" class="form-control" id="userMobile" name="mobile">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="userBirthday" class="form-label">Ngày sinh</label>
                                                <input type="date" class="form-control" id="userBirthday"
                                                    name="birthday">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="gender"
                                                            id="genderMale" value="true">
                                                        <label class="form-check-label" for="genderMale">Nam</label>
                                                    </div>
                                                    <div class="form-check form-check-inline">
                                                        <input class="form-check-input" type="radio" name="gender"
                                                            id="genderFemale" value="false">
                                                        <label class="form-check-label" for="genderFemale">Nữ</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Vai trò</label>
                                        <div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="role"
                                                    id="roleReporter" value="false" checked>
                                                <label class="form-check-label" for="roleReporter">Phóng viên</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="role" id="roleAdmin"
                                                    value="true">
                                                <label class="form-check-label" for="roleAdmin">Quản trị</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="submit" class="btn btn-primary" id="saveUserBtn">Thêm mới</button>
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
                                <p>Bạn có chắc chắn muốn xóa người dùng "<span id="deleteUserName"></span>"?</p>
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
                    function showAddUserModal() {
                        document.getElementById('userModalTitle').textContent = 'Thêm người dùng mới';
                        document.getElementById('saveUserBtn').textContent = 'Thêm mới';
                        document.getElementById('userId').value = '';
                        document.getElementById('userFullname').value = '';
                        document.getElementById('userEmail').value = '';
                        document.getElementById('userPassword').value = '';
                        document.getElementById('userMobile').value = '';
                        document.getElementById('userBirthday').value = '';
                        document.getElementById('genderMale').checked = true;
                        document.getElementById('roleReporter').checked = true;

                        const modal = new bootstrap.Modal(document.getElementById('userModal'));
                        modal.show();
                    }

                    function editUser(id, fullname, email, birthday, gender, mobile, role) {
                        document.getElementById('userModalTitle').textContent = 'Sửa thông tin người dùng';
                        document.getElementById('saveUserBtn').textContent = 'Cập nhật';
                        document.getElementById('userId').value = id;
                        document.getElementById('userFullname').value = fullname;
                        document.getElementById('userEmail').value = email;
                        document.getElementById('userPassword').required = false;
                        document.getElementById('userMobile').value = mobile || '';
                        document.getElementById('userBirthday').value = birthday || '';

                        if (gender) {
                            document.getElementById('genderMale').checked = true;
                        } else {
                            document.getElementById('genderFemale').checked = true;
                        }

                        if (role) {
                            document.getElementById('roleAdmin').checked = true;
                        } else {
                            document.getElementById('roleReporter').checked = true;
                        }

                        const modal = new bootstrap.Modal(document.getElementById('userModal'));
                        modal.show();
                    }

                    function deleteUser(id, fullname) {
                        document.getElementById('deleteUserName').textContent = fullname;
                        document.getElementById('confirmDelete').onclick = function () {
                            const form = document.createElement('form');
                            form.method = 'POST';
                            form.action = '${pageContext.request.contextPath}/admin/users/delete';

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