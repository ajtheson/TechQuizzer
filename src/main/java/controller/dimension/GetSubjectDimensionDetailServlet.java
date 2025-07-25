package controller.dimension;

import dao.DimensionDAO;
import dto.DimensionDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "GetSubjectDimensionDetailServlet", urlPatterns = "/management/dimension/detail")
public class GetSubjectDimensionDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int dimensionId = Integer.parseInt(request.getParameter("id"));
            DimensionDAO dao = new DimensionDAO();
            DimensionDTO dimension = dao.getDimensionDTOById(dimensionId);

            // Lấy user từ session
            HttpSession session = request.getSession(false);
            UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/account/login");
                return;
            }
            request.setAttribute("dimension", dimension);
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("/dimension/subject_dimension_detail.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

}
