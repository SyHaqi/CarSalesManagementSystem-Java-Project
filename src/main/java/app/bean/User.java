package app.bean;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;

	private int userId;
	private String username;
	private String password;
	private String fullname;
	private String role;
	private String email;
	private boolean loggedIn = false;
	private String avatar;
	private String getAvatar;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(int userId, String username, String password, String fullname, String role, String email,
			boolean loggedIn, String avatar, String getAvatar) {
		super();
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.fullname = fullname;
		this.role = role;
		this.email = email;
		this.loggedIn = loggedIn;
		this.avatar = avatar;
		this.getAvatar = getAvatar;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
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

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isLoggedIn() {
		return loggedIn;
	}

	public void setLoggedIn(boolean loggedIn) {
		this.loggedIn = loggedIn;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getGetAvatar() {
		return getAvatar;
	}

	public void setGetAvatar(String getAvatar) {
		this.getAvatar = getAvatar;
	}
	
	
	

}