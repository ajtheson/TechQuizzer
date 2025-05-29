package service;

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
}
