package com.sandip.dodiddone;

import java.io.IOException;
import javax.servlet.http.*;

@SuppressWarnings("serial")
public class Do_did_doneServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		resp.getWriter().println("Hello, world");
	}
}
