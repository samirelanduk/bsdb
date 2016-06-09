package org.manage;

public class FalseMap {

  private String mapId;
  private int interactionId;
  private String pdbCode;

  public FalseMap(Object[] fields) {
    this.mapId = (String)fields[0];
    this.interactionId = (int)fields[1];
    this.pdbCode = (String)fields[2];
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
}
