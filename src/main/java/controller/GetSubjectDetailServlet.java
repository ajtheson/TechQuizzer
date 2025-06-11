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
        SubjectDAO subjectDAO = new SubjectDAO();
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        String subjectParam = request.getParameter("subject_id");
        System.out.println(subjectParam);

        int subjectId = Integer.parseInt(subjectParam);

        Subject subject = subjectDAO.getSubjectById(subjectId);
        List<PricePackage> pricePackages = pricePackageDAO.getActiveOfSubject(subjectId);
        double minListPrice = pricePackageDAO.getMinListPrice(subjectId);
        double minSalePrice = pricePackageDAO.getMinSalePrice(subjectId);
        int discount = (int)Math.ceil((minListPrice * 1.0 - minSalePrice)/minListPrice * 100);

        request.setAttribute("subject", subject);
        request.setAttribute("pricePackages", pricePackages);
        request.setAttribute("minListPrice", minListPrice);
        request.setAttribute("minSalePrice", minSalePrice);
        request.setAttribute("discount", discount);

        request.getRequestDispatcher("subject_detail.jsp").forward(request, response);
    }
}
