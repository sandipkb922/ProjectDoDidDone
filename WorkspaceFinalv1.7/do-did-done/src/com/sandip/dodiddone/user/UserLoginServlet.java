package com.sandip.dodiddone.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.CompositeFilter;
import com.google.appengine.api.datastore.Query.CompositeFilterOperator;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.sandip.dodiddone.constants.DBConstantsUser;

@SuppressWarnings("serial")
public class UserLoginServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		boolean flag = false;
		Filter usernameCheck = new FilterPredicate(DBConstantsUser.DB_PROPERTY_USERNAME, FilterOperator.EQUAL, username);
		Filter passwordCheck = new FilterPredicate(DBConstantsUser.DB_PROPERTY_PASSWORD, FilterOperator.EQUAL, password);
		CompositeFilter validationCheck =
			    CompositeFilterOperator.and(usernameCheck, passwordCheck);
		Query query = new Query(DBConstantsUser.DB_KIND_NAME).setFilter(validationCheck);
		PreparedQuery pq = datastore.prepare(query);
		UserDetails user = null;
		for(Entity entity : pq.asIterable()) {
			user = new UserDetails();
			user.loadAttributes(entity.getProperties());
			flag = true;
		}
		
		if(flag) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user.getUserName());
			session.setAttribute("userName", user.getFirstName() + " " + user.getLastName());
			response.sendRedirect("home.jsp");
		} else {
			request.setAttribute("messageFromServer", "Invalid Credentials.");
			RequestDispatcher rd = request.getRequestDispatcher("UserJSP/login.jsp");
			try {
				rd.forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			}
		}
	}

}