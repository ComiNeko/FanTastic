package Service;

import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;

import util.EmailUtil;

public class EmailService {
    public String sendEmail(String toEmail) {
    	        // 랜덤 6자리 인증 코드 생성
    	        String code = generateRandomCode();
    	        
    	        try {
    	            Session session = EmailUtil.getMailSession();

    	            // 이메일 작성
    	            Message message = new MimeMessage(session);
    	            // 보내는 사람: EmailUtil에서 설정한 이메일과 동일하게 맞춰주세요.
    	            message.setFrom(new InternetAddress("dptmf3290@gmail.com"));
    	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
    	            message.setSubject("이메일 인증");
    	            message.setText("인증 코드: " + code);

    	            // 이메일 전송
    	            Transport.send(message);

    	            // 인증 코드를 반환 (세션에 저장하여 나중에 비교)
    	            return code;
    	        } catch (MessagingException e) {
    	            e.printStackTrace();
    	            return null;
    	        }
    	    }

    	    // 랜덤 6자리 코드 생성 메서드
    	    private String generateRandomCode() {
    	        Random random = new Random();
    	        int code = random.nextInt(900000) + 100000; // 100000 ~ 999999 사이 숫자 생성
    	        return String.valueOf(code);
    }
    	    
}