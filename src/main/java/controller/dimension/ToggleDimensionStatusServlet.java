package controller.dimension;

import dao.DimensionDAO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "ToggleDimensionStatusServlet", urlPatterns = {"/dimension/toggle-dimension-status"})
public class ToggleDimensionStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        try {
            int id = Integer.parseInt(request.getParameter("d_id"));
            int status = Integer.parseInt(request.getParameter("status"));
            int subjectId = Integer.parseInt(request.getParameter("id"));

            DimensionDAO dao = new DimensionDAO();
            boolean success = dao.toggleStatus(id, status);

            if (success) {
                request.getSession().setAttribute("toastNotification", "Status updated successfully.");
            } else {
                request.getSession().setAttribute("toastNotification", "Failed to update status.");
            }
            response.sendRedirect("subject-dimension?id=" + subjectId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
