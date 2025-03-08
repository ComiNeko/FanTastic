package Service;

import java.io.IOException;
import java.util.Random;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.corba.se.impl.protocol.giopmsgheaders.Message;

import Model.MemberDao;
import Model.MemberVo;
import util.EmailUtil;

public class MemberFindPwid implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
	}

}
