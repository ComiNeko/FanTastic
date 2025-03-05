package Service;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.MemberDao;
import Model.MemberVo;
import util.PasswordUtil;

public class MemberUserSave implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
        
        // 폼으로부터 파라미터 읽기
        String name = request.getParameter("name");
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm"); //얘는 왜?
        String phonenumber = request.getParameter("phonenumber");
        
        String address = request.getParameter("address"); 
        String detailAddress = request.getParameter("detailAddress");
        
        String emailPrefix = request.getParameter("emailPrefix");
        String emailDomain = request.getParameter("emailDomain");
        if ("custom".equals(emailDomain)) {
            emailDomain = request.getParameter("customEmailDomain");
        }
        String email = emailPrefix + "@" + emailDomain;
	        
	        // 비밀번호 일치 검사
	        if (!password.equals(passwordConfirm)) {
	            request.setAttribute("errorMsg", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
	            request.getRequestDispatcher("signup.jsp").forward(request, response);
	            return;
	        }
        
        //비밀번호 암호화 처리
        String hashedPassword = PasswordUtil.hashPassword(password);
        
        //MemberVo 객체에 값 설정
        MemberVo vo = new MemberVo();
        vo.setName(name); 
        vo.setUserid(userid);
        vo.setPassword(hashedPassword);
        vo.setPhonenumber(phonenumber);
        vo.setEmail(email);
        vo.setAddress(address + " " + detailAddress);
        
        //DB에 저장
        new MemberDao().saveUser(vo);
        
        
    }


	}


