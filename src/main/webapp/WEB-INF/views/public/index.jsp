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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <style>
        :root {
            --primary-color: #1a365d;
            --secondary-color: #2563eb;
            --accent-color: #dc2626;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --bg-light: #f8fafc;
            --bg-white: #ffffff;
            --border-light: #e2e8f0;
            --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: var(--bg-light);
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: var(--text-primary);
            line-height: 1.6;
        }

        /* Professional Navbar */
        .navbar {
            background-color: var(--bg-white);
            box-shadow: var(--shadow-sm);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border-light);
            transition: all 0.3s ease;
        }
        .navbar-nav .nav-link:hover::after,
.navbar-nav .nav-link.active::after {
    width: 80%;
}

        .navbar.scrolled {
            box-shadow: var(--shadow-md);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            transition: color 0.3s ease;
            letter-spacing: -0.5px;
        }

        .navbar-brand:hover {
            color: var(--secondary-color);
        }

        .navbar-brand i {
            color: var(--secondary-color);
            margin-right: 8px;
        }

        .navbar-nav .nav-link {
            color: var(--text-primary) !important;
            font-weight: 500;
            font-size: 0.95rem;
            margin: 0 0.25rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background-color: var(--bg-light);
            color: var(--secondary-color) !important;
        }

        .dropdown-menu {
            border: 1px solid var(--border-light);
            box-shadow: var(--shadow-lg);
            border-radius: 8px;
            padding: 0.5rem;
        }

        .dropdown-item {
            border-radius: 6px;
            padding: 0.5rem 1rem;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .dropdown-item:hover {
            background-color: var(--bg-light);
            color: var(--secondary-color);
        }

        /* Elegant Carousel */
        #homeCarousel {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            margin-bottom: 2rem;
            position: relative;
        }

        #homeCarousel::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, transparent 40%, rgba(0,0,0,0.6) 100%);
            pointer-events: none;
            z-index: 1;
        }

        #homeCarousel .carousel-item img {
            width: 100%;
            height: 500px;
            object-fit: cover;
            transition: transform 0.7s ease;
        }

        #homeCarousel .carousel-item.active img {
            animation: smoothZoom 0.8s ease-out;
        }

        @keyframes smoothZoom {
            from {
                transform: scale(1.08);
            }
            to {
                transform: scale(1);
            }
        }

        #homeCarousel .carousel-caption {
            position: absolute;
            bottom: 18rem;
            left: 3rem;
            right: auto;
            top: auto;
            transform: none;
            width: 45%;
            text-align: left;
           background: rgba(0, 0, 0, 0.5);
            color: var(--text-primary);
            border-radius: 12px;
            padding: 2rem;
            box-shadow: var(--shadow-lg);
            z-index: 2;
            border-left: 4px solid var(--secondary-color);
            opacity: 0;
            transition: all 0.6s ease;
             backdrop-filter: blur(10px); /* tạo hiệu ứng mờ */
        }

        #homeCarousel .carousel-item.active .carousel-caption {
            opacity: 1;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        #homeCarousel .carousel-caption h5 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 1rem;
           color: white;
            line-height: 1.3;
        }

        #homeCarousel .carousel-caption h5 a {
              color: white;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        #homeCarousel .carousel-caption h5 a:hover {
            color: var(--secondary-color);
        }

        #homeCarousel .carousel-caption p {
              color: white;
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 0;
        }

        #homeCarousel .carousel-control-prev,
        #homeCarousel .carousel-control-next {
            width: 50px;
            height: 50px;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 50%;
            opacity: 0;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        #homeCarousel:hover .carousel-control-prev,
        #homeCarousel:hover .carousel-control-next {
            opacity: 0.9;
        }

        #homeCarousel .carousel-control-prev {
            left: 1.5rem;
        }

        #homeCarousel .carousel-control-next {
            right: 1.5rem;
        }

        #homeCarousel .carousel-control-prev:hover,
        #homeCarousel .carousel-control-next:hover {
            opacity: 1;
            background-color: var(--secondary-color);
        }

        .carousel-control-prev-icon,
        .carousel-control-next-icon {
            filter: invert(1);
            width: 20px;
            height: 20px;
        }

        #homeCarousel .carousel-control-prev:hover .carousel-control-prev-icon,
        #homeCarousel .carousel-control-next:hover .carousel-control-next-icon {
            filter: invert(0);
        }

        /* Refined News Cards */
        .news-card {
            border: 1px solid var(--border-light);
            border-radius: 12px;
            overflow: hidden;
            background: var(--bg-white);
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            height: 100%;
        }

        .news-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: var(--secondary-color);
        }

        .news-image {
            height: 220px;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .news-card:hover .news-image {
            transform: scale(1.08);
        }

        .news-card .card-body {
            padding: 1.5rem;
        }

        .news-card .card-title a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            line-height: 1.4;
            display: block;
            transition: color 0.3s ease;
        }

        .news-card:hover .card-title a {
            color: var(--secondary-color);
        }

        .news-card .card-text {
            color: var(--text-secondary);
            font-size: 0.95rem;
            line-height: 1.6;
            margin-top: 0.75rem;
        }

        /* Professional Section Titles */
        .section-title {
            position: relative;
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            color: var(--text-primary);
            border-bottom: 2px solid var(--border-light);
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 80px;
            height: 2px;
            background-color: var(--secondary-color);
        }

        .section-title i {
            color: var(--secondary-color);
            margin-right: 0.75rem;
        }

        /* Elegant Sidebar Widgets */
        .sidebar-widget {
            background: var(--bg-white);
            border-radius: 12px;
            padding: 1.75rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-light);
            transition: all 0.3s ease;
        }

        .sidebar-widget:hover {
            box-shadow: var(--shadow-md);
        }

        .widget-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-light);
        }

        .widget-title i {
            color: var(--secondary-color);
            margin-right: 0.5rem;
        }

        /* Refined Most Viewed Items */
        .most-viewed-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-light);
            transition: all 0.3s ease;
        }

        .most-viewed-item:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .most-viewed-item:hover {
            background-color: var(--bg-light);
            padding-left: 0.75rem;
            margin-left: -0.75rem;
            margin-right: -0.75rem;
            padding-right: 0.75rem;
            border-radius: 8px;
        }

        .most-viewed-badge {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--secondary-color);
            color: white;
            border-radius: 8px;
            font-weight: 700;
            font-size: 0.9rem;
            flex-shrink: 0;
        }

        .most-viewed-item h6 {
            margin-bottom: 0.5rem;
        }

        .most-viewed-item h6 a {
            color: var(--text-primary);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 600;
            line-height: 1.4;
            transition: color 0.3s ease;
        }

        .most-viewed-item h6 a:hover {
            color: var(--secondary-color);
        }

        /* Professional Newsletter Form */
        .newsletter-form input {
            border: 1px solid var(--border-light);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .newsletter-form input:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            outline: none;
        }

        .newsletter-form button {
            background-color: var(--secondary-color);
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
        }

        .newsletter-form button:hover {
            background-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Elegant Footer */
        .footer {
            background-color: var(--primary-color);
            color: #cbd5e1;
            padding: 3rem 0 1.5rem;
            margin-top: 4rem;
            border-top: 4px solid var(--secondary-color);
        }

        .footer h5 {
            color: white;
            font-weight: 700;
            margin-bottom: 1.5rem;
            font-size: 1.25rem;
        }

        .footer p {
            color: #cbd5e1;
            line-height: 1.7;
        }

        .footer a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: white;
        }

        .footer .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .footer .social-links a:hover {
            background-color: var(--secondary-color);
            color: white;
            transform: translateY(-3px);
        }

        .footer input {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            border-radius: 8px;
            padding: 10px 16px;
        }

        .footer input::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .footer input:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
            outline: none;
            background-color: rgba(255, 255, 255, 0.15);
        }

        .footer button {
            background-color: var(--secondary-color);
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            color: white;
            transition: all 0.3s ease;
        }

        .footer button:hover {
            background-color: white;
            color: var(--primary-color);
        }

        .footer hr {
            border-color: rgba(255, 255, 255, 0.1);
            margin: 2rem 0;
        }

        /* Professional Alerts */
        .alert {
            border-radius: 10px;
            border: none;
            box-shadow: var(--shadow-sm);
            padding: 1rem 1.25rem;
        }

        .alert i {
            margin-right: 0.5rem;
        }

        /* News Meta Information */
        .news-meta {
            color: var(--text-secondary);
            font-size: 0.875rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-light);
        }

        .news-meta i {
            color: var(--secondary-color);
            margin-right: 5px;
        }

        /* List Group Styling */
        .list-group-item {
            border: none;
            border-radius: 8px !important;
            margin-bottom: 0.5rem;
            padding: 0.875rem 1rem;
            color: var(--text-primary);
            font-weight: 500;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            background-color: var(--bg-light);
        }

        .list-group-item:hover {
            background-color: var(--secondary-color);
            color: white;
            transform: translateX(8px);
        }

        .list-group-item i {
            font-size: 0.85rem;
            opacity: 0.7;
            transition: opacity 0.3s ease;
        }

        .list-group-item:hover i {
            opacity: 1;
        }

        /* Responsive Design */
        @media (max-width: 991px) {
            #homeCarousel .carousel-caption {
                width: 70%;
                padding: 1.5rem;
                bottom: 2rem;
                left: 2rem;
            }
            
            #homeCarousel .carousel-caption h5 {
                font-size: 1.4rem;
            }

            #homeCarousel .carousel-caption p {
                font-size: 0.9rem;
            }
        }

        @media (max-width: 575px) {
            #homeCarousel .carousel-caption {
                bottom: 1rem;
                left: 1rem;
                right: 1rem;
                width: calc(100% - 2rem);
                padding: 1.25rem;
            }

            #homeCarousel .carousel-item img {
                height: 400px;
            }

            #homeCarousel .carousel-caption h5 {
                font-size: 1.2rem;
            }

            #homeCarousel .carousel-caption p {
                font-size: 0.85rem;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .navbar-brand {
                font-size: 1.3rem;
            }
        }

        /* Smooth Transitions */
        * {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
    </style>
</head>

<body>
    
    <!-- Header -->
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-newspaper"></i> ASM News
            </a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
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
                                   <i class="fas fa-user-circle"></i> ${sessionScope.currentUser.fullname}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item"
                                           href="${pageContext.request.contextPath}/admin">
                                           <i class="fas fa-tachometer-alt"></i> Quản trị
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
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
    
    <!-- Slider -->
    <div class="container mt-4">
        <div id="homeCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <c:forEach var="news" items="${homeNews}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <img src="${pageContext.request.contextPath}/upload/${news.image}" 
                                 class="d-block w-100" 
                                 alt="${news.title}">
                            <div class="carousel-caption">
                                <h5>
                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}">
                                       ${news.title}
                                    </a>
                                </h5>
                                <p>${news.getShortContent(120)}</p>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#homeCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Trước</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#homeCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Tiếp</span>
            </button>
        </div>
    </div>

    <!-- Main Content -->
    <main class="container my-5">
        <div class="row">
            <!-- Main Content -->
            <div class="col-lg-8">
                <!-- Hero Section -->
                <c:if test="${not empty homeNews}">
                    <div class="mb-5">
                        <h2 class="section-title">
                            <i class="fas fa-star"></i> Tin nổi bật
                        </h2>
                        <div class="row">
                            <c:forEach var="news" items="${homeNews}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <div class="col-md-${status.index == 0 ? '12' : '6'} mb-4">
                                        <div class="card news-card">
                                            <c:if test="${not empty news.image}">
                                                <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                                    class="card-img-top news-image" alt="${news.title}">
                                            </c:if>
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}">
                                                        ${news.title}
                                                    </a>
                                                </h5>
                                                <p class="card-text">${news.getShortContent(150)}</p>
                                                <div class="news-meta">
                                                    <small>
                                                        <i class="fas fa-user"></i> ${news.authorName} |
                                                        <i class="fas fa-calendar"></i>
                                                        <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy" /> |
                                                        <i class="fas fa-eye"></i> ${news.viewCount} |
                                                        <i class="fas fa-tag"></i> ${news.categoryName}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <!-- Latest News -->
                <div>
                    <h3 class="section-title">
                        <i class="fas fa-clock"></i> Tin mới nhất
                    </h3>
                    <div class="row">
                        <c:forEach var="news" items="${latestNews}">
                            <div class="col-md-6 mb-4">
                                <div class="card news-card">
                                    <c:if test="${not empty news.image}">
                                        <img src="${pageContext.request.contextPath}/upload/${news.image}"
                                            class="card-img-top news-image" alt="${news.title}">
                                    </c:if>
                                    <div class="card-body d-flex flex-column">
                                        <h6 class="card-title">
                                            <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}">
                                                ${news.title}
                                            </a>
                                        </h6>
                                        <p class="card-text flex-grow-1">${news.getShortContent(100)}</p>
                                        <div class="news-meta mt-auto">
                                            <small>
                                                <i class="fas fa-calendar"></i>
                                                <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy" /> |
                                                <i class="fas fa-eye"></i> ${news.viewCount}
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="col-lg-4">
                <!-- Most Viewed News -->
                <div class="sidebar-widget">
                    <h5 class="widget-title">
                        <i class="fas fa-fire"></i> Tin được xem nhiều
                    </h5>
                    <c:forEach var="news" items="${mostViewedNews}" varStatus="status">
                        <div class="most-viewed-item">
                            <div class="most-viewed-badge">${status.index + 1}</div>
                            <div class="flex-grow-1">
                                <h6>
                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}">
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
                        <i class="fas fa-list"></i> Chuyên mục
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
                        <i class="fas fa-envelope"></i> Đăng ký nhận tin
                    </h5>
                    <p class="mb-3 text-muted">Nhận tin tức mới nhất qua email của bạn</p>
                    <form action="${pageContext.request.contextPath}/newsletter" method="post" class="newsletter-form">
                        <input type="hidden" name="action" value="subscribe">
                        <div class="mb-3">
                            <input type="email" name="email" class="form-control"
                                placeholder="Nhập email của bạn" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-paper-plane"></i> Đăng ký ngay
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container py-4">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5><i class="fas fa-newspaper"></i> ASM News</h5>
                    <p>Website tin tức hàng đầu Việt Nam, cập nhật 24/7 các thông tin mới nhất về chính trị, kinh tế, văn hóa, thể thao và công nghệ.</p>
                    <div class="social-links mt-3">
                        <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" title="Twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                        <a href="#" title="YouTube"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Liên kết nhanh</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
                        <li class="mb-2"><a href="${pageContext.request.contextPath}/news">Tin tức</a></li>
                        <li class="mb-2"><a href="#">Về chúng tôi</a></li>
                        <li class="mb-2"><a href="#">Liên hệ</a></li>
                        <li class="mb-2"><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Đăng ký nhận tin</h5>
                    <p class="mb-3">Cập nhật tin tức mới nhất vào email của bạn</p>
                    <form action="${pageContext.request.contextPath}/newsletter" method="post" class="d-flex gap-2">
                        <input type="hidden" name="action" value="subscribe">
                        <input type="email" name="email" class="form-control flex-grow-1"
                            placeholder="Email của bạn" required>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-12 text-center">
                    <p class="mb-0">&copy; 2025 ASM News. All rights reserved. | Developed by FPT Polytechnic Student</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });
        });
    </script>
</body>

</html>