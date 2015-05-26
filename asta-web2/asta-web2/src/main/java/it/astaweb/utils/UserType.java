package it.astaweb.utils;


public enum UserType {
	
	SUPERADMIN("Superadmin"),
	ADMIN("Admin"),
	USER("User");
	
	private final String value;
	
	private UserType(String value) {
		this.value = value;
	}
	
	public static UserType toItemStatusFromDescription(
			String value) throws IllegalArgumentException {
		for (UserType status : values()) {
			if (status.getValue().toLowerCase().equals(
					value.toLowerCase())) {
				return status;
			}
		}
		throw new IllegalArgumentException(value);
	}

	public String getValue() {
		return value;
	}
	

}
