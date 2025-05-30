package controller;

import dao.SettingDAO;
import entity.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "GetSettingListSetvlet", urlPatterns = {"/get-setting-list"})
public class GetSettingListSetvlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SettingDAO settingDAO = new SettingDAO();
        //Get all settings from database and set to request attribute
        ArrayList<Setting> settings = settingDAO.getAllSettings();
        request.setAttribute("settings", settings);
        request.getRequestDispatcher("setting_list.jsp").forward(request, response);
    }
}
