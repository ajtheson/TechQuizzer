package controller.dimension;

import dao.DimensionDAO;
import dao.SubjectDAO;
import dto.DimensionDTO;
import dto.SubjectDTO;
import dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.SubjectService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetSubjectDimensionServlet", urlPatterns = {"/management/dimension/list"})
public class GetSubjectDimensionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/account/login");
            return;
        }
        DimensionDAO dimensionDAO = new DimensionDAO();
        int subjectId = Integer.parseInt(request.getParameter("id"));
        String search = request.getParameter("search");
        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");
        SubjectDAO subjectDAO = new SubjectDAO();
        SubjectService subjectService = new SubjectService();
        SubjectDTO subject = subjectService.toSubjectDTO(subjectDAO.getSubjectById(subjectId));
        int page = 1;
        int pageSize = 10;
        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                int tmp = Integer.parseInt(pageSizeParam);
                if (tmp > 0) {
                    pageSize = tmp;
                } else {
                    session.setAttribute("error", "Page size must be greater than 0.");
                    response.sendRedirect("list");
                    return;
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid pagination input.");
            response.sendRedirect("list");
            return;
        }
        int totalRecords = dimensionDAO.getTotalDimensionCount(subjectId,search);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (sortField == null || sortField.isEmpty()) sortField = "d.id";
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "ASC";

        List<DimensionDTO> dimensionList = dimensionDAO.getDimensionByPage(subjectId,search,page,pageSize,sortField,sortOrder);
        request.setAttribute("dimensionList", dimensionList);
        request.setAttribute("subjectId", subjectId);
        request.setAttribute("search", search);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("subject", subject);
        request.getRequestDispatcher( "/dimension/subject_dimension.jsp").forward(request, response);
    }
}
