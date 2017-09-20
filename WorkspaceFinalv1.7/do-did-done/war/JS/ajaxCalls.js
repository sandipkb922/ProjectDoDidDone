var currentDate = null;
var currentEventId = null;

var searchDB = function() {
	var request;
	request=new XMLHttpRequest();
	request.onreadystatechange = function() {
		  if (this.readyState === 4 && this.status === 200) {
			  var myArr = JSON.parse(this.responseText);
			  composeTable(myArr);
			  var createButton = document.getElementById("create");
			  createButton.innerText = "Add";
			  stopLoad();
		  }
		  if(this.readyState !== 4) {
			  startLoad();
		  }
	  };
	  
	  var dateInput = currentDate;
	  var ajaxInput = "date=" + dateInput;
	  request.open("POST", "ServiceCalls/loadData.jsp", true);
	  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  request.send(ajaxInput);
};

var createRecord = function() {
	 var request;
	 request=new XMLHttpRequest();
	 request.onreadystatechange = function() {
		  if (this.readyState === 4 && this.status === 200) {
			  searchDB();
			  stopLoad();
		  }
		  if(this.readyState !== 4) {
			  startLoad();
		  }
	  };
	  
	  var dateInput = currentDate;
	  var eventNameInput = $("#eventName").val();
	  var ajaxInput = "date=" + dateInput + "&" + "event=" + eventNameInput;
	  request.open("POST", "ServiceCalls/createData.jsp", true);
	  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  request.send(ajaxInput);
};

var updateRecord = function(buttonId, mode) {
	  var request;
	  request=new XMLHttpRequest();
	  request.onreadystatechange = function() {
		  if (this.readyState === 4 && this.status === 200) {
			  searchDB();
			  stopLoad();
		  }
		  if(this.readyState !== 4) {
			  startLoad();
		  }
	  };
	  
	  var ajaxInput = "eventID=" + buttonId + "&mode=" + mode;
	  request.open("POST", "ServiceCalls/updateData.jsp", true);
	  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  request.send(ajaxInput);
};

var deleteRecord = function(buttonId) {
	  var request;
	  request=new XMLHttpRequest();
	  request.onreadystatechange = function() {
		  if (this.readyState === 4 && this.status === 200) {
			  searchDB();
			  stopLoad();
		  }
		  if(this.readyState !== 4) {
			  startLoad();
		  }
	  };
	  
	  var ajaxInput = "eventID=" + buttonId;
	  request.open("POST", "ServiceCalls/deleteData.jsp", true);
	  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  request.send(ajaxInput);
};

var renameRecord = function(newEventName) {
	  var request;
	  request=new XMLHttpRequest();
	  request.onreadystatechange = function() {
		  if (this.readyState === 4 && this.status === 200) {
			  searchDB();
			  stopLoad();
		  }
		  if(this.readyState !== 4) {
			  startLoad();
		  }
	  };
	  
	  var ajaxInput = "eventID=" + currentEventId + "&newEventName=" + newEventName;
	  request.open("POST", "ServiceCalls/renameData.jsp", true);
	  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	  request.send(ajaxInput);
};