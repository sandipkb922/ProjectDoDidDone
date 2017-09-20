package com.sandip.dodiddone.user;

import java.io.Serializable;
import java.util.Map;

@SuppressWarnings("serial")
public class UserDetails implements Serializable {
	private String userName;
	private String password;
	private String firstName;
	private String lastName;
	private String email;
	private String contactNumber;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public void loadAttributes(Map<String, Object> properties) {
		setUserName((String) properties.get("username"));
		setPassword((String) properties.get("password"));
		setFirstName((String) properties.get("firstName"));
		setLastName((String) properties.get("lastName"));
		setEmail((String) properties.get("email"));
		setContactNumber((String) properties.get("contactNumber"));
	}
	@Override
	public String toString() {
		return "UserDetails [userName=" + userName + ", password=" + password + ", firstName=" + firstName
				+ ", lastName=" + lastName + ", email=" + email + ", contactNumber=" + contactNumber + "]";
	}
	
	public String toHTMLTable() {
		String str = "<table>";
		str = str + "<tr><td>User Name : </td><td>" + this.userName + "</td></tr>";
		str = str + "<tr><td>Password : </td><td>" + this.password + "</td></tr>"; 
		str = str + "<tr><td>First Name : </td><td>" + this.firstName + "</td></tr>"; 
		str = str + "<tr><td>Last Name : </td><td>" + this.lastName + "</td></tr>"; 
		str = str + "<tr><td>Email Id : </td><td>" + this.email + "</td></tr>"; 
		str = str + "<tr><td>Contact Number : </td><td>" + this.contactNumber + "</td></tr>"; 
		str = str + "</table>";
		
		return str;
	}

}
