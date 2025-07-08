package controller;

import dao.DimensionDAO;
import dto.DimensionDTO;
import dto.UserDTO;
import entity.Dimension;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditSubjectDimensionServlet", urlPatterns = {"/dimension-edit"})
public class EditSubjectDimensionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        int dimensionId = Integer.parseInt(idParam);
        DimensionDTO dimension = new DimensionDAO().getDimensionDTOById(dimensionId);

        if (dimension == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        HttpSession session = request.getSession(false);
        UserDTO currentUser = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        request.setAttribute("dimension", dimension);
        request.setAttribute("currentUser", currentUser);
        request.getRequestDispatcher("subject_dimension_edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String description = request.getParameter("description");
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            Dimension dim = new DimensionDAO().findById(id);
            List<Dimension> dimensionList = new DimensionDAO().selectAllDimension(subjectId);

            if (!name.equalsIgnoreCase(dim.getName())){
                for (Dimension dimension : dimensionList) {
                    if(dimension.getName().equalsIgnoreCase(name.trim())) {
                        session.setAttribute("toastNotification", "Duplicate dimension name");
                        response.sendRedirect("dimension-create?id=" + subjectId);
                        return;
                    }
                }
            }

            boolean success = new DimensionDAO().updateDimension(id, name, type, description, subjectId);


            if (success) {
                session.setAttribute("toastNotification", "Update successfully");
            }

            response.sendRedirect("dimension-edit?id=" + id);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
