package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import dao.CategoryDAO;
import dao.RegistrationDAO;
import dto.RegistrationDTO;
import dto.UserDTO;
import entity.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Dell
 */
@WebServlet(name="MyRegistrationServlet", urlPatterns={"/my_registration"})
public class MyRegistrationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        UserDTO user = (UserDTO)session.getAttribute("user");
        int userID = user.getId();

        RegistrationDAO rDAO = new RegistrationDAO();
        List<RegistrationDTO> registrations = rDAO.getRegistrationListOfUser(userID);

        CategoryDAO cDAO = new CategoryDAO();
        List<Category> categories = cDAO.getAllCategory();

        if(request.getParameter("search") != null ) {
            String search = request.getParameter("search").trim();
            if(search.length() > 0) {
                registrations = registrations.stream().filter(r -> r.getSubject().getName().toLowerCase().contains(search.toLowerCase())).collect(Collectors.toList());
                request.setAttribute("search", search);
            }
        }

        if(request.getParameterValues("status") != null) {
            String [] statusArray = request.getParameterValues("status");

            Set<String> statusSet = new HashSet<>(Arrays.asList(statusArray));

            registrations = registrations.stream()
                    .filter(r -> statusSet.contains(r.getStatus()))
                    .collect(Collectors.toList());

            List<String> statusList = Arrays.asList(statusArray);
            request.setAttribute("selectedStatuses", statusList);
        }



        if (request.getParameterValues("category") != null) {
            String[] categoryArray = request.getParameterValues("category");

            List<Integer> selectedCategoryIds = Arrays.stream(categoryArray)
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());

            registrations = registrations.stream()
                    .filter(r -> selectedCategoryIds.contains(r.getSubject().getCategoryId()))
                    .collect(Collectors.toList());

            request.setAttribute("selectedCategories", selectedCategoryIds);
        }

        if(registrations.isEmpty()) {
            request.setAttribute("emptyList", true);
        }else {
            request.setAttribute("emptyList", false);
        }

        request.setAttribute("registrations", registrations);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("my_registration.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }


}
