//비밀번호 재설정 링크 발송
package Service;

import java.io.IOException;


import java.util.UUID;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import Model.MemberDao;
import Model.MemberVo;
import util.EmailUtil;

public class MemberFindPwToken implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		
		 // 인증 후 세션에 저장된 userid 사용
        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("resetPwUserId");
        if(userid == null){
            response.getWriter().println("세션이 만료되었습니다.");
            return;
        }

        // DB에서 해당 아이디의 회원 정보 조회 (이메일 확인)
        MemberDao dao = new MemberDao();
        MemberVo vo = dao.getMemberById(userid);
        if(vo == null){
            response.getWriter().println("사용자 정보가 존재하지 않습니다.");
            return;
        }
        String email = vo.getEmail();
        if(email == null || email.isEmpty()){
            response.getWriter().println("등록된 이메일 정보가 없습니다.");
            return;
        }
        
        // 먼저, 해당 사용자의 유효한 토큰이 이미 존재하는지 확인
        String existingToken = dao.getTokenByUserId(userid);
        if(existingToken != null) {
            // 기존 토큰이 있다면, 새로 보내지 않고 재전송 불가 메시지 전달
            response.getWriter().println("비밀번호 재설정 링크가 이미 발송되었습니다. 링크의 유효 기간 내에는 다시 요청할 수 없습니다.");
            return;
        }

        // UUID 기반 토큰 생성, 만료 시간 5분
        String token = UUID.randomUUID().toString();
        long expiryTime = System.currentTimeMillis() + 5 * 60 * 1000;

        // 토큰 DB 저장
        MemberDao tokenDao = new MemberDao();
        int tokenResult = tokenDao.createResetToken(userid, token, expiryTime);
        if (tokenResult <= 0) {
            response.getWriter().println("토큰 생성에 실패했습니다.");
            return;
        }

        // 비밀번호 재설정 링크 생성 (토큰 포함)
        String resetLink = request.getScheme() + "://" + request.getServerName() + ":" +
               request.getServerPort() + request.getContextPath() +
               "/mem/findpwReset.jsp?token=" + token;
        boolean emailSent = sendEmail(email, resetLink);
        if (!emailSent) {
            response.getWriter().println("이메일 전송 실패");
            return;
        }
        
        response.getWriter().println("비밀번호 재설정 이메일이 전송되었습니다.");
   }

   // 이메일 전송 (토큰 링크 포함)
   private boolean sendEmail(String toEmail, String resetLink) {
       try {
           Session mailSession = EmailUtil.getMailSession();
           Message message = new MimeMessage(mailSession);
           message.setFrom(new InternetAddress("dptmf3290@gmail.com"));
           message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
           message.setSubject("[FanTastic] 비밀번호 재설정 링크");
           
           String emailContent = 
               "안녕하세요.\n\n" +
               "아래 링크를 클릭하여 비밀번호를 재설정해주세요.\n" +
               resetLink + "\n\n" +
               "이 링크는 5분 동안 유효합니다.\n\n" +
               "감사합니다.\n" +
               "[FanTastic] 드림";
           
           message.setText(emailContent);
           Transport.send(message);
           return true;
       } catch (MessagingException e) {
           e.printStackTrace();
           return false;
       }

	}

}
