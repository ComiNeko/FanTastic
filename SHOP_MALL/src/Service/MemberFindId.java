package Service;

import java.io.IOException;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.MemberDao;
import util.EmailUtil;

public class MemberFindId implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		
		 	response.setContentType("text/html; charset=UTF-8");
		 	request.setCharacterEncoding("utf-8");
	        
	        // 사용자가 입력한 이메일을 그대로 사용 (trim 등의 처리는 하지 않음)
	        String email = request.getParameter("email");
	        if (email == null || email.isEmpty()) {
	            response.getWriter().println("メールを入力してください。");
	            return;
	        }
	        
	        // DAO를 통해 DB에 저장된 이메일과 매칭되는 userid 조회
	        MemberDao dao = new MemberDao();
	        String userId = dao.findUserId(email);
	        System.out.println("findUserId - email: " + email + ", result: " + userId);
	        if (userId == null) {
	            response.getWriter().println("存在しないメールアドレスです。");
	            return;
	        }
	        
	        // 6자리 인증 코드 생성
	        String authCode = generateAuthCode();
	        
	        // 이메일 전송
	        boolean emailSent = sendEmail(email, authCode);
	        if (!emailSent) {
	            response.getWriter().println("メール送信に失敗しました。");
	            return;
	        }
	        
	        // 세션에 인증 코드, userid, 만료시간(2분 후) 저장
	        HttpSession session = request.getSession();
	        session.setAttribute("findIdAuthCode", authCode);
	        session.setAttribute("findIdUserId", userId);
	        long expiryTime = System.currentTimeMillis() + 2 * 60 * 1000;
	        session.setAttribute("authCodeExpiry", expiryTime);
	        
	        response.getWriter().println("認証コードがメールに送信されました。");
	    }
	    
	    // 6자리 랜덤 인증 코드 생성 메서드
	    private String generateAuthCode() {
	        Random random = new Random();
	        int code = random.nextInt(900000) + 100000;
	        return String.valueOf(code);
	    }
	    
	    // 이메일 전송 메서드
	    private boolean sendEmail(String toEmail, String authCode) {
	        try {
	            Session mailSession = EmailUtil.getMailSession();
	            Message message = new MimeMessage(mailSession);
	            message.setFrom(new InternetAddress("dptmf3290@gmail.com"));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
	            message.setSubject("[FanTastic]ID検索のためのメール認証");
	            
	            String emailContent = 
	            		"こんにちは、FanTastic運営チームです。\n\n" +
                        "ID検索のための認証コードをお送りします。\n\n" +
                        "認証コード: " + authCode + "\n\n" +
                        "認証コードは2分後に無効になります。お早めにご確認ください。\n\n" +
                        "ありがとうございます。\n\n" +
                        "[FanTastic] 運営チームより";
	            
	            message.setText(emailContent);
	            Transport.send(message);
	            return true;
	        } catch (MessagingException e) {
	            e.printStackTrace();
	            return false;
	        }
    }
}