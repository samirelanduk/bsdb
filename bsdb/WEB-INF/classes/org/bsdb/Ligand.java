package org.bsdb;

import java.sql.SQLException;

public class Ligand {

	private int ligandId;
	private String name;
	private String type;
	private boolean radioactive;
	private boolean approved;
	private String approvalSource;
	private int hBondAcceptors;
	private int hBondDonors;
	private int rotatableBonds;
	private float surfaceArea;
	private float mass;
	private float logP;
	private int lipinksi;
	private String[] synonyms;

	public Ligand() {
		//Empty ligand
	}

	public Ligand(Object[] fields) {
		this.ligandId = (Integer)fields[0];
		this.name = (String)fields[1];
		this.type = (String)fields[2];
		this.radioactive = (Boolean)fields[3];
		this.approved = (Boolean)fields[4];
		this.approvalSource = (String)fields[5];
		this.hBondAcceptors = (Integer)fields[6];
		this.hBondDonors = (Integer)fields[7];
		this.rotatableBonds = (Integer)fields[8];
		this.surfaceArea = (Float)fields[9];
		this.mass = (Float)fields[10];
		this.logP = (Float)fields[11];
		this.lipinksi = (Integer)fields[11];
		this.synonyms = ((String)fields[13]).split("#");
	}

	public LigandLink[] getExternalLinks() {
		return Utilities.getLigandLinks(this.ligandId);
	}

	public int getLigandId() {
		return ligandId;
	}

	public void setLigandId(int ligandId) {
		this.ligandId = ligandId;
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

	public boolean isRadioactive() {
		return radioactive;
	}

	public void setRadioactive(boolean radioactive) {
		this.radioactive = radioactive;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public String getApprovalSource() {
		return approvalSource;
	}

	public void setApprovalSource(String approvalSource) {
		this.approvalSource = approvalSource;
	}

	public int gethBondAcceptors() {
		return hBondAcceptors;
	}

	public void sethBondAcceptors(int hBondAcceptors) {
		this.hBondAcceptors = hBondAcceptors;
	}

	public int gethBondDonors() {
		return hBondDonors;
	}

	public void sethBondDonors(int hBondDonors) {
		this.hBondDonors = hBondDonors;
	}

	public int getRotatableBonds() {
		return rotatableBonds;
	}

	public void setRotatableBonds(int rotatableBonds) {
		this.rotatableBonds = rotatableBonds;
	}

	public float getSurfaceArea() {
		return surfaceArea;
	}

	public void setSurfaceArea(float surfaceArea) {
		this.surfaceArea = surfaceArea;
	}

	public float getMass() {
		return mass;
	}

	public void setMass(float mass) {
		this.mass = mass;
	}

	public float getLogP() {
		return logP;
	}

	public void setLogP(float logP) {
		this.logP = logP;
	}

	public int getLipinksi() {
		return lipinksi;
	}

	public void setLipinksi(int lipinksi) {
		this.lipinksi = lipinksi;
	}

	public String[] getSynonyms() {
		return synonyms;
	}

	public void setSynonyms(String[] synonyms) {
		this.synonyms = synonyms;
	}

}
