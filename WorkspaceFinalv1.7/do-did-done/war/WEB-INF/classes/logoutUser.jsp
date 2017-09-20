<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

<%
	session.removeAttribute("user");
	session.removeAttribute("userName");
    response.sendRedirect("../base.html");
%>