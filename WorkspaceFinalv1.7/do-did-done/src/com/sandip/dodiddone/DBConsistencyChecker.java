package com.sandip.dodiddone;

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
import com.sandip.dodiddone.constants.DBConstantsEvent;

public class DBConsistencyChecker {
	
	@SuppressWarnings("unused")
	public static boolean checkForUpdationSuccess(String expectedEventId, String expectedState) {
		boolean val = true;
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter eventIdFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_EVENT_ID, 
				FilterOperator.EQUAL, expectedEventId);
		Filter stateFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_STATE, 
				FilterOperator.EQUAL, expectedState);
		CompositeFilter compositeFilter =
			    CompositeFilterOperator.and(eventIdFilter, stateFilter);
		Query query = new Query("DoDidDone").setFilter(compositeFilter);
		while(val) {
			PreparedQuery pq = datastore.prepare(query);
			for(Entity entity : pq.asIterable()) {
				val = false;
			}
		}
		return !val;
	}
	
	@SuppressWarnings("unused")
	public static boolean checkForRenameSuccess(String expectedEventId, String expectedEventName) {
		boolean val = true;
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter eventIdFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_EVENT_ID, 
				FilterOperator.EQUAL, expectedEventId);
		Filter stateFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_EVENT_NAME, 
				FilterOperator.EQUAL, expectedEventName);
		CompositeFilter compositeFilter =
			    CompositeFilterOperator.and(eventIdFilter, stateFilter);
		Query query = new Query("DoDidDone").setFilter(compositeFilter);
		while(val) {
			PreparedQuery pq = datastore.prepare(query);
			for(Entity entity : pq.asIterable()) {
				val = false;
			}
		}
		return !val;
	}
	
	@SuppressWarnings("unused")
	public static boolean checkForDeletionSuccess(String expectedEventId) {
		boolean val = true;
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		Filter eventIdFilter = new FilterPredicate(DBConstantsEvent.DB_PROPERTY_EVENT_ID, 
				FilterOperator.EQUAL, expectedEventId);
		Query query = new Query("DoDidDone").setFilter(eventIdFilter);
		while(val) {
			PreparedQuery pq = datastore.prepare(query);
			val = false;
			for(Entity entity : pq.asIterable()) {
				val = true;
			}
		}
		return !val;
	}
}
