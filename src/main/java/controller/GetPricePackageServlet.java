package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import dao.PricePackageDAO;
import entity.PricePackage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author Dell
 */
@WebServlet(name = "GetPricePackageServlet", urlPatterns = {"/get_price_package"})
public class GetPricePackageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PricePackageDAO pDAO = new PricePackageDAO();
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));
        List<PricePackage> list = pDAO.getOfSubject(subjectId);
        request.setAttribute("p", list);
        request.setAttribute("subject_id", subjectId);
        request.getRequestDispatcher("price_package_list.jsp").forward(request, response);
     }

}
