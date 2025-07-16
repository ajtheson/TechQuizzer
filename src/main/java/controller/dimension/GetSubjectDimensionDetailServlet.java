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

@WebServlet(name = "GetSubjectDimensionDetailServlet", urlPatterns = "/dimension-detail")
public class GetSubjectDimensionDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int dimensionId = Integer.parseInt(request.getParameter("id"));
        DimensionDAO dao = new DimensionDAO();
        DimensionDTO dimension = dao.getDimensionDTOById(dimensionId);

        // Lấy user từ session
        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        request.setAttribute("dimension", dimension);
        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("subject_dimension_detail.jsp").forward(request, response);
    }
}
