package com.sandip.dodiddone;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

import com.google.appengine.api.datastore.Entity;

public class EventList {
	private List<Event> eventList = new ArrayList<Event>();
	
	public void addToList(Entity entity) {
		Event event = new Event();
		event.setEventDate((String)entity.getProperty("Date"));
		event.setEventId((String)entity.getProperty("EventId"));
		event.setEventName((String)entity.getProperty("EventName"));
		event.setEventStatus((String)entity.getProperty("State"));
		eventList.add(event);
	}
	
	public String toJSON() {
		final ObjectMapper mapper = new ObjectMapper();
		String jsonInString = "";
	    try {
			 jsonInString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(eventList);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	    
	    return jsonInString;
	}
	
}
