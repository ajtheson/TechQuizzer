package controller;

import dao.CategoryDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dto.SubjectDTO;
import dto.UserDTO;
import entity.Category;
import entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.SubjectService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetSubjectListServlet", urlPatterns = {"/subjects"})
public class GetSubjectListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Init default for page, size, search, isFeatured, categoryId, sortOrder
        int page = 1;
        int size = 5;
        String search = "";
        boolean isFeatured = false;
        int categoryId = 0;
        boolean sortOrder = true;

        //Get userID from session
        int userID = 0;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            userID = user.getId();
        }

        //Get page, size, search, isFeatured, categoryId, sortOrder from request
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("size") != null) {
            size = Integer.parseInt(request.getParameter("size"));
        }
        if (request.getParameter("search") != null) {
            search = request.getParameter("search");
        }
        if (request.getParameter("isFeatured") != null) {
            isFeatured = Boolean.parseBoolean(request.getParameter("isFeatured"));
        }
        if (request.getParameter("categoryId") != null) {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        }
        if (request.getParameter("sortOrder") != null) {
            sortOrder = request.getParameter("sortOrder").equalsIgnoreCase("desc");
        }

        //Init DAO object needed
        SubjectDAO subjectDAO = new SubjectDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        RegistrationDAO registrationDAO = new RegistrationDAO();

        //Get all subjects from database and convert them to subjectDTO
        List<Subject> subjectList = subjectDAO.getAllSubjectsWithPagination(page, size, categoryId, sortOrder, isFeatured, search);
        List<SubjectDTO> subjects = new ArrayList<>();
        SubjectService subjectService = new SubjectService();
        for (Subject subject : subjectList) {
            SubjectDTO subjectDTO = subjectService.toSubjectDTO(subject);
            //If the user has already registered for that course, they are not allowed to register again.
            subjectDTO.setRegistered(registrationDAO.isRegistrationExist(userID, subjectDTO.getId()));
            subjects.add(subjectDTO);
        }

        //Get total subjects, total pages and categories to show in subject list page
        int totalSubjects = subjectDAO.getTotalSubjects(categoryId, isFeatured, search);
        int totalPages = (int) Math.ceil((double) totalSubjects / size);
        List<Category> categories = categoryDAO.getAllCategory();

        request.setAttribute("subjects", subjects);
        request.setAttribute("categories", categories);
        request.setAttribute("totalSubjects", totalSubjects);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("size", size);
        request.setAttribute("search", search);
        request.setAttribute("isFeatured", isFeatured ? "true" : "");
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("sortOrder", sortOrder ? "desc" : "asc");
        request.getRequestDispatcher("subject_list.jsp").forward(request, response);
    }
}
