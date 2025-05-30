package controller;

import dao.SettingDAO;
import entity.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "EditSettingServlet", urlPatterns = {"/edit-setting"})
public class EditSettingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //get id from url
        int id = Integer.parseInt(request.getParameter("id"));

        //Get setting by id from database
        SettingDAO settingDAO = new SettingDAO();
        Setting setting = settingDAO.getSettingById(id);

        //Set attribute to request to pass to setting_edit.jsp
        request.setAttribute("id", id);
        request.setAttribute("type", setting.getType());
        request.setAttribute("value", setting.getValue ());
        request.setAttribute("order", setting.getOrder());
        request.setAttribute("description", setting.getDescription ());
        request.setAttribute("status", setting.isActivated() ? "activate" : "deactivate");
        request.getRequestDispatcher("setting_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get parameter from setting_edit form
        int id = request.getParameter("id") == null ? 0 : Integer.parseInt(request.getParameter("id"));
        String type = request.getParameter("type").trim();
        String value = request.getParameter("value").trim();
        String orderParam = request.getParameter("order").trim();
        String description = request.getParameter("description").trim();
        String status = request.getParameter("status").trim();

        String error = "";
        SettingDAO settingDAO = new SettingDAO();

        int order = 0;

        //Check input if it is empty or invalid
        if (type.isEmpty()) {
            error = "Please choose a valid type";
        }
        else if (value.isEmpty()) {
            error = "Please enter a valid value";
        }
        else if (status.isEmpty()) {
            error = "Please choose a valid status";
        }
        else if (description.isEmpty()) {
            error = "Please enter a valid description";
        }
        else if (orderParam.isEmpty()) {
            error = "Please enter a valid order";
        } else {
            try {
                //check order is an integer greater than or equal to 0
                order = Integer.parseInt(orderParam);
                if(order < 0){
                    throw new NumberFormatException();
                }
            }catch (NumberFormatException e){
                error = "Order is an integer greater than or equal to 0";
            }
        }
        //Check if value in this type is already exist in system except this id
        if(settingDAO.checkValueExist(value, type, id)){
            error = "Setting with value \"" + value + "\" and type \"" + type + "\" already exist";
        }
        //If there is an error, redirect to setting_edit page and show error message
        if(!error.isEmpty()){
            request.setAttribute("error", error);
            request.setAttribute("id", id);
            request.setAttribute("type", type);
            request.setAttribute("value", value);
            request.setAttribute("order", orderParam);
            request.setAttribute("description", description);
            request.setAttribute("status", status);
            request.getRequestDispatcher("setting_edit.jsp").forward(request, response);
        }
        //If there is no error, update a setting and redirect to setting_detail page
        else{
            Setting setting = new Setting(id, type, value, description, order, status.equals("activate"));
            HttpSession session = request.getSession();
            if(settingDAO.update(setting)){
                //Add toastNotification success to session to show success message in setting_detail page
                session.setAttribute("toastNotification", "Setting has been updated successfully.");
                response.sendRedirect("get-setting-detail?id="+id);
            }
            else{
                //Add toastNotification failed to session to show failed message in setting_detail page
                session.setAttribute("toastNotification", "Setting has been updated failed. Please try again later.");
                response.sendRedirect("get-setting-detail?id="+id);
            }
        }


    }
}
