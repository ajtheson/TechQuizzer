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

/**
 * @author Dell
 */
@WebServlet(name = "PricePackageDetailServlet", urlPatterns = {"/price_package_detail"})
public class PricePackageDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PricePackageDAO pdao = new PricePackageDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        PricePackage p = pdao.get(id);
        request.setAttribute("p", p);
        request.getRequestDispatcher("price_package_detail.jsp").forward(request, response);
    }



}
