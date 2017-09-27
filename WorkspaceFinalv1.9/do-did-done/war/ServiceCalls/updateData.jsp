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
    String mode = request.getParameter("mode");
    String previousState = "";
    String currentState = "";
    String nextState = "";
    String targetState = "";
    for(Entity eventEntity : pq.asIterable()) {
		currentState = (String ) eventEntity.getProperty(DBConstantsEvent.DB_PROPERTY_STATE);
		previousState = EventStates.TODO.toString();
		nextState = EventStates.DONE.toString();
		if(currentState.equals(EventStates.TODO.toString())) {
			nextState = EventStates.DOING.toString();
		}
		if(currentState.equals(EventStates.DONE.toString())) {
			previousState = EventStates.DOING.toString();
		}
		if(mode.equals("next")) {
			targetState = nextState;
		} else {
			targetState = previousState;
		}
		eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_STATE, targetState);
		datastore.put(eventEntity);
    }
    
    boolean val = DBConsistencyChecker.checkForUpdationSuccess(request.getParameter("eventID"), targetState);
    out.println("Updation Successful");
%>