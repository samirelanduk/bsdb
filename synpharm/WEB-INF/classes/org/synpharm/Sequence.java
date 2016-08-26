package org.synpharm;

import java.sql.SQLException;
import java.util.Date;

public class Sequence {

	private int sequenceId;
	private Ligand ligand;
	private int targetId;
	private String targetName;
	private String targetNameStripped;
	private String targetType;
	private String species;
	private String type;
	private String action;
	private float affinity;
	private String affinityRange;
	private String affinityType;
	private Date dateAdded;
	private Date dateModified;
	private String pdb;
	private String hetCode;
	private String hetId;
	private String bindingResidues;
	private String chain;
	private int originalChainLength;
	private String sequence;
	private float proportionalLength;
	private int internalContacts;
	private int externalContacts;
	private float contactRatio;
	private String residueIds;
	private int sequenceLength;

	public Sequence() {
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
		this.targetId = (Integer)fields[2];
		this.targetName = (String)fields[3];
		this.targetNameStripped = (String)fields[4];
		this.targetType = (String)fields[5];
		this.species = (String)fields[6];
		this.type = (String)fields[7];
		this.action = (String)fields[8];
		try {
    	this.affinity = (Float)fields[9];
		} catch (NullPointerException e) {

		}
		this.affinityRange = (String)fields[10];
		this.affinityType = (String)fields[11];
		this.dateAdded = (Date)fields[12];
		this.dateModified = (Date)fields[13];
		this.pdb = (String)fields[14];
		this.hetCode = (String)fields[15];
		this.hetId = (String)fields[16];
		this.bindingResidues = (String)fields[17];
		this.chain = (String)fields[18];
		this.originalChainLength = (Integer)fields[19];
		this.sequence = (String)fields[20];
		this.proportionalLength = (Float)fields[21];
		this.internalContacts = (Integer)fields[22];
		this.externalContacts = (Integer)fields[23];
		this.contactRatio = (Float)fields[24];
		this.residueIds = (String)fields[25];
		this.sequenceLength = (Integer)fields[26];
	}

	public String getConciseHtml() {
		String contents = Utilities.enclose(
				"a",
				String.format("href='/sequences/detail.jsp?id=%d'", getSequenceId()),
				String.format(
				 "%s (%d residues)",
				 getTargetName(),
				 getSequenceLength()
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


	public int getTargetId() {
		return targetId;
	}


	public void setTargetId(int targetId) {
		this.targetId = targetId;
	}


	public String getTargetName() {
		return targetName;
	}


	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}


	public String getTargetNameStripped() {
		return targetNameStripped;
	}


	public void setTargetNameStripped(String targetNameStripped) {
		this.targetNameStripped = targetNameStripped;
	}


	public String getTargetType() {
		return targetType;
	}


	public void setTargetType(String targetType) {
		this.targetType = targetType;
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


	public String getPdb() {
		return pdb;
	}


	public void setPdb(String pdb) {
		this.pdb = pdb;
	}


	public String getHetCode() {
		return hetCode;
	}


	public void setHetCode(String hetCode) {
		this.hetCode = hetCode;
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


	public int getSequenceLength() {
		return sequenceLength;
	}


	public void setSequenceLength(int sequenceLength) {
		this.sequenceLength = sequenceLength;
	}


	public String getSequenceHtml() {
		int lastUpper = sequence.length();
		for (int i = sequence.length() - 1; i > 0; i--) {
			if (Character.isUpperCase(sequence.charAt(i))) {
				lastUpper = i;
				break;
			}
		}
		boolean preSequence = true;
		StringBuilder s = new StringBuilder();
		for (int i = 0; i < sequence.length(); i++) {
			if (preSequence && Character.isUpperCase(sequence.charAt(i))) {
				preSequence = false;
			}
			s.append(String.format(
			 "<span class='%s %s %s'>%s</span>",
			 Character.isUpperCase(sequence.charAt(i)) ? "up" : "between",
			 (preSequence || i > lastUpper) ? "outside" : "inside",
			 (preSequence || i > lastUpper) ? "grayseq" : "blackseq",
			 sequence.charAt(i)
			));
		}
		return s.toString();
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
