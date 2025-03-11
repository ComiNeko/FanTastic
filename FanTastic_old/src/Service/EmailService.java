package Service;

import java.io.IOException;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.EmailUtil;

public class EmailService implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // doCommand 내부에서 sendEmail을 호출할 수 있도록 변경
        String toEmail = request.getParameter("email"); // 요청에서 이메일 주소 가져오기
        String code = sendEmail(toEmail); // 인증 코드 전송
        if (code != null) {
            request.setAttribute("authCode", code);
        }
    }

    public String sendEmail(String toEmail) {
        // 랜덤 6자리 인증 코드 생성
        String authCode = generateRandomCode();

        try {
            Session session = EmailUtil.getMailSession(); // 이메일 세션 가져오기

            // 이메일 작성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("dptmf3290@gmail.com")); // 보내는 사람
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); // 받는 사람
            message.setSubject("[FanTastic] 인증 코드"); // 이메일 제목

            // 이메일 본문 작성
            String emailContent = 
                    "안녕하세요.\n\n" +
                    "회원가입을 위한 이메일 인증 코드를 보내드립니다.\n\n" +
                    "귀하의 이메일 주소를 통해 인증 요청이 접수되었습니다.\n\n" +
                    "[FanTastic]의 인증 코드는 다음과 같습니다.\n\n" +
                    "🔑 인증 코드: " + authCode + "\n\n" +
                    "인증 코드는 일정 시간 후 만료될 수 있으니 빠른 입력을 권장드립니다.\n\n" +
                    "감사합니다.\n\n" +
                    "[FanTastic] 드림";

            message.setText(emailContent); // 본문 설정

            // 이메일 전송
            Transport.send(message);

            return authCode; // 인증 코드 반환
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
