package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;
import Model.MemberVo;

public class MemberUserUpdate implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");

        // 수정불가 항목은 세션에 저장된 정보를 사용 (예: userid)
        MemberVo sessionUser = (MemberVo) request.getSession().getAttribute("user");
        String userid = sessionUser.getUserid();

        // 폼으로부터 수정 가능한 항목 읽기
        String phonenumber = request.getParameter("phonenumber");
        String address = request.getParameter("address");         // 주소
        String detailAddress = request.getParameter("detailAddress"); // 상세 주소

     // 두 개의 주소값을 합침
     // 특수 구분자(||)로 넣어, 주소-상세주소 분리
        String fullAddress = address + "||" + detailAddress;

        // MemberVo 객체에 수정 값 설정 (수정불가 항목은 변경하지 않음)
        MemberVo vo = new MemberVo();
        vo.setUserid(userid);
        vo.setPhonenumber(phonenumber);
        vo.setAddress(fullAddress);

        // DB 업데이트 호출
        int result = new MemberDao().updateMember(vo);

        if(result > 0) {
            // 성공 시 세션 갱신
            sessionUser.setPhonenumber(phonenumber);
            sessionUser.setAddress(fullAddress);

            // 업데이트 성공 → "/updateMyInfo.do"로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/member/updateMyInfo.do");
        } else {
            // 실패 시 → 수정 폼으로 forward
            request.setAttribute("updateResult", "fail");
            request.setAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
            request.getRequestDispatcher("/mem/UpdateMyInfo.jsp").forward(request, response);
        }
    }
}
	
