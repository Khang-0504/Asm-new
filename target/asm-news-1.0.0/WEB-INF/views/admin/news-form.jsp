<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${news != null ? 'Sửa tin tức' : 'Thêm tin tức'} - ASM News Admin</title>

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
                        max-width: 300px;
                        max-height: 200px;
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
                        background-color: #f8f9fa;
                    }

                    .upload-area:hover {
                        border-color: #007bff;
                        background-color: #e3f2fd;
                    }

                    .upload-area.dragover {
                        border-color: #007bff;
                        background-color: #e3f2fd;
                    }

                    .upload-progress {
                        display: none;
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
                                    <h4 class="mb-0">${news != null ? 'Sửa tin tức' : 'Thêm tin tức mới'}</h4>
                                    <div class="navbar-nav ms-auto">
                                        <a href="${pageContext.request.contextPath}/admin/news"
                                            class="btn btn-outline-secondary">
                                            <i class="fas fa-arrow-left"></i> Quay lại
                                        </a>
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

                            <!-- Form Content -->
                            <div class="container-fluid p-4">
                                <div class="row">
                                    <div class="col-lg-8">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-edit"></i> Thông tin tin tức
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <form id="newsForm"
                                                    action="${pageContext.request.contextPath}/admin/news/save"
                                                    method="post">
                                                    <c:if test="${news != null}">
                                                        <input type="hidden" name="id" value="${news.id}">
                                                    </c:if>

                                                    <div class="mb-3">
                                                        <label for="title" class="form-label">
                                                            <i class="fas fa-heading"></i> Tiêu đề <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <input type="text" class="form-control" id="title" name="title"
                                                            value="${news.title}" required maxlength="500"
                                                            placeholder="Nhập tiêu đề tin tức">
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="categoryId" class="form-label">
                                                            <i class="fas fa-tags"></i> Chuyên mục <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <select class="form-select" id="categoryId" name="categoryId"
                                                            required>
                                                            <option value="">-- Chọn chuyên mục --</option>
                                                            <c:forEach var="category" items="${categories}">
                                                                <option value="${category.id}" ${news !=null &&
                                                                    news.categoryId==category.id ? 'selected' : '' }>
                                                                    ${category.name}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>

                                                    <div class="mb-3">
                                                        <label for="content" class="form-label">
                                                            <i class="fas fa-align-left"></i> Nội dung <span
                                                                class="text-danger">*</span>
                                                        </label>
                                                        <textarea class="form-control" id="content" name="content"
                                                            rows="10" required
                                                            placeholder="Nhập nội dung tin tức">${news.content}</textarea>
                                                    </div>

                                                    <div class="mb-3">
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="checkbox" id="home"
                                                                name="home" ${news !=null && news.home ? 'checked' : ''
                                                                }>
                                                            <label class="form-check-label" for="home">
                                                                <i class="fas fa-star"></i> Hiển thị trên trang chủ
                                                            </label>
                                                        </div>
                                                    </div>

                                                    <!-- Hidden input for image filename -->
                                                    <input type="hidden" id="image" name="image" value="${news.image}">

                                                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                        <a href="${pageContext.request.contextPath}/admin/news"
                                                            class="btn btn-secondary me-md-2">
                                                            <i class="fas fa-times"></i> Hủy
                                                        </a>
                                                        <button type="submit" class="btn btn-primary">
                                                            <i class="fas fa-save"></i> ${news != null ? 'Cập nhật' :
                                                            'Thêm mới'}
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="card">
                                            <div class="card-header">
                                                <h5 class="mb-0">
                                                    <i class="fas fa-image"></i> Hình ảnh
                                                </h5>
                                            </div>
                                            <div class="card-body">
                                                <!-- Current Image -->
                                                <c:if test="${news != null && not empty news.image}">
                                                    <div class="mb-3">
                                                        <label class="form-label">Hình ảnh hiện tại:</label>
                                                        <div class="text-center">
                                                            <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                                class="news-image-preview" alt="${news.title}">
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <!-- Upload Area -->
                                                <div class="upload-area" id="uploadArea">
                                                    <i class="fas fa-cloud-upload-alt fa-3x text-muted mb-3"></i>
                                                    <h6>Kéo thả ảnh vào đây hoặc click để chọn</h6>
                                                    <p class="text-muted mb-0">Hỗ trợ: JPG, PNG, GIF (tối đa 10MB)</p>
                                                    <input type="file" id="imageInput" accept="image/*"
                                                        style="display: none;">
                                                </div>

                                                <!-- Upload Progress -->
                                                <div class="upload-progress mt-3" id="uploadProgress">
                                                    <div class="progress">
                                                        <div class="progress-bar" role="progressbar" style="width: 0%">
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">Đang upload...</small>
                                                </div>

                                                <!-- Image Preview -->
                                                <div class="mt-3" id="imagePreview" style="display: none;">
                                                    <label class="form-label">Hình ảnh mới:</label>
                                                    <div class="text-center">
                                                        <img id="previewImg" class="news-image-preview" alt="Preview">
                                                    </div>
                                                    <button type="button" class="btn btn-sm btn-outline-danger mt-2"
                                                        onclick="removeImage()">
                                                        <i class="fas fa-trash"></i> Xóa ảnh
                                                    </button>
                                                </div>

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

                <script>
                    const uploadArea = document.getElementById('uploadArea');
                    const imageInput = document.getElementById('imageInput');
                    const uploadProgress = document.getElementById('uploadProgress');
                    const imagePreview = document.getElementById('imagePreview');
                    const previewImg = document.getElementById('previewImg');
                    const imageHidden = document.getElementById('image');

                    // Click to select file
                    uploadArea.addEventListener('click', () => {
                        imageInput.click();
                    });

                    // File input change
                    imageInput.addEventListener('change', (e) => {
                        const file = e.target.files[0];
                        if (file) {
                            uploadFile(file);
                        }
                    });

                    // Drag and drop
                    uploadArea.addEventListener('dragover', (e) => {
                        e.preventDefault();
                        uploadArea.classList.add('dragover');
                    });

                    uploadArea.addEventListener('dragleave', () => {
                        uploadArea.classList.remove('dragover');
                    });

                    uploadArea.addEventListener('drop', (e) => {
                        e.preventDefault();
                        uploadArea.classList.remove('dragover');

                        const files = e.dataTransfer.files;
                        if (files.length > 0) {
                            const file = files[0];
                            if (file.type.startsWith('image/')) {
                                uploadFile(file);
                            } else {
                                alert('Vui lòng chọn file ảnh!');
                            }
                        }
                    });

                    // Upload file function
                    function uploadFile(file) {
                        // Validate file size (10MB)
                        if (file.size > 10 * 1024 * 1024) {
                            alert('File quá lớn! Vui lòng chọn file nhỏ hơn 10MB.');
                            return;
                        }

                        // Validate file type
                        if (!file.type.startsWith('image/')) {
                            alert('Vui lòng chọn file ảnh!');
                            return;
                        }

                        const formData = new FormData();
                        formData.append('image', file);

                        // Show progress
                        uploadProgress.style.display = 'block';
                        const progressBar = uploadProgress.querySelector('.progress-bar');

                        // Upload file
                        fetch('${pageContext.request.contextPath}/admin/upload', {
                            method: 'POST',
                            body: formData
                        })
                            .then(response => response.json())
                            .then(data => {
                                uploadProgress.style.display = 'none';

                                if (data.filename) {
                                    // Update image input
                                    imageHidden.value = data.filename;

                                    // Show preview
                                    previewImg.src = '${pageContext.request.contextPath}/upload/' + data.filename;
                                    imagePreview.style.display = 'block';

                                    // Hide upload area
                                    uploadArea.style.display = 'none';
                                } else {
                                    alert('Lỗi upload: ' + (data.error || 'Unknown error'));
                                }
                            })
                            .catch(error => {
                                uploadProgress.style.display = 'none';
                                console.error('Error:', error);
                                alert('Có lỗi xảy ra khi upload file!');
                            });
                    }

                    // Remove image function
                    function removeImage() {
                        imageHidden.value = '';
                        imagePreview.style.display = 'none';
                        uploadArea.style.display = 'block';
                        imageInput.value = '';
                    }

                    // Form validation
                    document.getElementById('newsForm').addEventListener('submit', function (e) {
                        const title = document.getElementById('title').value.trim();
                        const content = document.getElementById('content').value.trim();
                        const categoryId = document.getElementById('categoryId').value;
                        const imageValue = document.getElementById('image').value;


                        if (!title || !content || !categoryId) {
                            e.preventDefault();
                            alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                            return false;
                        }

                        // Recommend uploading image
                        if (!imageValue || imageValue.trim() === '') {
                            if (!confirm('Bạn chưa upload ảnh. Có muốn tiếp tục không?')) {
                                e.preventDefault();
                                return false;
                            }
                        }

                    });
                </script>
            </body>

            </html>