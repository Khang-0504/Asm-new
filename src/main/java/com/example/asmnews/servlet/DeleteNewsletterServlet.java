package com.example.asmnews.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.example.asmnews.dao.NewsletterDAO;
@WebServlet("/admin/newsletters/delete")
public class DeleteNewsletterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"Email không hợp lệ!\"}");
            return;
        }
        email = email.trim().toLowerCase();

        NewsletterDAO dao = new NewsletterDAO();

        try {
            if (!dao.exists(email)) { // check trước khi xóa
                response.getWriter().write("{\"success\": false, \"message\": \"Email không tồn tại!\"}");
                System.out.println("Kiểm tra email: [" + email + "]");
                return;
            }

            boolean success = dao.delete(email);

            if (success) {
                response.getWriter().write("{\"success\": true}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Xóa thất bại!\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Kiểm tra email: [" + email + "]");
            response.getWriter().write("{\"success\": false, \"message\": \"Có lỗi xảy ra khi xóa email!\"}");
        }
    }
}


