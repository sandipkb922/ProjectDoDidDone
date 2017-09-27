$(document).ready(function(){
	var currentDateObject = new Date();
	formCalendar(currentDateObject);
	initiateSearch(getDBDate(currentDateObject));
	
	stopLoad();
    
    $("#create").click(function(){
    	if(!($("#eventName").val() === "")) {
    		createRecord();
    		document.getElementById("eventName").value = "";
    	}
    });  
});



var stateChangeNext = function(buttonId) {
	  console.log("Button Clicked: " + buttonId);
	  updateRecord(buttonId, "next");	  
};

var stateChangePrevious = function(buttonId) {
	  console.log("Button Clicked: " + buttonId);
	  updateRecord(buttonId, "previous");	  
};

var deleteEvent = function(buttonId) {
	  console.log("Button Clicked: " + buttonId);
	  deleteRecord(buttonId);	  
};

var updateEventName = function(eventId, newEventName, htmlEvent) {
	if(typeof htmlEvent !== 'undefined' && htmlEvent.keyCode === 13) {
		renameRecord(eventId, newEventName);
	}
};

var initiateSearch = function(searchDate) {
	    currentDate = searchDate;
	    refreshCurrentMonth();
    	searchDB();
};