package org.bsdb;

import java.sql.SQLException;

public class Sequence {

	private int sequenceId;
	private Ligand ligand;
	private Target target;
	private String species;
	private String type;
	private String action;
	private float affinity;
	private String affinityRange;
	private String affinityType;
	private String hetId;
	private String bindingResidues;
	private String chain;
	private int originalChainLength;
	private String sequence;
	private String pdb;
	private float proportionalLength;
	private int internalContacts;
	private int externalContacts;
	private float contactRatio;
	private String residueIds;

	public Sequence() {
		this.target = new Target();
		this.ligand = new Ligand();
		this.sequence = "";
	}

	public Sequence(Object[] fields) {
		this.sequenceId = (Integer)fields[0];
		try {
			this.ligand = DatabaseAccess.getLigand((Integer)fields[1]);
		} catch (IndexOutOfBoundsException ce) {
			this.ligand = new Ligand();
		}
		try {
			this.target = DatabaseAccess.getTarget((Integer)fields[2]);
		} catch (IndexOutOfBoundsException ce) {
			this.target = new Target();
		}
		this.species = (String)fields[3];
		this.type = (String)fields[4];
		this.action = (String)fields[5];
		this.affinity = (float)fields[6];
		this.affinityRange = (String)fields[7];
		this.affinityType = (String)fields[8];
		this.hetId = (String)fields[9];
		this.bindingResidues = (String)fields[10];
		this.chain = (String)fields[11];
		this.originalChainLength = (Integer)fields[12];
		this.sequence = (String)fields[13];
		this.pdb = (String)fields[14];
		this.proportionalLength = (float)fields[15];
		this.internalContacts = (Integer)fields[16];
		this.externalContacts = (Integer)fields[17];
		this.contactRatio = (float)fields[18];
		this.residueIds = (String)fields[19];
	}

	public String getConciseHtml() {
		String contents = Utilities.enclose(
				"a",
				String.format("href='/sequences/detail.jsp?id=%d'", getSequenceId()),
				String.format(
				 "%s (%d residues)",
				 getTarget().getName(),
				 getSequence().length()
				)
		);
		return Utilities.enclose("div", "class='sequence_link'", contents);
	}


	public int getSequenceId() {
		return sequenceId;
	}


	public void setSequenceId(int sequenceId) {
		this.sequenceId = sequenceId;
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


	public float getAffinity() {
		return affinity;
	}


	public void setAffinity(float affinity) {
		this.affinity = affinity;
	}


	public String getAffinityRange() {
		return affinityRange;
	}


	public void setAffinityRangee(String affinityRange) {
		this.affinityRange = affinityRange;
	}


	public String getAffinityType() {
		return affinityType;
	}


	public void setAffinityType(String affinityType) {
		this.affinityType = affinityType;
	}


	public String getHetId() {
		return hetId;
	}


	public void setHetId(String hetId) {
		this.hetId = hetId;
	}


	public String getBindingResidues() {
		return bindingResidues;
	}


	public void setBindingResidues(String bindingResidues) {
		this.bindingResidues = bindingResidues;
	}


	public String getChain() {
		return chain;
	}


	public void setChain(String chain) {
		this.chain = chain;
	}


	public int getOriginalChainLength() {
		return originalChainLength;
	}


	public void setOriginalChainLength(int originalChainLength) {
		this.originalChainLength = originalChainLength;
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
			s.append(String.format(
			 "<span class='%s'>%s</span>",
			 Character.isUpperCase(c) ? "up" : "between",
			 c
			));
		}
		return s.toString();
	}


	public String getPdb() {
		return pdb;
	}


	public void setPdb(String pdb) {
		this.pdb = pdb;
	}


	public float getProportionalLength() {
		return proportionalLength;
	}


	public void setProportionalLength(float proportionalLength) {
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


	public float getContactRatio() {
		return contactRatio;
	}


	public void setContactRatio(float contactRatio) {
		this.contactRatio = contactRatio;
	}


	public String getResidueIds() {
		return residueIds;
	}


	public void setResidueIds(String residueIds) {
		this.residueIds = residueIds;
	}
}
