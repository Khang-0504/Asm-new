package com.example.asmnews.servlet;


import com.example.asmnews.dao.NewsletterDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/admin/newsletters/toggle")
public class ToggleNewsletterServlet extends HttpServlet {

    private NewsletterDAO newsletterDAO;

    @Override
    public void init() throws ServletException {
        newsletterDAO = new NewsletterDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String email = request.getParameter("email");
            String enabledStr = request.getParameter("enabled");

            if (email == null || email.trim().isEmpty() || enabledStr == null) {
                out.print("{\"success\": false, \"message\": \"Thiếu thông tin!\"}");
                return;
            }

            boolean enabled = Boolean.parseBoolean(enabledStr);
            boolean result = enabled
                    ? newsletterDAO.reactivate(email)
                    : newsletterDAO.unsubscribe(email);

            if (result) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Cập nhật thất bại!\"}");
            }

        } catch (Exception e) {
            System.err.println("Lỗi khi toggle newsletter: " + e.getMessage());
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra khi cập nhật!\"}");
        }
    }

}