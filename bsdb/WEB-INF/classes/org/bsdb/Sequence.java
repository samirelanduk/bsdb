package org.bsdb;

import java.sql.SQLException;

public class Sequence {

	/*private int interactionId;
	private Ligand ligand;
	private Target target;
	private String species;
	private String affinity;
	private String affinityType;
	private String action;
	private String type;
	private String sequence;
	private String pdb;
	private String notes;
	private int originalChainLength;
	private int length;
	private int internalContacts;
	private int externalContacts;
	private String hetName;
	private int hetId;
	private String chain;

	public Sequence() {
		this.target = new Target();
		this.ligand = new Ligand();
		this.sequence = "";
	}

	public Sequence(Object[] fields) {
		this.interactionId = (Integer)fields[0];
		try {
			this.ligand = Utilities.getLigand((Integer)fields[1]);
		} catch (SQLException | IndexOutOfBoundsException ce) {
			this.ligand = new Ligand();
		}
		try {
			this.target = Utilities.getTarget((Integer)fields[2]);
		} catch (SQLException | IndexOutOfBoundsException ce) {
			this.target = new Target();
		}
		this.species = (String)fields[3];
		this.affinity = (String)fields[4];
		this.affinityType = (String)fields[5];
		this.action = (String)fields[6];
		this.type = (String)fields[7];
		this.sequence = (String)fields[8];
		this.pdb = (String)fields[9];
		this.originalChainLength = (Integer)fields[10];
		this.length = (Integer)fields[11];
		this.internalContacts = (Integer)fields[12];
		this.externalContacts = (Integer)fields[13];
		this.hetName = (String)fields[14];
		this.hetId = (Integer)fields[15];
		this.chain = (String)fields[16];
		this.notes = (String)fields[17];
	}

	public String getConciseHtml() {
		String contents = Utilities.enclose(
				"a",
				String.format("href='/sequences/detail.jsp?id=%d'", getInteractionId()),
				String.format("%s (%d residues)", getTarget().getName(), getLength())
		);
		return Utilities.enclose("div", "class='sequence_link'", contents);
	}

	public int getInteractionId() {
		return interactionId;
	}

	public void setInteractionId(int interactionId) {
		this.interactionId = interactionId;
	}

	public Ligand getLigand() {
		return ligand;
	}

	public void setLigand(Ligand ligand) {
		this.ligand = ligand;
	}

	public Target getTarget() {
		return target;
	}

	public void setTarget(Target target) {
		this.target = target;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public String getAffinity() {
		return affinity;
	}

	public void setAffinity(String affinity) {
		this.affinity = affinity;
	}

	public String getAffinityType() {
		return affinityType;
	}

	public void setAffinityType(String affinityType) {
		this.affinityType = affinityType;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSequence() {
		return sequence;
	}

	public void setSequence(String sequence) {
		this.sequence = sequence;
	}

	public String getSequenceHtml() {
		StringBuilder s = new StringBuilder();
		for (char c : sequence.toCharArray()) {
			s.append(String.format("<span class='%s'>%s</span>", Character.isUpperCase(c) ? "up" : "between", c));
		}
		return s.toString();
	}

	public String getPdb() {
		return pdb;
	}

	public void setPdb(String pdb) {
		this.pdb = pdb;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public int getOriginalChainLength() {
		return originalChainLength;
	}

	public void setOriginalChainLength(int originalChainLength) {
		this.originalChainLength = originalChainLength;
	}

	public int getLength() {
		return length;
	}

	public void setLength(int length) {
		this.length = length;
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

	public String getHetName() {
		return hetName;
	}

	public void setHetName(String hetName) {
		this.hetName = hetName;
	}

	public int getHetId() {
		return hetId;
	}

	public void setHetId(int hetId) {
		this.hetId = hetId;
	}

	public String getChain() {
		return chain;
	}

	public void setChain(String chain) {
		this.chain = chain;
	}*/
}
