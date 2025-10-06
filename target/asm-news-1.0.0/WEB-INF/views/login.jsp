<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Đăng nhập - ASM News</title>

            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

            <style>
                body {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                }

                .login-card {
                    background: white;
                    border-radius: 15px;
                    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                .login-header {
                    background: linear-gradient(45deg, #007bff, #0056b3);
                    color: white;
                    padding: 2rem;
                    text-align: center;
                }

                .login-body {
                    padding: 2rem;
                }

                .form-control:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
                }

                .btn-login {
                    background: linear-gradient(45deg, #007bff, #0056b3);
                    border: none;
                    padding: 12px;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .btn-login:hover {
                    background: linear-gradient(45deg, #0056b3, #004085);
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
                }

                .back-home {
                    position: absolute;
                    top: 20px;
                    left: 20px;
                    color: white;
                    text-decoration: none;
                    font-size: 1.1rem;
                }

                .back-home:hover {
                    color: #f8f9fa;
                    text-decoration: none;
                }
            </style>
        </head>

        <body>
            <a href="${pageContext.request.contextPath}/" class="back-home">
                <i class="fas fa-arrow-left"></i> Về trang chủ
            </a>

            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-5">
                        <div class="login-card">
                            <div class="login-header">
                                <h3 class="mb-0">
                                    <i class="fas fa-newspaper"></i> ASM News
                                </h3>
                                <p class="mb-0 mt-2">Đăng nhập hệ thống quản trị</p>
                            </div>

                            <div class="login-body">
                                <!-- Error Message -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <!-- Success Message -->
                                <c:if test="${sessionScope.successMessage != null}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                    <c:remove var="successMessage" scope="session" />
                                </c:if>

                                <form action="${pageContext.request.contextPath}/login" method="post">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">
                                            <i class="fas fa-user"></i> Tên đăng nhập
                                        </label>
                                        <input type="text" class="form-control" id="username" name="username"
                                            value="${username}" required autofocus placeholder="Nhập tên đăng nhập">
                                    </div>

                                    <div class="mb-4">
                                        <label for="password" class="form-label">
                                            <i class="fas fa-lock"></i> Mật khẩu
                                        </label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required placeholder="Nhập mật khẩu">
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-login w-100">
                                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                    </button>
                                </form>

                                <hr class="my-4">
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