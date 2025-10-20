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
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-bg: #0f172a;
            --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Animated Background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(245, 87, 108, 0.1) 0%, transparent 50%);
            z-index: -1;
            animation: bgFloat 20s ease-in-out infinite;
        }

        @keyframes bgFloat {
            0%, 100% { opacity: 0.5; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.1); }
        }

        /* Enhanced Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 0.5rem 0;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.15);
        }

        .navbar-brand {
            font-size: 1.8rem;
            font-weight: 700;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            transition: transform 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
        }

        .navbar-nav .nav-link {
            color: #334155 !important;
            font-weight: 500;
            margin: 0 0.5rem;
            position: relative;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--primary-gradient);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .navbar-nav .nav-link:hover::after,
        .navbar-nav .nav-link.active::after {
            width: 80%;
        }

        .navbar-nav .nav-link:hover {
            color: #667eea !important;
            transform: translateY(-2px);
        }

        /* Modern Carousel */
        #homeCarousel {
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            position: relative;
        }

        #homeCarousel::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(180deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.3) 100%);
            z-index: 1;
            pointer-events: none;
        }

        #homeCarousel .carousel-item img {
            width: 100%;
            height: 550px;
            object-fit: cover;
            transition: transform 0.7s ease;
        }

        #homeCarousel .carousel-item.active img {
            animation: zoomIn 0.7s ease;
        }

        @keyframes zoomIn {
            from {
                transform: scale(1.1);
                opacity: 0.8;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        #homeCarousel .carousel-caption {
            position: absolute;
            top: 25%;
            left: 50px;
            right: auto;
            bottom: auto;
            transform: translateY(-50%);
            width: 30%;
            text-align: left;
     
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            z-index: 5;
            opacity: 0;
            transform: translateY(-50%) translateX(-30px);
            transition: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        #homeCarousel .carousel-item.active .carousel-caption {
            opacity: 1;
            transform: translateY(-50%) translateX(0);
        }

        #homeCarousel .carousel-caption h5 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 15px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        #homeCarousel .carousel-caption h5 a {
            color: #ffffff;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        #homeCarousel .carousel-caption h5 a:hover {
            text-shadow: 0 0 20px rgba(255, 255, 255, 0.8);
        }

        #homeCarousel .carousel-caption p {
            color: #f0f0f0;
            font-size: 1.05rem;
            line-height: 1.6;
        }

        /* Category Bar */
        .category-bar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1.5rem 0;
            margin: 2rem 0;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            overflow-x: auto;
            scrollbar-width: none;
        }

        .category-bar::-webkit-scrollbar {
            display: none;
        }

        .category-item {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 50px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            position: relative;
            overflow: hidden;
        }

        .category-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            transition: left 0.4s ease;
            z-index: -1;
        }

        .category-item:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .category-item:hover::before {
            left: 0;
        }

        /* News Cards */
        .news-card {
            transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            border: none;
            border-radius: 20px;
            overflow: hidden;
            background: white;
            box-shadow: var(--card-shadow);
            position: relative;
        }

        .news-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: 1;
        }

        .news-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: var(--hover-shadow);
        }

        .news-card:hover::before {
            opacity: 0.05;
        }

        .news-image {
            height: 220px;
            object-fit: cover;
            transition: transform 0.6s ease;
            position: relative;
        }

        .news-card:hover .news-image {
            transform: scale(1.1) rotate(1deg);
        }

        .news-card .card-body {
            padding: 1.5rem;
            position: relative;
            z-index: 2;
        }

        .news-card .card-title a {
            color: #1e293b;
            text-decoration: none;
            font-weight: 700;
            font-size: 1.15rem;
            transition: all 0.3s ease;
            display: block;
        }

        .news-card:hover .card-title a {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Section Titles */
        .section-title {
            position: relative;
            display: inline-block;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: 2px;
        }

        .section-title i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Sidebar Widgets */
        .sidebar-widget {
            background: white;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .sidebar-widget::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary-gradient);
            transition: width 0.3s ease;
        }

        .sidebar-widget:hover {
            box-shadow: var(--hover-shadow);
        }

        .sidebar-widget:hover::before {
            width: 100%;
            opacity: 0.05;
        }

        .widget-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f5f9;
        }

        .widget-title i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* Most Viewed Items */
        .most-viewed-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #f1f5f9;
            transition: all 0.3s ease;
            position: relative;
        }

        .most-viewed-item:last-child {
            border-bottom: none;
        }

        .most-viewed-item:hover {
            transform: translateX(5px);
            background: #f8fafc;
            padding-left: 10px;
            border-radius: 10px;
        }

        .most-viewed-badge {
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--primary-gradient);
            color: white;
            border-radius: 50%;
            font-weight: 700;
            flex-shrink: 0;
        }

        /* Newsletter Form */
        .newsletter-form input {
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            padding: 12px 20px;
            transition: all 0.3s ease;
        }

        .newsletter-form input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .newsletter-form button {
            background: var(--primary-gradient);
            border: none;
            border-radius: 15px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .newsletter-form button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        /* Footer */
        .footer {
            background: var(--dark-bg);
            color: #94a3b8;
            padding: 3rem 0 1rem;
            margin-top: 4rem;
            position: relative;
        }

        .footer::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
        }

        .footer h5 {
            color: #f1f5f9;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .footer input {
            background: #1e293b;
            border: 1px solid #334155;
            color: #e2e8f0;
            border-radius: 10px;
            padding: 10px 15px;
        }

        .footer input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .footer button {
            background: var(--primary-gradient);
            border: none;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .footer button:hover {
            transform: scale(1.05);
        }

        /* Alerts */
        .alert {
            border-radius: 15px;
            border: none;
            box-shadow: var(--card-shadow);
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 991px) {
            #homeCarousel .carousel-caption {
                width: 70%;
                padding: 20px;
            }
            
            #homeCarousel .carousel-caption h5 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 575px) {
            #homeCarousel .carousel-caption {
                top: auto;
                bottom: 20px;
                left: 20px;
                right: 20px;
                width: calc(100% - 40px);
                transform: none;
                padding: 15px;
            }

            #homeCarousel .carousel-item.active .carousel-caption {
                transform: none;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .category-item {
                font-size: 0.95rem;
                padding: 10px 18px;
            }
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .news-meta {
            color: #64748b;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        .news-meta i {
            color: #667eea;
            margin-right: 3px;
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
                                    <i class="fas fa-user"></i> ${sessionScope.currentUser.fullname}
                                </a>
                                <ul class="dropdown-menu">
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

    <!-- Category Bar -->
    <div class="container">
        <div class="category-bar">
            <div class="d-flex flex-wrap justify-content-center gap-3">
                <c:forEach var="category" items="${categories}">
                    <a href="${pageContext.request.contextPath}/news?action=category&id=${category.id}"
                       class="category-item">
                        <c:choose>
                            <c:when test="${category.name == 'Thể thao'}">
                                <i class="fas fa-football"></i>
                            </c:when>
                            <c:when test="${category.name == 'Kinh doanh'}">
                                <i class="bi bi-bar-chart-fill"></i>
                            </c:when>
                            <c:when test="${category.name == 'Công nghệ'}">
                                <i class="fas fa-microchip"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-tag"></i>
                            </c:otherwise>
                        </c:choose>
                        ${category.name}
                    </a>
                </c:forEach>
            </div>
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
                                        <div class="card news-card h-100">
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
                                <div class="card news-card h-100">
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
                                <h6 class="mb-1">
                                    <a href="${pageContext.request.contextPath}/news?action=detail&id=${news.id}"
                                        class="text-decoration-none text-dark">
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
                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center border-0 rounded-3 mb-2">
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
                <div class="col-md-6 mb-4">
                    <h5><i class="fas fa-newspaper"></i> ASM News</h5>
                    <p>Website tin tức 24h cập nhật nhanh nhất</p>
                    <div class="mt-3">
                        <a href="#" class="text-decoration-none me-3"><i class="fab fa-facebook fa-lg"></i></a>
                        <a href="#" class="text-decoration-none me-3"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="text-decoration-none me-3"><i class="fab fa-instagram fa-lg"></i></a>
                        <a href="#" class="text-decoration-none"><i class="fab fa-youtube fa-lg"></i></a>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <h5>Đăng ký nhận tin</h5>
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
            <hr class="my-4" style="border-color: #334155;">
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