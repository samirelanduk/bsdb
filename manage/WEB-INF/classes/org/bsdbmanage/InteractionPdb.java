package org.bsdbmanage;

public class InteractionPdb {

  private String mapId;
  private Interaction interaction;
  private String pdbCode;
  private boolean manuallyMarkedCorrect;

  public InteractionPdb(Object[] fields) {
    this.mapId = (String)fields[0];
    this.interaction = DatabaseAccess.getInteraction((int)fields[1]);
    this.pdbCode = (String)fields[2];
    this.manuallyMarkedCorrect = (boolean)fields[3];
  }


	public String getMapId() {
		return mapId;
	}


	public void setMapId(String mapId) {
		this.mapId = mapId;
  }


	public Interaction getInteraction() {
		return interaction;
	}


	public void setInteraction(Interaction interaction) {
		this.interaction = interaction;
	}


	public String getPdbCode() {
		return pdbCode;
	}


	public void setPdbCode(String pdbCode) {
		this.pdbCode = pdbCode;
	}
}
