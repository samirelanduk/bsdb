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
  private double proportionalLength;
  private int internalContacts;
  private int externalContacts;
  private double contactRatio;
  private String residueInternalContacts;
  private String residueExternalContacts;


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
    this.proportionalLength = fields[10] == null ? 0.0 : (float)fields[10];
    this.internalContacts = fields[11] == null ? 0 : (int)fields[11];
    this.externalContacts = fields[12] == null ? 0 : (int)fields[12];
    this.contactRatio = fields[13] == null ? 0.0 : (float)fields[13];
    this.residueInternalContacts = (String)fields[14];
    this.residueExternalContacts = (String)fields[15];
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


	public double getProportionalLength() {
		return proportionalLength;
	}


	public void setProportionalLength(double proportionalLength) {
		this.proportionalLength = proportionalLength;
	}


	public int getInternalContacts() {
		return internalContacts;
	}


	public void setInternalContacts(int internalContacts) {
		this.internalContacts = internalContacts;
	}


	public int getExternalContacts() {
		return externalContacts;
	}


	public void setExternalContacts(int externalContacts) {
		this.externalContacts = externalContacts;
	}


	public double getContactRatio() {
		return contactRatio;
	}


	public void setContactRatio(double contactRatio) {
		this.contactRatio = contactRatio;
	}


	public String getResidueInternalContacts() {
		return residueInternalContacts;
	}


	public void setResidueInternalContacts(String residueInternalContacts) {
		this.residueInternalContacts = residueInternalContacts;
  }


	public String getResidueExternalContacts() {
		return residueExternalContacts;
	}


	public void setResidueExternalContacts(String residueExternalContacts) {
		this.residueExternalContacts = residueExternalContacts;
  }
}
