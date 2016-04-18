package org.bsdbmanage;

import java.util.Date;
import java.sql.SQLException;

public class Interaction {

	private int interactionId;
	private int ligandId;
	private int targetId;
	private String species;
	private String type;
	private String action;
	private String affinityType;
	private double affinityValue;
	private String affinityRange;
	private boolean ligandIsPeptide;
  private Date dateAdded;
  private Date dateModified;
  private Date datePdbsLastChecked;

}
