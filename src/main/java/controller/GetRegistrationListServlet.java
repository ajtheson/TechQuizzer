package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import dao.RegistrationDAO;
import dto.RegistrationDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author Dell
 */
@WebServlet(name = "GetRegistrationListServlet", urlPatterns = {"/registrations"})
public class GetRegistrationListServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RegistrationDAO rDAO = new RegistrationDAO();
        List<RegistrationDTO> registrations = rDAO.getAllRegistrations();

        //If load new page
        if(request.getParameter("email") == null) {
            request.setAttribute("registrations", registrations);
            request.getRequestDispatcher("registrations.jsp").forward(request, response);
            return;
        }

        String email = request.getParameter("email").trim();
        String subject = request.getParameter("subject").trim();
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String status = request.getParameter("status");

        //Filter by email
        if(!email.isEmpty()){
            registrations = registrations.stream().filter(
                    r -> r.getUser().getEmail().toLowerCase().contains(email.toLowerCase())
            ).collect(Collectors.toList());
        }
        //Filter by subject
        if(!subject.isEmpty()){
            registrations = registrations.stream().filter(
                    r -> r.getSubject().getName().toLowerCase().contains(subject.toLowerCase())
            ).collect(Collectors.toList());
        }
        //Filter by status
        if(!status.isEmpty()){
            registrations = registrations.stream().filter(
                    r -> r.getStatus().equals(status)
            ).collect(Collectors.toList());
        }

        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm dd-MM-yyyy");


        //Filter by from
        if(!from.isEmpty()){
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            LocalDateTime fromDate = LocalDate.parse(from, formatter).atStartOfDay();
            registrations = registrations.stream().filter(
                    r -> {
                        LocalDateTime time = LocalDateTime.parse(r.getTime(), timeFormatter);
                        return !time.isBefore(fromDate);
                    }
            ).collect(Collectors.toList());
        }

        //Filter by to
        if(!to.isEmpty()){
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
            LocalDateTime toDate = LocalDate.parse(to, formatter).atStartOfDay();
            registrations = registrations.stream().filter(
                    r -> {
                        LocalDateTime time = LocalDateTime.parse(r.getTime(), timeFormatter);
                        return time.isBefore(toDate);
                    }
            ).collect(Collectors.toList());
        }

        request.setAttribute("email", email);
        request.setAttribute("subject", subject);
        request.setAttribute("from", from);
        request.setAttribute("to", to);
        request.setAttribute("status", status);

        request.setAttribute("registrations", registrations);
        request.getRequestDispatcher("registrations.jsp").forward(request, response);
    }
}
