package controller.setting;

import dao.SettingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleSettingStatusServlet", urlPatterns = {"/toggle-setting-status"})
public class ToggleSettingStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            SettingDAO dao = new SettingDAO();
            dao.updateStatus(id, status);

            // Chuyển hướng lại danh sách
            response.sendRedirect("settings");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            response.sendRedirect("settings");
        }
    }
}
