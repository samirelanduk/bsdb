package org.bsdbmanage;

public class InteractionPdb {

  private String mapId;
  private int interactionId;
  private String pdbCode;
  private boolean manuallyAdded;
  private boolean manuallyMarkedCorrect;
  private String het;
  private String[] bindingResidues;
  private String receptorChain;
  private int originalChainLength;
  private String bindSequence;


  public InteractionPdb(Object[] fields) {
    this.mapId = (String)fields[0];
    this.interactionId = (int)fields[1];
    this.pdbCode = (String)fields[2];
    this.manuallyAdded = (boolean)fields[3];
    this.manuallyMarkedCorrect = (boolean)fields[4];
    this.het = (String)fields[5];
    this.bindingResidues = ((String)fields[6]) == null ? null : ((String)fields[6]).split(", ");
    this.receptorChain = (String)fields[7];
    this.originalChainLength = fields[8] == null ? 0 : (int)fields[8];
    this.bindSequence = (String)fields[9];
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


	public boolean isManuallyAdded() {
		return manuallyAdded;
	}


	public void setManuallyAdded(boolean manuallyAdded) {
		this.manuallyAdded = manuallyAdded;
	}


	public String getHet() {
		return het;
	}


	public void setHet(String het) {
		this.het = het;
  }


	public String[] getBindingResidues() {
		return bindingResidues;
	}


	public void setBindingResidues(String[] bindingResidues) {
		this.bindingResidues = bindingResidues;
  }


	public String getReceptorChain() {
		return receptorChain;
	}


	public void setReceptorChain(String receptorChain) {
		this.receptorChain = receptorChain;
  }


	public int getOriginalChainLength() {
		return originalChainLength;
	}


	public void setOriginalChainLength(int originalChainLength) {
		this.originalChainLength = originalChainLength;
	}


	public String getBindSequence() {
		return bindSequence;
	}


	public void setBindSequence(String bindSequence) {
		this.bindSequence = bindSequence;
  }
}
