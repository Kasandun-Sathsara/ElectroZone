package lk.jiat.ElectroZone.service;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.Response;
import lk.jiat.ElectroZone.dto.UserDTO;
import lk.jiat.ElectroZone.entity.Address;
import lk.jiat.ElectroZone.entity.Status;
import lk.jiat.ElectroZone.entity.User;
import lk.jiat.ElectroZone.mail.VerificationMail;
import lk.jiat.ElectroZone.provider.MailServiceProvider;
import lk.jiat.ElectroZone.util.AppUtil;
import lk.jiat.ElectroZone.util.HibernateUtil;
import lk.jiat.ElectroZone.validation.Validator;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Set;

public class UserService {

    public String userLogin(UserDTO userDTO, @Context HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        ///  login handling code | user authentication part-start
        if (userDTO.getEmail() == null) {
            message = "Email is required!";
        } else if (userDTO.getEmail().isBlank()) {
            message = "Email address can not be empty!";
        } else if (!userDTO.getEmail().matches(Validator.EMAIL_VALIDATION)) {
            message = "Please provide valid email address!";
        } else if (userDTO.getPassword() == null) {
            message = "Password is required!";
        } else if (userDTO.getPassword().isBlank()) {
            message = "Password can not be empty!";
        } else if (!userDTO.getPassword().matches(Validator.PASSWORD_VALIDATION)) {
            message = "Please provide valid password. \n " +
                    "The password must be at least 8 characters long and include at least one uppercase letter, " +
                    "one lowercase letter, one digit, and one special character";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            User singleUser = hibernateSession.createNamedQuery("User.getByEmail", User.class)
                    .setParameter("email", userDTO.getEmail())
                    .getSingleResultOrNull();
            if (singleUser == null) { // not found
                message = "Account not found. Please register first!";
            } else {
                boolean passwordMatches = false;
                try {
                    passwordMatches = org.mindrot.jbcrypt.BCrypt.checkpw(userDTO.getPassword(), singleUser.getPassword());
                } catch (IllegalArgumentException e) {
                    // Fallback to plain text comparison for older accounts
                    passwordMatches = singleUser.getPassword().equals(userDTO.getPassword());
                }
                if (!passwordMatches) {
                    message = "Something went wrong. Please check your login credentials!";
                } else {
                    Status verifiedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                            .setParameter("value", String.valueOf(Status.Type.VERIFIED))
                            .getSingleResult();
                    if (!singleUser.getStatus().equals(verifiedStatus)) {
                        message = "Your account is not verified. Please verify first!";
                    } else {
                        HttpSession httpSession = request.getSession();
                        httpSession.setAttribute("user", singleUser);
                        status = true;
                        message = "Login successful";
                    }
                }
            }
            hibernateSession.close();
        }
        ///  login handling code | user authentication part-end


        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String verifyUserAccount(UserDTO userDTO) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        ///  logic handling part
        if (userDTO.getEmail() == null) {
            message = "Email is required!";
        } else if (userDTO.getEmail().isBlank()) {
            message = "Email address can not be empty!";
        } else if (!userDTO.getEmail().matches(Validator.EMAIL_VALIDATION)) {
            message = "Please provide valid email address!";
        } else if (userDTO.getVerificationCode() == null) {
            message = "Verification is required!";
        } else if (userDTO.getVerificationCode().isBlank()) {
            message = "Verification code can not be empty!";
        } else if (!userDTO.getVerificationCode().matches(Validator.VERIFICATION_CODE_VALIDATION)) {
            message = "Please provide valid verification code!. Verification code must have 6 digits";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            User user = hibernateSession.createQuery("FROM User u WHERE u.email=:email AND u.verificationCode=:verificationCode", User.class)
                    .setParameter("email", userDTO.getEmail())
                    .setParameter("verificationCode", userDTO.getVerificationCode())
                    .getSingleResultOrNull();
            if (user == null) {
                message = "Account not found. Please register first!";
            } else {
                Status verifiedStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                        .setParameter("value", String.valueOf(Status.Type.VERIFIED))
                        .getSingleResult();

                if (user.getStatus().equals(verifiedStatus)) {
                    message = "Account already verified!";
                } else {
                    user.setStatus(verifiedStatus);
                    user.setVerificationCode("");
                    Transaction transaction = hibernateSession.beginTransaction();
                    try {
                        hibernateSession.merge(user);
                        transaction.commit();
                        status = true;
                        message = "Account verification completed!";
                    } catch (HibernateException e) {
                        transaction.rollback();
                        message = "Something went wrong. Verification process failed!";
                    }
                }
            }
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String addNewUser(UserDTO userDTO) {
        JsonObject responseObject = new JsonObject();

        boolean status = false;
        String message;

        if (userDTO.getFirstName() == null) {
            message = "First name is required!";
        } else if (userDTO.getFirstName().isBlank()) {
            message = "First name can not be empty!";
        } else if (userDTO.getLastName() == null) {
            message = "Last name is required!";
        } else if (userDTO.getLastName().isBlank()) {
            message = "Last name can not be empty!";
        } else if (userDTO.getEmail() == null) {
            message = "Email is required!";
        } else if (userDTO.getEmail().isBlank()) {
            message = "Email can not be empty!";
        } else if (!userDTO.getEmail().matches(Validator.EMAIL_VALIDATION)) {
            message = "Please provide valid email address!";
        } else if (userDTO.getPassword() == null) {
            message = "Password is required!";
        } else if (userDTO.getPassword().isBlank()) {
            message = "Password can not be empty!";
        } else if (!userDTO.getPassword().matches(Validator.PASSWORD_VALIDATION)) {
            message = "Please provide valid password. \n " +
                    "The password must be at least 8 characters long and include at least one uppercase letter, " +
                    "one lowercase letter, one digit, and one special character";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            User singleUser = hibernateSession.createNamedQuery("User.getByEmail", User.class)
                    .setParameter("email", userDTO.getEmail())
                    .getSingleResultOrNull();

            if (singleUser != null) { // Already exists
                message = "This email already exists! Please use another email";
            } else {
                User u = new User();
                u.setFirstName(userDTO.getFirstName());
                u.setLastName(userDTO.getLastName());
                u.setEmail(userDTO.getEmail());
                u.setPassword(org.mindrot.jbcrypt.BCrypt.hashpw(userDTO.getPassword(), org.mindrot.jbcrypt.BCrypt.gensalt()));

                String verificationCode = AppUtil.generateCode();

                u.setVerificationCode(verificationCode);

                Status pendingStatus = hibernateSession.createNamedQuery("Status.findByValue", Status.class)
                        .setParameter("value", String.valueOf(Status.Type.PENDING)).getSingleResult();

                u.setStatus(pendingStatus);

                Transaction transaction = hibernateSession.beginTransaction();

                try {
                    hibernateSession.persist(u);
                    transaction.commit();

                    /// verification-mail-sending-start
                    VerificationMail verificationMail = new VerificationMail(u.getEmail(), verificationCode);
                    MailServiceProvider.getInstance().sendMail(verificationMail);
                    /// verification-mail-sending-end

                    status = true;
                    message = "Account created successfully. Verification code has been sent to the your email. " +
                            "Please verify it for activate your account!";


                } catch (HibernateException e) {
                    transaction.rollback();
                    message = "Account creation failed. Please try again!";
                }


            }
            hibernateSession.close();
        }
        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String sendPasswordResetOtp(UserDTO userDTO, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        if (userDTO.getEmail() == null || userDTO.getEmail().isBlank()) {
            message = "Email is required!";
        } else if (!userDTO.getEmail().matches(Validator.EMAIL_VALIDATION)) {
            message = "Please provide a valid email address!";
        } else {
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            User user = hibernateSession.createNamedQuery("User.getByEmail", User.class)
                    .setParameter("email", userDTO.getEmail())
                    .getSingleResultOrNull();

            if (user == null) {
                // Show success even if not found to prevent email enumeration, but we won't send an email
                status = true;
                message = "If this email is registered, you will receive an OTP shortly.";
            } else {
                String otp = AppUtil.generateCode();
                
                // Store in session
                HttpSession session = request.getSession();
                session.setAttribute("resetEmail", user.getEmail());
                session.setAttribute("resetOtp", otp);
                session.setMaxInactiveInterval(10 * 60); // OTP expires in 10 minutes

                // Send Email
                String subject = "Password Reset OTP - ElectroZone";
                String htmlBody = "<div style='font-family: Arial, sans-serif; padding: 20px; max-width: 600px; margin: 0 auto;'>" +
                        "<h2 style='color: #2563eb;'>ElectroZone Password Reset</h2>" +
                        "<p>Hello " + user.getFirstName() + ",</p>" +
                        "<p>You requested a password reset. Your OTP is:</p>" +
                        "<div style='background-color: #f3f4f6; padding: 15px; border-radius: 5px; font-size: 24px; letter-spacing: 5px; font-weight: bold; text-align: center; margin: 20px 0;'>" +
                        otp +
                        "</div>" +
                        "<p>This code is valid for 10 minutes. If you did not request a password reset, please ignore this email.</p>" +
                        "<p>Best Regards,<br>ElectroZone Team</p>" +
                        "</div>";

                new Thread(() -> {
                    lk.jiat.ElectroZone.util.EmailUtil.sendEmail(user.getEmail(), subject, htmlBody);
                }).start();

                status = true;
                message = "OTP has been sent to your email address.";
            }
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String verifyPasswordResetOtp(UserDTO userDTO, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetEmail") == null || session.getAttribute("resetOtp") == null) {
            message = "Session expired or invalid. Please request a new OTP.";
        } else if (userDTO.getVerificationCode() == null || userDTO.getVerificationCode().isBlank()) {
            message = "OTP is required!";
        } else {
            String savedOtp = (String) session.getAttribute("resetOtp");
            if (savedOtp.equals(userDTO.getVerificationCode())) {
                status = true;
                message = "OTP verified successfully.";
                session.setAttribute("otpVerified", true); // Mark as verified so they can proceed to reset
            } else {
                message = "Invalid OTP. Please try again.";
            }
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

    public String resetPassword(UserDTO userDTO, HttpServletRequest request) {
        JsonObject responseObject = new JsonObject();
        boolean status = false;
        String message = "";

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("resetEmail") == null || session.getAttribute("otpVerified") == null) {
            message = "Session expired or invalid flow. Please start over.";
        } else if (userDTO.getPassword() == null || userDTO.getPassword().isBlank()) {
            message = "New password is required!";
        } else if (!userDTO.getPassword().matches(Validator.PASSWORD_VALIDATION)) {
            message = "Password must be at least 8 characters long and include uppercase, lowercase, digit, and special character.";
        } else {
            String email = (String) session.getAttribute("resetEmail");
            
            Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
            User user = hibernateSession.createNamedQuery("User.getByEmail", User.class)
                    .setParameter("email", email)
                    .getSingleResultOrNull();

            if (user != null) {
                Transaction tx = hibernateSession.beginTransaction();
                try {
                    user.setPassword(lk.jiat.ElectroZone.util.EncryptionUtil.hashPassword(userDTO.getPassword()));
                    hibernateSession.merge(user);
                    tx.commit();
                    
                    status = true;
                    message = "Password reset successfully. You can now login.";
                    
                    // Clear session attributes
                    session.removeAttribute("resetEmail");
                    session.removeAttribute("resetOtp");
                    session.removeAttribute("otpVerified");
                } catch (HibernateException e) {
                    tx.rollback();
                    message = "Failed to reset password. Please try again.";
                }
            } else {
                message = "User not found.";
            }
            hibernateSession.close();
        }

        responseObject.addProperty("status", status);
        responseObject.addProperty("message", message);
        return AppUtil.GSON.toJson(responseObject);
    }

}
