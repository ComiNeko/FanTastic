package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.CreatorDao;
import Model.CreatorVo;
import Model.MemberDao;
import Model.MemberVo;
import util.PasswordUtil;

public class MemberLogin implements Command {

    @Override
    public void doCommand(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String userid = request.getParameter("userid");
        String password = request.getParameter("password");

        MemberDao dao = new MemberDao();
        MemberVo vo = dao.getMemberById(userid);

        // 아이디가 존재하지 않을 때
        if (vo == null) {
            System.out.println("해당 userid의 회원이 존재하지 않습니다.");
            response.getWriter().write("fail"); // 프론트엔드로 실패 알림
            return;
        }

        // 비밀번호 일치 확인
        System.out.println("DB에 저장된 해시: " + vo.getPassword());
        boolean isMatch = PasswordUtil.checkPassword(password, vo.getPassword());
        System.out.println("비밀번호 일치 여부: " + isMatch);

        if (isMatch) {
            // 로그인 성공
            HttpSession session = request.getSession();
            session.setAttribute("user", vo); // 회원 정보 세션 저장

            // 작가 정보 세션 저장
            CreatorDao creatorDao = new CreatorDao();
            CreatorVo authorVo = creatorDao.getAuthorProfileByUserId(userid); // userid로 작가 조회
            if (authorVo != null) {
                session.setAttribute("authorid", authorVo.getAuthorid()); // 작가 ID 세션 저장
                System.out.println("로그인한 authorid: " + authorVo.getAuthorid());
            } else {
                System.out.println("작가 정보 없음.");
            }

            // 성공 응답
            response.getWriter().write("success");
        } else {
            // 비밀번호가 틀렸을 때
            System.out.println("비밀번호가 일치하지 않습니다.");
            response.getWriter().write("fail");
        }
    }
}
