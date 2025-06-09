package controller;

import dao.CategoryDAO;
import dao.SubjectDAO;
import dto.SubjectDTO;
import entity.Category;
import entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.SubjectService;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "GetSubjectListServlet", urlPatterns = {"/get-subject-list"})
public class GetSubjectListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int size = 5;
        String search = "";
        boolean isFeatured = false;
        int categoryId = 0;
        boolean sortOrder = true;

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


        SubjectDAO subjectDAO = new SubjectDAO ();
        CategoryDAO categoryDAO = new CategoryDAO();

        //Get all subjects, categories from database and set to request attribute
        List<Subject> subjectList = subjectDAO.getAllSubjects(page, size, categoryId, sortOrder, isFeatured, search);
        List<SubjectDTO> subjects = new ArrayList<>();
        SubjectService subjectService = new SubjectService();
        for(Subject subject : subjectList) {
            subjects.add(subjectService.toSubjectDTO(subject));
        }
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
