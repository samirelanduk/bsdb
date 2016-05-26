package org.bsdbmanage;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.SQLException;

public class Interaction {

	private int interactionId;
	private int ligandId;
	private int targetId;
	private String species;
	private String type;
	private String action;
	private String affinityType;
	private float affinityValue;
	private String affinityRange;
	private boolean ligandIsPeptide;
  private Date dateAdded;
  private Date dateModified;
  private Date datePdbsLastChecked;
	private ArrayList<InteractionPdb> pdbMaps;
	private ArrayList<FalseMap> falseMaps;


  public Interaction(Object[] fields) {
    this.interactionId = (Integer)fields[0];
    this.ligandId = (Integer)fields[1];
    this.targetId = (Integer)fields[2];
    this.species = (String)fields[3];
    this.type = (String)fields[4];
    this.action = (String)fields[5];
    this.affinityType = (String)fields[6];
		try {
    	this.affinityValue = (Float)fields[7];
		} catch (NullPointerException e) {

		}
    this.affinityRange = (String)fields[8];
    this.ligandIsPeptide = (Boolean)fields[9];
    this.dateAdded = (Date)fields[10];
    this.dateModified = (Date)fields[11];
    this.datePdbsLastChecked = (Date)fields[12];
		this.pdbMaps = DatabaseAccess.getPdbMapsOfInteraction(this.interactionId);
		this.falseMaps = DatabaseAccess.getfalseMapsOfInteraction(this.interactionId);
  }


	public String toHtmlRow() {
		String ligandLink = "http://guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=%d";
		String targetLink = "http://guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=%d";
		SimpleDateFormat ft = new SimpleDateFormat("dd.MM.yy HH:mm");
		StringBuilder pdbList = new StringBuilder();
		for (InteractionPdb pdbMap : pdbMaps) {
			pdbList.append(String.format("%s%s</span>", pdbMap.isManuallyMarkedCorrect() ? "<span class='manual'>" : "<span class='auto'>", Utilities.enclose("a", String.format("href='/manage/pdbmap.jsp?id=%d%s'", interactionId, pdbMap.getPdbCode()), pdbMap.getPdbCode())) + ", ");
		}
		StringBuilder falsePdbs = new StringBuilder();
		for (FalseMap falseMap : falseMaps) {
			falsePdbs.append(String.format("<span class='incorrect'>%s</span>", Utilities.enclose("a", String.format("href='/manage/falsemap.jsp?id=%d%s'", interactionId, falseMap.getPdbCode()), falseMap.getPdbCode())));
		}
		return Utilities.enclose(
			"tr", "",
			String.format(
				"%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
				Utilities.enclose("td", "", String.format("%d", interactionId)),
				Utilities.enclose("td", "", String.format(
				 "<a href='http://guidetopharmacology.org/GRAC/LigandDisplayForward?ligandId=%d' target='_blank'>%d</a>",
				 ligandId, ligandId
				)),
				Utilities.enclose("td", "", String.format(
				 "<a href='http://guidetopharmacology.org/GRAC/ObjectDisplayForward?objectId=%d' target='_blank'>%d</a>",
				 targetId, targetId
				)),
				Utilities.enclose("td", "", species),
				Utilities.enclose("td", "", type),
				Utilities.enclose("td", "", action),
				Utilities.enclose("td", "", affinityType == null ? "-" : affinityType),
				Utilities.enclose("td", "", affinityValue == 0.0 ? "-" : String.format("%.2f", affinityValue)),
				Utilities.enclose("td", "", affinityRange.equals("") ? "-" : affinityRange),
				Utilities.enclose("td", "", ligandIsPeptide ? "Yes" : "No"),
				Utilities.enclose("td", "", ft.format(dateAdded)),
				Utilities.enclose("td", "", ft.format(dateModified)),
				Utilities.enclose("td", "", datePdbsLastChecked != null ? ft.format(datePdbsLastChecked) : "Never"),
				Utilities.enclose("td", "class='pdblist'", (pdbMaps.size() == 0 ? "-" : pdbList.toString().substring(0, pdbList.length() - 2)) + String.format("<form method='POST' action='/manage/add_pdb.jsp'><input type='hidden' name='interactionId' value='%d'><input type='text' name='pdbCode'></form>", this.interactionId)),
				Utilities.enclose("td", "", (falseMaps.size() == 0 ? "-" : falsePdbs.toString().substring(0, falsePdbs.length() - 2)))
			)
		);
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


	public float getAffinityValue() {
		return affinityValue;
	}


	public void setAffinityValue(float affinityValue) {
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


	public ArrayList<InteractionPdb> getPdbMaps() {
		return pdbMaps;
	}


	public void setPdbMaps(ArrayList<InteractionPdb> pdbMaps) {
		this.pdbMaps = pdbMaps;
	}


	public ArrayList<FalseMap> getFalseMaps() {
		return falseMaps;
	}


	public void setFalseMaps(ArrayList<FalseMap> falseMaps) {
		this.falseMaps = falseMaps;
	}

}
