package it.astaweb.utils;


public enum Constants {
	
	PROPERTY_NAME_BASE_PATH("base.directory"),
	PROPERTY_NAME_MAX_UPLOAD_SIZE("max.upload.size"),
	PROPERTY_MIN_SELL_TIME_HOUR("min.sell.time.hour");
	
	private final String value;
	
	private Constants(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}
