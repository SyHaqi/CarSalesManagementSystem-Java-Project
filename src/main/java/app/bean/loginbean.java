package app.bean;

import java.io.Serializable;

public class loginbean implements Serializable {

	private static final long serialVersionUID = 1L;

	private int userId;
	private String username;
	private String password;
	private boolean loggedIn = false;

	// No-arg constructor (REQUIRED for beans)
	public loginbean() {}

	public loginbean(int userId, String username, String password, boolean loggedIn) {
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.loggedIn = loggedIn;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserid(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isLoggedIn() {
		return loggedIn;
	}

	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}
}
