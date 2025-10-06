package com.example.asmnews.servlet;

import com.example.asmnews.dao.UserDAO;
import com.example.asmnews.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet xử lý đăng nhập/đăng xuất
 */
@WebServlet(urlPatterns = { "/login", "/logout" })
public class LoginServlet extends BaseServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            handleLogout(request, response);
        } else {
            // Nếu đã đăng nhập, chuyển hướng đến trang admin
            if (isLoggedIn(request)) {
                redirect(response, request.getContextPath() + "/admin");
                return;
            }

            // Hiển thị trang đăng nhập
            forward(request, response, "/WEB-INF/views/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        handleLogin(request, response);
    }

    /**
     * Xử lý đăng nhập
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = getParameter(request, "username", "");
        String password = getParameter(request, "password", "");

        // Validate input
        if (username.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu");
            forward(request, response, "/WEB-INF/views/login.jsp");
            return;
        }

        try {
            // Thực hiện đăng nhập
            User user = userDAO.login(username, password);

            if (user != null) {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setMaxInactiveInterval(30 * 60); // 30 phút

                setSuccessMessage(request, "Đăng nhập thành công! Chào mừng " + user.getFullname());

                // Chuyển hướng đến trang admin
                redirect(response, request.getContextPath() + "/admin");

            } else {
                // Đăng nhập thất bại
                request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng");
                request.setAttribute("username", username); // Giữ lại username đã nhập
                forward(request, response, "/WEB-INF/views/login.jsp");
            }

        } catch (Exception e) {
            System.err.println("Lỗi khi đăng nhập: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi đăng nhập. Vui lòng thử lại sau.");
            forward(request, response, "/WEB-INF/views/login.jsp");
        }
    }

    /**
     * Xử lý đăng xuất
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("currentUser");
            session.invalidate();

            if (user != null) {
                setSuccessMessage(request, "Đã đăng xuất thành công. Hẹn gặp lại!");
            }
        }

        // Chuyển hướng về trang chủ
        redirect(response, request.getContextPath() + "/");
    }
}
