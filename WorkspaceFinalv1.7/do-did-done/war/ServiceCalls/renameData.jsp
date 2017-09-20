<%@page import="com.sandip.dodiddone.constants.EventStates"%>
<%@page import="com.sandip.dodiddone.constants.DBConstantsEvent"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sandip.dodiddone.DBConsistencyChecker"%>
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

<%
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
    Filter eventIdFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_EVENT_ID, 
		FilterOperator.EQUAL, request.getParameter("eventID"));
    Query query = new Query(DBConstantsEvent.DB_KIND_NAME).setFilter(eventIdFilter);
    PreparedQuery pq = datastore.prepare(query);
    String newEventName = request.getParameter("newEventName");
    for(Entity eventEntity : pq.asIterable()) {
		eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_EVENT_NAME, newEventName);
		datastore.put(eventEntity);
    }
    
    boolean val = DBConsistencyChecker.checkForRenameSuccess(request.getParameter("eventID"), newEventName);
    out.println("Rename Successful");
%>