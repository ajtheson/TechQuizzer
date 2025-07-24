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
@WebServlet(name = "PricePackageDetailServlet", urlPatterns = {"/price_package/detail"})
public class PricePackageDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            PricePackageDAO pdao = new PricePackageDAO();
            int id = Integer.parseInt(request.getParameter("id"));
            PricePackage p = pdao.get(id);
            request.setAttribute("p", p);
            request.setAttribute("subject_id", p.getSubjectId());
            request.getRequestDispatcher("price_package_detail.jsp").forward(request, response);
        }catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }



}
