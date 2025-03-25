//비밀번호 찾기 위한 서비스
//이메일 확인 및 인증 코드 발송
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

public class MemberFindPwEmail implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

        String userid = request.getParameter("userid");
        String email = request.getParameter("email"); 
        if(userid == null || userid.isEmpty() || email == null || email.isEmpty()){
            response.getWriter().println("IDとメールアドレスを両方入力してください。");
            return;
        }

        MemberDao dao = new MemberDao();
        MemberVo vo = dao.getMemberById(userid);
        if(vo == null){
            response.getWriter().println("存在しないユーザーIDです。");
            return;
        }

        String registeredEmail = vo.getEmail();
        if(!registeredEmail.equals(email)){
            response.getWriter().println("入力したメールアドレスが登録されたメールアドレスと一致しません。");
            return;
        }

        // 6자리 인증 코드 생성
        String authCode = generateAuthCode();

        // 이메일 전송
        boolean emailSent = sendEmail(email, authCode);
        if(!emailSent){
            response.getWriter().println("メール送信に失敗しました。");
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
	             message.setSubject("[FanTastic]パスワードリセットメール認証");
	             
	             String content = "こんにちは。FanTastic運営チームです。\n\n" +
			                      "パスワードをリセットするための認証コードをお送りします。\n\n" +
			                      "認証コード: " + authCode + "\n\n" +
			                      "認証コードは2分後に無効になります。早めにご確認ください。\n\n" +
			                      "ありがとうございます。\n\n" +
			                      "[FanTastic] 運営チームより";
	             
	             message.setText(content);
	             Transport.send(message);
	             return true;
	        } catch(MessagingException e){
	             e.printStackTrace();
	             return false;
	        }
		

	}

}
