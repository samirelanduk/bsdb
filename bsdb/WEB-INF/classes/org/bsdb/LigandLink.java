package org.bsdb;

public class LigandLink {

	/*private int linkId;
	private String accession;
	private String database;
	private String url;


	public LigandLink(Object[] fields) {
		this.linkId = (Integer)fields[0];
		this.accession = (String)fields[1];
		this.database = (String)fields[2];
		this.url = ((String)fields[3]).contains(".") ? (String)fields[3] : "";
	}

	public String getHtml() {
		String text = this.accession;
		if (this.url.length() > 1) {
			text = Utilities.enclose("a", String.format("href='%s' target='_blank'", this.url), text);
		}
		text = String.format("<span class='dbname'>%s</span> - %s", this.database, text);
		return Utilities.enclose("div", "class='link'", text);
	}
	public int getLinkId() {
		return linkId;
	}

	public void setLinkId(int linkId) {
		this.linkId = linkId;
	}

	public String getAccession() {
		return accession;
	}

	public void setAccession(String accession) {
		this.accession = accession;
	}

	public String getDatabase() {
		return database;
	}

	public void setDatabase(String database) {
		this.database = database;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}*/

}
