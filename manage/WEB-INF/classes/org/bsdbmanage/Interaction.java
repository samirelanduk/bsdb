package org.bsdbmanage;

import java.util.Date;
import java.sql.SQLException;

public class Interaction {

	private int interactionId;
	private int ligandId;
	private int targetId;
	private String species;
	private String type;
	private String action;
	private String affinityType;
	private double affinityValue;
	private String affinityRange;
	private boolean ligandIsPeptide;
  private Date dateAdded;
  private Date dateModified;
  private Date datePdbsLastChecked;


  public Interaction(Object[] fields) {
    this.interactionId = (Integer)fields[0];
    this.ligandId = (Integer)fields[1];
    this.targetId = (Integer)fields[2];
    this.species = (String)fields[3];
    this.type = (String)fields[4];
    this.action = (String)fields[5];
    this.affinityType = (String)fields[6];
    this.affinityValue = (Double)fields[7];
    this.affinityRange = (String)fields[8];
    this.ligandIsPeptide = (Boolean)fields[9];
    this.dateAdded = (Date)fields[10];
    this.dateModified = (Date)fields[11];
    this.datePdbsLastChecked = (Date)fields[12];
  }


	public int getInteractionId() {
		return interactionId;
	}


	public void setInteractionId(int interactionId) {
		this.interactionId = interactionId;
	}


	public int getLigandId() {
		return ligandId;
	}


	public void setLigandId(int ligandId) {
		this.ligandId = ligandId;
	}


	public int getTargetId() {
		return targetId;
	}


	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}


	public String getSpecies() {
		return species;
	}


	public void setSpecies(String species) {
		this.species = species;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getAction() {
		return action;
	}


	public void setAction(String action) {
		this.action = action;
	}


	public String getAffinityType() {
		return affinityType;
	}


	public void setAffinityType(String affinityType) {
		this.affinityType = affinityType;
	}


	public double getAffinityValue() {
		return affinityValue;
	}


	public void setAffinityValue(double affinityValue) {
		this.affinityValue = affinityValue;
	}


	public String getAffinityRange() {
		return affinityRange;
	}


	public void setAffinityRange(String affinityRange) {
		this.affinityRange = affinityRange;
	}


	public boolean isLigandIsPeptide() {
		return ligandIsPeptide;
	}


	public void setLigandIsPeptide(boolean ligandIsPeptide) {
		this.ligandIsPeptide = ligandIsPeptide;
	}


	public Date getDateAdded() {
		return dateAdded;
	}


	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
	}


	public Date getDateModified() {
		return dateModified;
	}


	public void setDateModified(Date dateModified) {
		this.dateModified = dateModified;
	}


	public Date getDatePdbsLastChecked() {
		return datePdbsLastChecked;
	}


	public void setDatePdbsLastChecked(Date datePdbsLastChecked) {
		this.datePdbsLastChecked = datePdbsLastChecked;
	}
  
}
