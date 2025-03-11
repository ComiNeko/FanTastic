package Service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberVo;

public class MemberUserAddress implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 세션에 저장된 사용자 정보에서 address 가져오기
        MemberVo sessionUser = (MemberVo) request.getSession().getAttribute("user");
        String fullAddress = sessionUser.getAddress(); // 저장된 전체 주소
        
        String address = "";
        String detailAddress = "";
        if(fullAddress != null && fullAddress.contains(" ")) {
            int idx = fullAddress.indexOf(" ");
            address = fullAddress.substring(0, idx);
            detailAddress = fullAddress.substring(idx + 1);
        } else {
            address = fullAddress;  // 구분자 없으면 전체를 address로 처리
        }
        request.setAttribute("address", address);
        request.setAttribute("detailAddress", detailAddress);
        
        request.getRequestDispatcher("/member/updateMyInfo.jsp").forward(request, response);

	}

}
