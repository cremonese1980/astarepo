package it.astaweb.utils;


public enum ItemStatus {
	
	PRE_SELL("Da Vendere'"),
	ON_SELL("In Vendita'"),
	SOLD_OUT("Venduto'");
	
	private final String value;
	
	private ItemStatus(String value) {
		this.value = value;
	}
	
	public static ItemStatus toItemStatusFromDescription(
			String value) throws IllegalArgumentException {
		for (ItemStatus status : values()) {
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
