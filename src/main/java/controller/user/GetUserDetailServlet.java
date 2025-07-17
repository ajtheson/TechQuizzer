package controller.user;

import dao.UserDAO;
import dto.UserDTO;
import entity.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

import java.io.IOException;

@WebServlet(name = "GetUserDetailServlet", value = "/user/detail")
public class GetUserDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");

        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = ((UserDTO) session.getAttribute("user")).getEmail();
            User user = new UserDAO().getUserByEmail(email);
            if (user != null) {
                JSONObject json = new JSONObject();
                json.put("email", user.getEmail());
                json.put("name", user.getName());
                json.put("gender", user.getGender());
                json.put("address", user.getAddress());
                json.put("mobile", user.getMobile());
                json.put("avatar", user.getAvatar());
                response.getWriter().write(json.toString());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}