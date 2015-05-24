package it.astaweb.utils;


public enum Constants {
	
	PROPERTY_NAME_BASE_PATH("base.directory"),
	PROPERTY_NAME_MAX_UPLOAD_SIZE("max.upload.size");
	
	private final String value;
	
	private Constants(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}
}
