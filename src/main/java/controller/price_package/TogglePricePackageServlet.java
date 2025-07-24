package controller.price_package;

import java.io.IOException;

import dao.PricePackageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "TogglePricePackageServlet", urlPatterns = {"/price_package/toggle_status"})
public class TogglePricePackageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            PricePackageDAO pDAO = new PricePackageDAO();
            pDAO.updateStatus(id, status);

            int subjectID = pDAO.getSubjectId(id);
            // Chuyển hướng lại danh sách
            response.sendRedirect("list?subject_id=" + subjectID);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
