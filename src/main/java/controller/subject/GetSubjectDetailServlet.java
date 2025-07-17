package controller.subject;

import dao.PricePackageDAO;
import dao.RegistrationDAO;
import dao.SubjectDAO;
import dao.SubjectDescriptionImageDAO;
import dto.SubjectDTO;
import dto.UserDTO;
import entity.PricePackage;
import entity.Subject;
import entity.SubjectDescriptionImage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.SubjectService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "GetSubjectDetailServlet", urlPatterns = {"/subject/detail"})
public class GetSubjectDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userID = 0;
        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            userID = user.getId();
        }

        //Init DAO object needed
        SubjectDAO subjectDAO = new SubjectDAO();
        PricePackageDAO pricePackageDAO = new PricePackageDAO();
        RegistrationDAO registrationDAO = new RegistrationDAO();
        SubjectDescriptionImageDAO subjectDescriptionImageDAO = new SubjectDescriptionImageDAO();

        //Get subjectId from request
        int subjectId = Integer.parseInt(request.getParameter("subject_id"));

        //Get subject to show detail
        Subject subject = subjectDAO.getSubjectById(subjectId);
        SubjectService subjectService = new SubjectService();
        SubjectDTO subjectDTO = subjectService.toSubjectDTO(subject);
        subjectDTO.setLongDescription(subject.getLongDescription().replace("\\n", "<br>"));

        //Get active price packages of this subject to show
        List<PricePackage> pricePackages = pricePackageDAO.getActiveOfSubject(subjectId);

        List<SubjectDescriptionImage> subjectDescriptionImages = subjectDescriptionImageDAO.getAllImageBySubjectId(subjectId);

        //Get min list price and sale price to show
        double minListPrice = pricePackageDAO.getMinListPrice(subjectId);
        double minSalePrice = pricePackageDAO.getMinSalePrice(subjectId);

        //Count discount
        int discount = (int)Math.ceil((minListPrice * 1.0 - minSalePrice)/minListPrice * 100);

        request.setAttribute("subject", subjectDTO);
        request.setAttribute("pricePackages", pricePackages);
        request.setAttribute("subjectDescriptionImages", subjectDescriptionImages);
        request.setAttribute("minListPrice", minListPrice);
        request.setAttribute("minSalePrice", minSalePrice);
        request.setAttribute("discount", discount);
        request.getRequestDispatcher("subject_detail.jsp").forward(request, response);
    }
}