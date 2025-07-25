package controller.setting;

import dao.SettingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "ToggleSettingStatusServlet", urlPatterns = {"/admin/setting/toggle-setting-status"})
public class ToggleSettingStatusServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            SettingDAO dao = new SettingDAO();
            if(!status && dao.isMandatorySetting(id)){
                session.setAttribute("toastNotification", "Setting status has been updated failed! Cannot deactivated mandatory setting.");
            }
            else if(!status && dao.isSettingValueInUse(id)){
                session.setAttribute("toastNotification", "Setting status has been updated failed! Can not deactivate this setting. " + dao.getSettingUsageDetails(id));
            }
            else{
                dao.updateStatus(id, status);
                session.setAttribute("toastNotification", "Setting has been updated successfully.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/setting/list");
        } catch (Exception e) {
            System.out.println(e.getMessage());
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
