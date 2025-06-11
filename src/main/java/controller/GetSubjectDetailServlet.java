package controller;

import dao.PricePackageDAO;
import dao.SubjectDAO;
import entity.PricePackage;
import entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetSubjectDetailServlet", urlPatterns = {"/get-subject-detail"})
public class GetSubjectDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Init DAO object needed
        SubjectDAO subjectDAO = new SubjectDAO();
        PricePackageDAO pricePackageDAO = new PricePackageDAO();

        //Get subjectId from request
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));

        //Get subject to show detail
        Subject subject = subjectDAO.getSubjectById(subjectId);

        //Get active price packages of this subject to show
        List<PricePackage> pricePackages = pricePackageDAO.getActiveOfSubject(subjectId);

        //Get min list price and sale price to show
        double minListPrice = pricePackageDAO.getMinListPrice(subjectId);
        double minSalePrice = pricePackageDAO.getMinSalePrice(subjectId);

        //Count discount
        int discount = (int)Math.ceil((minListPrice * 1.0 - minSalePrice)/minListPrice * 100);

        request.setAttribute("subject", subject);
        request.setAttribute("pricePackages", pricePackages);
        request.setAttribute("minListPrice", minListPrice);
        request.setAttribute("minSalePrice", minSalePrice);
        request.setAttribute("discount", discount);
        request.getRequestDispatcher("subject_detail.jsp").forward(request, response);
    }
}
