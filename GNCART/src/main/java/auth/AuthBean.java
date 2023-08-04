package auth;

public class AuthBean {
	/*결재 통합*/
	private int DOC_NO; 
	private String DOC_NAME; 
	private int DOC_TYPE; 
	private int DOC_STATES;
	private String DOC_REGDATE;
	private String DOC_APPDATE;
	private int DOC_APPTURN;
	/*멤버 테이블*/
	private int MEM_NO;
	private String MEM_NAME; 
	private String MEM_ID;
	private String LE_LEVEL;
	private String PART_TYPE;
	/*결재 휴가테이블*/
	private int VAC_NO;
	private String VAC_SDATE; 
	private String VAC_EDATE;
	private int VAC_REASON; 
	private String VAC_DETAIL; 
	/*결재 회사테이블*/
	private int BUS_NO;
	private String BUS_DETAIL; 
	private String BUS_SPECIAL;
	/*결재선*/
	private int LINE_NO;
	private String LINE_FIRST;
	private String LINE_FIRST_APPDATE;
	private String LINE_SECOND;
	private String LINE_SECOND_APPDATE;

	/*getter,setter*/
	public int getDOC_NO() {
		return DOC_NO;
	}
	public void setDOC_NO(int dOC_NO) {
		DOC_NO = dOC_NO;
	}
	public String getDOC_NAME() {
		return DOC_NAME;
	}
	public void setDOC_NAME(String dOC_NAME) {
		DOC_NAME = dOC_NAME;
	}
	public int getDOC_TYPE() {
		return DOC_TYPE;
	}
	public void setDOC_TYPE(int dOC_TYPE) {
		DOC_TYPE = dOC_TYPE;
	}
	public int getDOC_STATES() {
		return DOC_STATES;
	}
	public void setDOC_STATES(int dOC_STATES) {
		DOC_STATES = dOC_STATES;
	}
	public String getDOC_REGDATE() {
		return DOC_REGDATE;
	}
	public void setDOC_REGDATE(String dOC_REGDATE) {
		DOC_REGDATE = dOC_REGDATE;
	}
	public String getDOC_APPDATE() {
		return DOC_APPDATE;
	}
	public void setDOC_APPDATE(String dOC_APPDATE) {
		DOC_APPDATE = dOC_APPDATE;
	}
	public int getDOC_APPTURN() {
		return DOC_APPTURN;
	}
	public void setDOC_APPTURN(int dOC_APPTURN) {
		DOC_APPTURN = dOC_APPTURN;
	}
	public int getMEM_NO() {
		return MEM_NO;
	}
	public void setMEM_NO(int mEM_NO) {
		MEM_NO = mEM_NO;
	}
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public void setMEM_NAME(String mEM_NAME) {
		MEM_NAME = mEM_NAME;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getLE_LEVEL() {
		return LE_LEVEL;
	}
	public void setLE_LEVEL(String lE_LEVEL) {
		LE_LEVEL = lE_LEVEL;
	}
	public String getPART_TYPE() {
		return PART_TYPE;
	}
	public void setPART_TYPE(String pART_TYPE) {
		PART_TYPE = pART_TYPE;
	}
	public int getVAC_NO() {
		return VAC_NO;
	}
	public void setVAC_NO(int vAC_NO) {
		VAC_NO = vAC_NO;
	}
	public String getVAC_SDATE() {
		return VAC_SDATE;
	}
	public void setVAC_SDATE(String vAC_SDATE) {
		VAC_SDATE = vAC_SDATE;
	}
	public String getVAC_EDATE() {
		return VAC_EDATE;
	}
	public void setVAC_EDATE(String vAC_EDATE) {
		VAC_EDATE = vAC_EDATE;
	}
	public int getVAC_REASON() {
		return VAC_REASON;
	}
	public void setVAC_REASON(int vAC_REASON) {
		VAC_REASON = vAC_REASON;
	}
	public String getVAC_DETAIL() {
		return VAC_DETAIL;
	}
	public void setVAC_DETAIL(String vAC_DETAIL) {
		VAC_DETAIL = vAC_DETAIL;
	}
	public int getBUS_NO() {
		return BUS_NO;
	}
	public void setBUS_NO(int bUS_NO) {
		BUS_NO = bUS_NO;
	}
	public String getBUS_DETAIL() {
		return BUS_DETAIL;
	}
	public void setBUS_DETAIL(String bUS_DETAIL) {
		BUS_DETAIL = bUS_DETAIL;
	}
	public String getBUS_SPECIAL() {
		return BUS_SPECIAL;
	}
	public void setBUS_SPECIAL(String bUS_SPECIAL) {
		BUS_SPECIAL = bUS_SPECIAL;
	}
	public int getLINE_NO() {
		return LINE_NO;
	}
	public void setLINE_NO(int lINE_NO) {
		LINE_NO = lINE_NO;
	}
	public String getLINE_FIRST() {
		return LINE_FIRST;
	}
	public void setLINE_FIRST(String lINE_FIRST) {
		LINE_FIRST = lINE_FIRST;
	}
	public String getLINE_FIRST_APPDATE() {
		return LINE_FIRST_APPDATE;
	}
	public void setLINE_FIRST_APPDATE(String lINE_FIRST_APPDATE) {
		LINE_FIRST_APPDATE = lINE_FIRST_APPDATE;
	}
	public String getLINE_SECOND() {
		return LINE_SECOND;
	}
	public void setLINE_SECOND(String lINE_SECOND) {
		LINE_SECOND = lINE_SECOND;
	}
	public String getLINE_SECOND_APPDATE() {
		return LINE_SECOND_APPDATE;
	}
	public void setLINE_SECOND_APPDATE(String lINE_SECOND_APPDATE) {
		LINE_SECOND_APPDATE = lINE_SECOND_APPDATE;
	}


}
