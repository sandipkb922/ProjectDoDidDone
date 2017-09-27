<%@page import="com.sandip.dodiddone.constants.EventStates"%>
<%@ page import="java.util.UUID"%>
<%@ page import="com.sandip.dodiddone.constants.DBConstantsEvent"%>
<%@ page import="com.sandip.dodiddone.DBConsistencyChecker"%>
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
    String eventId = UUID.randomUUID().toString();
	String date = request.getParameter("date");
	String eventName = request.getParameter("event");
	String user = (String ) session.getAttribute("user");
	String state = EventStates.TODO.toString();
	Entity eventEntity = new Entity(DBConstantsEvent.DB_KIND_NAME);
	eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_EVENT_ID, eventId);
	eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_USER, user);
	eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_DATE, date);
	eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_EVENT_NAME, eventName);
	eventEntity.setProperty(DBConstantsEvent.DB_PROPERTY_STATE, state);
	datastore.put(eventEntity);
	
	boolean val = DBConsistencyChecker.checkForUpdationSuccess(eventId, state);
		
	out.println("Successfully created" + val);
%>