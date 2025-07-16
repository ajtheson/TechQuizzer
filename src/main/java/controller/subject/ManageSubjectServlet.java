package controller.subject;

import dao.CategoryDAO;
import dao.RoleDAO;
import dao.SubjectDAO;
import dao.UserDAO;
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

@WebServlet(name = "ManageSubjectServlet", urlPatterns = {"/manage-subject"})
public class ManageSubjectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Init default for page, size, search, isFeatured, categoryId, sortOrder
        int page = 1;
        int size = 5;
        String search = "";
        int categoryId = 0;
        String status = "";

        //Init DAO object needed
        SubjectDAO subjectDAO = new SubjectDAO();
        RoleDAO roleDAO = new RoleDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        UserDAO userDAO = new UserDAO();

        //Get userID from session
        int ownerId = 0;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            if (roleDAO.getRoleNameById(user.getRoleId()).equals("Expert")) {
                ownerId = user.getId();
            }
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
        if (request.getParameter("categoryId") != null) {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        }
        if (request.getParameter("status") != null) {
            status = request.getParameter("status");
        }

        //Get all subjects from database and convert them to subjectDTO
        List<Subject> subjectList = subjectDAO.getAllSubjectsWithPagination(page, size, categoryId, search, status, ownerId);
        List<SubjectDTO> subjects = new ArrayList<>();
        SubjectService subjectService = new SubjectService();
        for (Subject subject : subjectList) {
            SubjectDTO subjectDTO = subjectService.toSubjectDTO(subject);
            subjectDTO.setOwnerName(userDAO.getUserById(subject.getOwnerId()).getName());
            subjects.add(subjectDTO);
        }

        //Get total subjects, total pages and categories to show in subject list page
        int totalSubjects = subjectDAO.getTotalSubjects(categoryId, search, status, ownerId);
        int totalPages = (int) Math.ceil((double) totalSubjects / size);
        List<Category> categories = categoryDAO.getAllCategory();

        request.setAttribute("subjects", subjects);
        request.setAttribute("categories", categories);
        request.setAttribute("totalSubjects", totalSubjects);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("size", size);
        request.setAttribute("search", search);
        if (!status.equals("")){
            request.setAttribute("status", status);
        }
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("ownerId", ownerId);
        request.getRequestDispatcher("manage_subject_list.jsp").forward(request, response);
    }
}
