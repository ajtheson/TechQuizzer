package controller.setting;

import dao.SettingDAO;
import entity.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "GetSettingDetailServlet", urlPatterns = {"/get-setting-detail"})
public class GetSettingDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        SettingDAO settingDAO = new SettingDAO();
        Setting setting = settingDAO.getSettingById(id);
        request.setAttribute("setting", setting);
        request.getRequestDispatcher("setting_detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
