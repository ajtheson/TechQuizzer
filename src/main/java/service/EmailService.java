package service;

import dto.RegistrationDTO;
import jakarta.servlet.http.HttpServletRequest;
import util.EmailSender;

public class EmailService {

    private String getBaseURL(HttpServletRequest request) {
        String scheme = request.getScheme();              // http
        String serverName = request.getServerName();      // localhost
        int serverPort = request.getServerPort();         // 8080
        String contextPath = request.getContextPath();    // /ContextPath

        return scheme + "://" + serverName
                + (serverPort == 80 || serverPort == 443 ? "" : ":" + serverPort)
                + contextPath + "/";
    }

    public void sendActivatingEmail(HttpServletRequest request, String email, String token, boolean isEmailExistInSystem) {
        String verifyLink = getBaseURL(request) + "verify?mode=activate&token=" + token;
        String title, content;

        if (isEmailExistInSystem) {
            title = "[Account Verification] You Have Already Registered - Please Activate Your Account";

            content = "Hello,\n\n"
                    + "We noticed that you have already registered with this email address but have not yet activated your account.\n\n"
                    + "Your previously registered information will be kept unchanged. You can update your details anytime after logging into the system in the Settings section.\n\n"
                    + "To complete your registration and activate your account, please click the link below:\n\n"
                    + verifyLink + "\n\n"
                    + "If you did not make this request, please ignore this email.\n\n"
                    + "This activation link is valid for 24 hours or until a new activation request is made, whichever comes first.\n\n"
                    + "Best regards,\n"
                    + "The TechQuizzer";
        } else {
            title = "[Welcome] Please Activate Your New Account";

            content = "Hello,\n\n"
                    + "Thank you for registering with us using this email address.\n\n"
                    + "To complete your registration and activate your new account, please click the link below:\n\n"
                    + verifyLink + "\n\n"
                    + "If you did not make this request, please ignore this email.\n\n"
                    + "This activation link is valid for 24 hours or until a new activation request is made, whichever comes first.\n\n"
                    + "Best regards,\n"
                    + "The TechQuizzer";
        }

        EmailSender.sendEmail(email, title, content);
    }

    public void sendResetPasswordEmail(HttpServletRequest request, String email, String token) {
        String resetLink = getBaseURL(request) + "verify?mode=reset&token=" + token;
        String title = "[Password Reset] Reset Your Quiz Account Password";

        String content = "Hello,\n\n"
                + "We received a request to reset the password associated with this email address.\n\n"
                + "If you made this request, please click the link below to reset your password:\n\n"
                + resetLink + "\n\n"
                + "This link will expire shortly for your security.\n\n"
                + "If you did not request a password reset, please ignore this email.\n\n"
                + "This password reset link is valid for 24 hours or until a new reset request is made, whichever comes first.\n\n"
                + "Best regards,\n"
                + "The TechQuizzer";

        EmailSender.sendEmail(email, title, content);
    }

    public void sendOTPForRegisterSubject(String email, String otp, boolean isResend) {
        String subject = isResend
                ? "[OTP Resend] Verify Your Quiz Account"
                : "[OTP Verification] Complete Your Quiz Registration";

        String content = "Hello,\n\n"
                + "Thank you for registering with TechQuizzer.\n\n"
                + "To complete your registration, please enter the following One-Time Password (OTP):\n\n"
                + "OTP: " + otp + "\n\n"
                + "This OTP is valid for 5 minutes only.\n\n"
                + "If you did not request this code, please ignore this email.\n\n"
                + "Best regards,\n"
                + "The TechQuizzer";

        EmailSender.sendEmail(email, subject, content);
    }

    public void sendStatusUpdateEmail(RegistrationDTO registration) {
        String email = registration.getUser().getEmail();
        String subjectName = registration.getSubject().getName();
        String status = registration.getStatus();
        String time = registration.getTime();
        String validFrom = registration.getValidFrom();
        String validTo = registration.getValidTo();
        String pricePackage = registration.getPricePackage() != null ? registration.getPricePackage().getName() : "N/A";
        String updatedBy = registration.getLastUpdatedBy() != null ? registration.getLastUpdatedBy().getName() : "our team";

        String title = "[Course Registration Update] Your registration status has been updated";
        String content;

        switch (status) {
            case "Pending Payment":
                title = "[Pending Payment] Please complete your payment to activate your course";

                content = "Hello,\n\n"
                        + "Thank you for registering for the course: " + subjectName + ".\n\n"
                        + "Your registration is now in Pending Payment status. Please complete the payment to activate your course access.\n\n"
                        + "Registration Details:\n"
                        + "- Registration Time: " + time + "\n"
                        + "- Price Package: " + pricePackage + "\n"
                        + "- Total Cost: $" + registration.getTotalCost() + "\n\n"
                        + "To complete your payment, please transfer the amount to the following account:\n\n"
                        + "Bank Name: TechBank Vietnam\n"
                        + "Account Name: TECHQUIZZER JSC\n"
                        + "Account Number: 123 456 789\n"
                        + "Payment Note: REG-" + registration.getId() + " - " + registration.getUser().getName() + "\n\n"
                        + "Once the payment is confirmed, we will activate your course and send a confirmation email.\n"
                        + "If you have already made the payment, please ignore this message or contact support if your course is not activated within 24 hours.\n\n"
                        + "Best regards,\n"
                        + "The TechQuizzer Team";
                break;

            case "Paid":
                boolean isTempUser = registration.getUser().isTempUser();
                String passwordNotice = "";

                if (isTempUser) {
                    passwordNotice = "\nAs this is your first time registering, a temporary account has been created for you.\n"
                            + "You can log in using the credentials below:\n\n"
                            + "Email: " + email + "\n"
                            + "Password: " + registration.getUser().getPassword() + "\n\n"
                            + "Please change your password after logging in for security reasons.\n";
                }

                content = "Hello,\n\n"
                        + "Great news! Your course registration for " + subjectName + " has been activated.\n\n"
                        + "Price Package: " + pricePackage + "\n"
                        + "Registered At: " + time + "\n\n"
                        + passwordNotice
                        + "You can now access the course and begin your learning journey.\n\n"
                        + "Best regards,\n"
                        + "The TechQuizzer Team";
                break;

            case "Rejected":
                content = "Hello,\n\n"
                        + "We regret to inform you that your registration for the course **" + subjectName + "** has been **rejected** by " + updatedBy + ".\n\n"
                        + "Registered At: " + time + "\n"
                        + "Price Package: " + pricePackage + "\n"
                        + "Reason/Note: " + (registration.getNote() != null ? registration.getNote() : "Not specified") + "\n\n"
                        + "If you believe this was a mistake, please contact our support team for clarification.\n\n"
                        + "Best regards,\n"
                        + "The TechQuizzer Team";
                break;

            default:
                content = "Hello,\n\n"
                        + "Your registration for **" + subjectName + "** has been updated to status: **" + status + "**.\n\n"
                        + "Please check your account for more details or contact our support team if you have questions.\n\n"
                        + "Best regards,\n"
                        + "The TechQuizzer Team";
                break;
        }

        EmailSender.sendEmail(email, title, content);
    }


}
