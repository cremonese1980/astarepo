package it.astaweb.utils;


public enum ItemNewsStatus {
	
	TO_SEND("Da Inviare"),
	TO_SEND_AGAIN("Da inviare nuovamente"),
	SENT("Inviata");
	
	private final String value;
	
	private ItemNewsStatus(String value) {
		this.value = value;
	}
	
	public static ItemNewsStatus toItemStatusFromDescription(
			String value) throws IllegalArgumentException {
		for (ItemNewsStatus status : values()) {
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
