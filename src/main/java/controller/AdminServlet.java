package controller;

import dao.UserDAO;
import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.PasswordEncoder;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO(); // Khởi tạo DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action == null) {
            listUsers(request, response);
            return;
        }

        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "view":
                    viewUser(request, response, idParam);
                    break;
                case "edit":
                    editUserForm(request, response, idParam);
                    break;
                case "changeStatus":
                    toggleStatus(request, response, idParam);
                    break;
                default:
                    response.sendRedirect("login");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("user_add.jsp").forward(request, response);
    }
    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roleParam = request.getParameter("role");
        String statusParam = request.getParameter("status");
        String genderParam = request.getParameter("gender");
        String searchText = request.getParameter("searchText");
        Integer roleId = (roleParam != null && !roleParam.isEmpty()) ? Integer.parseInt(roleParam) : null;
        Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : null;
        Integer gender = (genderParam != null && !genderParam.isEmpty()) ? Integer.parseInt(genderParam) : null;


        int page = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException ignored) {}
        }

        String pageSizeParam = request.getParameter("pageSize");
        if (pageSizeParam != null) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
            } catch (NumberFormatException ignored) {}
        }


        String sortField = request.getParameter("sortField");
        String sortOrder = request.getParameter("sortOrder");

        if (sortField == null || sortField.isEmpty()) sortField = "id";
        if (sortOrder == null || sortOrder.isEmpty()) sortOrder = "asc";

        ArrayList<User> users = userDAO.getUsersByPage(roleId, gender, status, searchText,page, pageSize, sortField, sortOrder);
        int totalUsers = userDAO.getTotalUsers(roleId, gender, status, searchText);
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        request.setAttribute("users", users);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchText", searchText);
        request.setAttribute("sortField", sortField);
        request.setAttribute("sortOrder", sortOrder);

        request.setAttribute("selectedRole", roleParam);
        request.setAttribute("selectedGender", genderParam);
        request.setAttribute("selectedStatus", statusParam);

        request.getRequestDispatcher("user_list.jsp").forward(request, response);
    }


    private void viewUser(HttpServletRequest request, HttpServletResponse response, String idParam)
            throws ServletException, IOException {
        int id = Integer.parseInt(idParam);
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("user_view.jsp").forward(request, response);
    }

    private void editUserForm(HttpServletRequest request, HttpServletResponse response, String idParam)
            throws ServletException, IOException {
        int id = Integer.parseInt(idParam);
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("user_edit.jsp").forward(request, response);
    }

    private void toggleStatus(HttpServletRequest request, HttpServletResponse response, String idParam)
            throws IOException {
        int id = Integer.parseInt(idParam);
        User user = userDAO.getUserById(id);
        if (user != null) {
            boolean newStatus = !user.getStatus();
            userDAO.changeUserStatus(id, newStatus);
        }
        response.sendRedirect("admin");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            updateUser(request, response);
        }
        else if("add".equals(action)){
            insertUser(request, response);
        }
        else {
            response.sendRedirect("admin");
        }
    }
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));

            User existingUser = userDAO.getUserById(id);
            if (existingUser != null) {
                existingUser.setName(name);
                existingUser.setMobile(mobile);
                existingUser.setAddress(address);
                existingUser.setRoleId(roleId);
                existingUser.setGender(gender);
                existingUser.setStatus(status);

                userDAO.updateUser(existingUser);
            }

            response.sendRedirect("admin?action=view&id=" + id);
        } catch (Exception e) {
            throw new ServletException("Update failed", e);
        }
    }
    private void insertUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String name = request.getParameter("name");
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            double balance = Double.parseDouble(request.getParameter("balance"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            if(userDAO.checkExistByEmailAndMobile(email, mobile)){
                request.setAttribute("error", "Duplicate email or mobile");
                request.getRequestDispatcher("user_add.jsp").forward(request, response);
                return;
            }
            User newUser = new User();
            newUser.setEmail(email);
            newUser.setPassword(PasswordEncoder.encode(password));
            newUser.setName(name);
            newUser.setRoleId(roleId);
            newUser.setGender(gender);
            newUser.setMobile(mobile);
            newUser.setAddress(address);
            newUser.setBalance(balance);
            newUser.setStatus(status);

            userDAO.insertUser(newUser);
            request.getSession().setAttribute("success", "Add user successfully");
            response.sendRedirect("admin");
        } catch (Exception e) {
            throw new ServletException("Insert failed", e);
        }
    }

}
