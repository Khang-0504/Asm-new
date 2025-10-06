package com.example.asmnews.servlet;

import com.example.asmnews.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Base servlet chứa các phương thức tiện ích chung
 */
public abstract class BaseServlet extends HttpServlet {

    /**
     * Forward đến JSP view
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @param path     Đường dẫn đến JSP
     * @throws ServletException
     * @throws IOException
     */
    protected void forward(HttpServletRequest request, HttpServletResponse response, String path)
            throws ServletException, IOException {
        request.getRequestDispatcher(path).forward(request, response);
    }

    /**
     * Redirect đến URL khác
     * 
     * @param response HttpServletResponse
     * @param url      URL cần redirect
     * @throws IOException
     */
    protected void redirect(HttpServletResponse response, String url) throws IOException {
        response.sendRedirect(url);
    }

    /**
     * Lấy user hiện tại từ session
     * 
     * @param request HttpServletRequest
     * @return User hoặc null nếu chưa đăng nhập
     */
    protected User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("currentUser");
        }
        return null;
    }

    /**
     * Kiểm tra user đã đăng nhập chưa
     * 
     * @param request HttpServletRequest
     * @return true nếu đã đăng nhập
     */
    protected boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }

    /**
     * Kiểm tra user có phải admin không
     * 
     * @param request HttpServletRequest
     * @return true nếu là admin
     */
    protected boolean isAdmin(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null && user.isAdmin();
    }

    /**
     * Kiểm tra user có phải phóng viên không
     * 
     * @param request HttpServletRequest
     * @return true nếu là phóng viên
     */
    protected boolean isReporter(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null && user.isReporter();
    }

    /**
     * Kiểm tra quyền truy cập (admin hoặc phóng viên)
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @return true nếu có quyền truy cập
     * @throws IOException
     */
    protected boolean checkAccess(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!isLoggedIn(request)) {
            redirect(response, request.getContextPath() + "/login");
            return false;
        }
        return true;
    }

    /**
     * Kiểm tra quyền admin
     * 
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @return true nếu là admin
     * @throws IOException
     */
    protected boolean checkAdminAccess(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        if (!isLoggedIn(request)) {
            redirect(response, request.getContextPath() + "/login");
            return false;
        }
        if (!isAdmin(request)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này");
            return false;
        }
        return true;
    }

    /**
     * Set thông báo thành công
     * 
     * @param request HttpServletRequest
     * @param message Thông báo
     */
    protected void setSuccessMessage(HttpServletRequest request, String message) {
        request.getSession().setAttribute("successMessage", message);
    }

    /**
     * Set thông báo lỗi
     * 
     * @param request HttpServletRequest
     * @param message Thông báo lỗi
     */
    protected void setErrorMessage(HttpServletRequest request, String message) {
        request.getSession().setAttribute("errorMessage", message);
    }

    /**
     * Lấy parameter từ request, trả về giá trị mặc định nếu null
     * 
     * @param request      HttpServletRequest
     * @param name         Tên parameter
     * @param defaultValue Giá trị mặc định
     * @return Giá trị parameter
     */
    protected String getParameter(HttpServletRequest request, String name, String defaultValue) {
        String value = request.getParameter(name);
        return value != null && !value.trim().isEmpty() ? value.trim() : defaultValue;
    }

    /**
     * Lấy parameter integer từ request
     * 
     * @param request      HttpServletRequest
     * @param name         Tên parameter
     * @param defaultValue Giá trị mặc định
     * @return Giá trị integer
     */
    protected int getIntParameter(HttpServletRequest request, String name, int defaultValue) {
        String value = request.getParameter(name);
        if (value != null && !value.trim().isEmpty()) {
            try {
                return Integer.parseInt(value.trim());
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        return defaultValue;
    }

    /**
     * Lấy parameter boolean từ request
     * 
     * @param request HttpServletRequest
     * @param name    Tên parameter
     * @return true nếu parameter tồn tại và có giá trị
     */
    protected boolean getBooleanParameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        return value != null && ("true".equalsIgnoreCase(value) || "1".equals(value) || "on".equalsIgnoreCase(value));
    }
}
