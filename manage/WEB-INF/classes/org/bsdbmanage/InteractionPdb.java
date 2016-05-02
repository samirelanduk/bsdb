package org.bsdbmanage;

public class InteractionPdb {

  private String mapId;
  private int interactionId;
  private String pdbCode;
  private boolean manuallyMarkedCorrect;

  public InteractionPdb(Object[] fields) {
    this.mapId = (String)fields[0];
    this.interactionId = (int)fields[1];
    this.pdbCode = (String)fields[2];
    this.manuallyMarkedCorrect = (boolean)fields[3];
  }


	public String getMapId() {
		return mapId;
	}


	public void setMapId(String mapId) {
		this.mapId = mapId;
  }


	public int getInteractionId() {
		return interactionId;
	}


	public void setInteractionId(int interactionId) {
		this.interactionId = interactionId;
	}


  public Interaction getInteraction() {
     return DatabaseAccess.getInteraction(this.interactionId);
  }


	public String getPdbCode() {
		return pdbCode;
	}


	public void setPdbCode(String pdbCode) {
		this.pdbCode = pdbCode;
	}


	public boolean isManuallyMarkedCorrect() {
		return manuallyMarkedCorrect;
	}


	public void setManuallyMarkedCorrect(boolean manuallyMarkedCorrect) {
		this.manuallyMarkedCorrect = manuallyMarkedCorrect;
	}
}
