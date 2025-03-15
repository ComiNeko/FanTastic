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
        if(fullAddress != null) {
            String[] splitted = fullAddress.split("\\|\\|");
            if(splitted.length == 2) {
                // 제대로 구분자가 있는 경우
                address = splitted[0];         
                detailAddress = splitted[1];  
            } else {
                // 구분자가 없거나 이상한 경우 전체를 address로 처리
                address = fullAddress;
                detailAddress = "";
            }
        }  
        request.setAttribute("address", address);
        request.setAttribute("detailAddress", detailAddress);
       

	}

}
