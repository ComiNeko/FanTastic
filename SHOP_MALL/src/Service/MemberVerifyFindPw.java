package Service;

import java.io.IOException;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import Model.MemberDao;
import Model.MemberVo;
import util.EmailUtil;

public class MemberVerifyFindPw implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

        String userid = request.getParameter("userid");
        String email = request.getParameter("email"); 
        if(userid == null || userid.isEmpty() || email == null || email.isEmpty()){
            response.getWriter().println("아이디와 이메일을 모두 입력해주세요.");
            return;
        }

        MemberDao dao = new MemberDao();
        MemberVo vo = dao.getMemberById(userid);
        if(vo == null){
            response.getWriter().println("존재하지 않는 아이디입니다.");
            return;
        }

        String registeredEmail = vo.getEmail();
        if(!registeredEmail.equals(email)){
            response.getWriter().println("입력하신 이메일이 등록된 이메일과 일치하지 않습니다.");
            return;
        }

        // 6자리 인증 코드 생성
        String authCode = generateAuthCode();

        // 이메일 전송
        boolean emailSent = sendEmail(email, authCode);
        if(!emailSent){
            response.getWriter().println("이메일 전송 실패");
            return;
        }

        // 세션에 인증 코드 저장
        HttpSession session = request.getSession();
        session.setAttribute("resetPwAuthCode", authCode);
        session.setAttribute("resetPwUserId", userid);
        session.setAttribute("authCodeExpiry", System.currentTimeMillis() + 2 * 60 * 1000);

        response.getWriter().println("success");
   }

   private String generateAuthCode(){
        Random random = new Random();
        int code = random.nextInt(900000) + 100000;
        return String.valueOf(code);
   }

   private boolean sendEmail(String toEmail, String authCode){
        try{
             Session mailSession = EmailUtil.getMailSession();
             Message message = new MimeMessage(mailSession);
             message.setFrom(new InternetAddress("dptmf3290@gmail.com"));
             message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
             message.setSubject("[사이트이름] 비밀번호 재설정 이메일 인증 코드");
             String content = "인증 코드: " + authCode + "\n\n이 코드는 2분간 유효합니다.";
             message.setText(content);
             Transport.send(message);
             return true;
        } catch(MessagingException e){
             e.printStackTrace();
             return false;
        }
		

	}

}
