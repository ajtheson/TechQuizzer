package controller.setting;

import dao.SettingDAO;
import entity.Setting;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "CreateSettingServlet", urlPatterns = {"/create-setting"})
public class CreateSettingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("setting_create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get parameter from setting_create form
        String type = request.getParameter("type").trim();
        String value = request.getParameter("value").trim();
        String orderParam = request.getParameter("order").trim();
        String description = request.getParameter("description").trim();
        String status = request.getParameter("status").trim();

        SettingDAO settingDAO = new SettingDAO();

        String error = "";
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
        //Check if value in this type is already exist in system
        if(settingDAO.checkValueExist(value, type)){
            error = "Setting with value \"" + value + "\" and type \"" + type + "\" already exist";
        }
        //If there is an error, redirect to setting_create page and show error message
        if(!error.isEmpty()){
            request.setAttribute("error", error);
            request.setAttribute("type", type);
            request.setAttribute("value", value);
            request.setAttribute("order", orderParam);
            request.setAttribute("description", description);
            request.setAttribute("status", status);
            request.getRequestDispatcher("setting_create.jsp").forward(request, response);
        }
        //If there is no error, create a new setting and redirect to setting_list page
        else{
            Setting setting = new Setting(type, value, description, order, status.equals("activate"));
            HttpSession session = request.getSession();
            if(settingDAO.add(setting)){
                //Add toastNotification success to session to show success message in setting_list page
                session.setAttribute("toastNotification", "Setting has been created successfully.");
                response.sendRedirect("settings");
            }
            else{
                //Add toastNotification failed to session to show failed message in setting_list page
                session.setAttribute("toastNotification", "Setting has been created failed. Please try again later.");
                response.sendRedirect("settings");
            }
        }
    }
}
