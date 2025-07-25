package controller.price_package;

import java.io.IOException;
import java.util.List;

import dao.PricePackageDAO;
import dao.SubjectDAO;
import dto.UserDTO;
import entity.PricePackage;
import entity.Subject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * @author Dell
 */
@WebServlet(name = "GetPricePackageServlet", urlPatterns = {"/price_package/list"})
public class GetPricePackageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            PricePackageDAO pDAO = new PricePackageDAO();
            int subjectId = Integer.parseInt(request.getParameter("subject_id"));
            SubjectDAO sDAO = new SubjectDAO();
            Subject subject = sDAO.getSubjectById(subjectId);
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            if(user.getRoleId() == 2){
                if(subject.getOwnerId() != user.getId()){
                    System.out.println("Subject is not owner of user");
                    session.invalidate();
                    response.sendError(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
            }
            List<PricePackage> list = pDAO.getOfSubject(subjectId);
            request.setAttribute("p", list);
            request.setAttribute("subject_id", subjectId);
            request.getRequestDispatcher("price_package_list.jsp").forward(request, response);
        }catch (Exception e) {
            System.out.println(e.getMessage());
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
     }

}
