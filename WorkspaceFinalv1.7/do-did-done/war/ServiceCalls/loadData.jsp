<%@page import="com.sandip.dodiddone.constants.DBConstantsEvent"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>

<%@ page import="com.sandip.dodiddone.Event"%>
<%@ page import="com.sandip.dodiddone.EventList"%>

<%@ page import="com.google.appengine.api.datastore.Entity"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreService"%>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory"%>
<%@ page import="com.google.appengine.api.datastore.PreparedQuery"%>
<%@ page import="com.google.appengine.api.datastore.Query"%>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilter"%>
<%@ page import="com.google.appengine.api.datastore.Query.CompositeFilterOperator"%>

<%

	String user = (String) session.getAttribute("user");
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Filter userFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_USER, 
    		FilterOperator.EQUAL, user);
    Filter dateFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_DATE, 
		FilterOperator.EQUAL, request.getParameter("date"));
    CompositeFilter compositeFilter =
		    CompositeFilterOperator.and(userFilter, dateFilter);
    Query query = new Query(DBConstantsEvent.DB_KIND_NAME).setFilter(compositeFilter);
    PreparedQuery pq = datastore.prepare(query);
    EventList eventList = new EventList();
	for(Entity entity : pq.asIterable()) {
		eventList.addToList(entity);
	}
    out.println(eventList.toJSON());
%>