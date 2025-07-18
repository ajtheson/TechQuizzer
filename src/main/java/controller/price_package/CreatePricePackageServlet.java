package controller.price_package;

import java.io.IOException;

import dao.PricePackageDAO;
import entity.PricePackage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "CreatePricePackageServlet", urlPatterns = {"/price_package/create"})
public class CreatePricePackageServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int subjectID = Integer.parseInt(request.getParameter("subject_id"));
        request.setAttribute("subject_id", subjectID);
        request.getRequestDispatcher("price_package_create.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PricePackageDAO pDAO = new PricePackageDAO();
        int subjectID = Integer.parseInt(request.getParameter("subject_id"));
        String name = request.getParameter("name").trim();
        String duration = request.getParameter("duration").trim();
        String status = request.getParameter("status");
        double listPrice = Double.parseDouble(request.getParameter("listPrice"));
        double salePrice = Double.parseDouble(request.getParameter("salePrice"));
        String description = request.getParameter("description").trim();
        String error = "";
        if(name.isEmpty()){
            error = "Name is required";
        }else if(description.isEmpty()){
            error = "Description is required";
        }
        if(pDAO.checkNameExist(name, subjectID)){
            error = "Price package name already exist";
        }
        //Check error
        if(!error.isEmpty()){
            request.setAttribute("error", error);
            request.setAttribute("subject_id", subjectID);
            request.setAttribute("name", name);
            request.setAttribute("duration", duration);
            request.setAttribute("status", status);
            request.setAttribute("listPrice", listPrice);
            request.setAttribute("salePrice", salePrice);
            request.setAttribute("description", description);
            request.getRequestDispatcher("price_package_create.jsp").forward(request, response);
        }else{
            Integer durationInt = null;
            if(!duration.isEmpty()){
                durationInt = Integer.parseInt(duration);
            }
            PricePackage p = new PricePackage(0, name, durationInt, listPrice, salePrice, description, status.equals("activate"), subjectID);
            HttpSession session = request.getSession();
            if(pDAO.add(p)){
                //Add toastNotification success to session to show success message in setting_list page
                session.setAttribute("toastNotification", "Price package has been created successfully.");
                response.sendRedirect("list?subject_id=" + subjectID);
            }
            else{
                //Add toastNotification failed to session to show failed message in setting_list page
                session.setAttribute("toastNotification", "Setting has been created failed. Please try again later.");
                response.sendRedirect("list?subject_id=" + subjectID);
            }
        }


    }

}
