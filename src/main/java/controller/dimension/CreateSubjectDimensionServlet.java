package controller.dimension;

import dao.DimensionDAO;
import dao.SubjectDAO;
import dto.SubjectDTO;
import dto.UserDTO;
import entity.Dimension;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import service.SubjectService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CreateSubjectDimensionServlet", urlPatterns = {"/management/dimension/create"})
public class CreateSubjectDimensionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        SubjectDAO subjectDAO = new SubjectDAO();
        SubjectService subjectService = new SubjectService();
        SubjectDTO subject = subjectService.toSubjectDTO(subjectDAO.getSubjectById(id));
        request.setAttribute("subject", subject);
        request.getRequestDispatcher("/dimension/subject_dimension_add.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        try {
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String description = request.getParameter("description");
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            List<Dimension> dimensionList = new DimensionDAO().selectAllDimension(subjectId);

            for (Dimension dimension : dimensionList) {
                if(dimension.getName().equalsIgnoreCase(name.trim())) {
                    session.setAttribute("toastNotification", "Duplicate dimension name");
                    response.sendRedirect("create?id=" + subjectId);
                    return;
                }
            }
            if(type.length()>6){
                session.setAttribute("toastNotification", "Type too long, 6 characters allowed.  ");
                response.sendRedirect("create?id=" + subjectId);
                return;
            }
            boolean success = new DimensionDAO().insertDimension(name, type, description, subjectId);
            if (success) {
                session.setAttribute("toastNotification", "Created successfully");
                response.sendRedirect("list?id=" + subjectId);
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
    }
}
