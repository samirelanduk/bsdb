package org.bsdbmanage;

public class InteractionPdb {

  private String mapId;
  private Interaction interaction;
  private String pdbCode;

  public InteractionPdb(Object[] fields) {
    this.mapId = (String)fields[0];
    this.pdbCode = (String)fields[2];
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
