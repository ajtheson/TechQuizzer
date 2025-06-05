package controller;

import java.io.IOException;
import java.io.PrintWriter;

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
@WebServlet(name = "EditPricePackageServlet", urlPatterns = {"/edit_price_package"})
public class EditPricePackageServlet extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PricePackageDAO pDAO = new PricePackageDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        PricePackage p = pDAO.get(id);
        request.setAttribute("p", p);
        request.getRequestDispatcher("price_package_edit.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PricePackageDAO pDAO = new PricePackageDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name").trim();
        String duration = request.getParameter("duration").trim();
        String status = request.getParameter("status");
        double listPrice = Double.parseDouble(request.getParameter("listPrice"));
        double salePrice = Double.parseDouble(request.getParameter("salePrice"));
        String description = request.getParameter("description").trim();
        int subjectID = Integer.parseInt(request.getParameter("subject_id"));
        String error = "";
        if(name.isEmpty()){
            error = "Name is required";
        }else if(description.isEmpty()){
            error = "Description is required";
        }
        if(pDAO.checkNameExist(name, subjectID, id)){
            error = "Price package name already exist";
        }
        Integer durationInt = null;
        if(!duration.isEmpty()){
            durationInt = Integer.parseInt(duration);
        }
        PricePackage p = new PricePackage(id, name, durationInt, listPrice, salePrice, description, status.equals("activate"), subjectID);
        if(!error.isEmpty()){
            request.setAttribute("error", error);
            request.setAttribute("p", p);
            request.getRequestDispatcher("price_package_edit.jsp").forward(request, response);
        }else{
            HttpSession session = request.getSession();
            if(pDAO.update(p)){
                //Add toastNotification success to session to show success message in setting_detail page
                session.setAttribute("toastNotification", "Price package has been updated successfully.");
                response.sendRedirect("get_price_package?subject_id=" + subjectID);
            }
            else{
                //Add toastNotification failed to session to show failed message in setting_detail page
                session.setAttribute("toastNotification", "Price package has been updated failed. Please try again later.");
                response.sendRedirect("get_price_package?subject_id=" + subjectID);
            }
        }
    }

}
