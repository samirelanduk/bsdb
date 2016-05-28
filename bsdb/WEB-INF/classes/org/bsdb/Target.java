package org.bsdb;

public class Target {

	private int targetId;
	private String name;
	private String type;

	public Target() {
		this.targetId = 0;
		this.name = "UNKNOWN TARGET";
	}

	public Target(Object[] fields) {
		this.targetId = (Integer)fields[0];
		this.name = (String)fields[1];
		this.type = (String)fields[2];
	}


	public int getTargetId() {
		return targetId;
	}


	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}
}
