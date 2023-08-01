package schedule;

public class ScheduleBean {
	int SCHE_NO;
	String SCHE_NAME; //일정 제목
	String SCHE_DATE; //일정 작성일
	
	String SCHE_START_DATE; //시작 날짜
	
	String SCHE_END_DATE; //종료 날짜 
	
	String SCHE_DETAIL;  //상세내용
	String SCHE_FILE; //첨부파일
	
	/*___________참조테이블 변수 선언__________*/ 
	int MEM_NO; //작성자
	String MEM_NAME;
	
	int TYPE_NO; //일정 종류
	String TYPE_TYPE;
	
	int PART_NO; //일정 해당 부서
	String PART_TYPE;
	
	int ST_NO; //시작 시간
	String ST_TIME;
	
	int END_NO; //종료 시간
	String END_TIME;
	
	/*___________GETTER___________*/
	public int getSCHE_NO() {
		return SCHE_NO;
	}
	public String getSCHE_NAME() {
		return SCHE_NAME;
	}
	public String getSCHE_DATE() {
		return SCHE_DATE;
	}
	public String getSCHE_START_DATE() {
		return SCHE_START_DATE;
	}
	public String getSCHE_END_DATE() {
		return SCHE_END_DATE;
	}
	public String getSCHE_DETAIL() {
		return SCHE_DETAIL;
	}
	public String getSCHE_FILE() {
		return SCHE_FILE;
	}
	public int getMEM_NO() {
		return MEM_NO;
	}
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public int getTYPE_NO() {
		return TYPE_NO;
	}
	public String getTYPE_TYPE() {
		return TYPE_TYPE;
	}
	public int getPART_NO() {
		return PART_NO;
	}
	public String getPART_TYPE() {
		return PART_TYPE;
	}
	public int getST_NO() {
		return ST_NO;
	}
	public String getST_TIME() {
		return ST_TIME;
	}
	public int getEND_NO() {
		return END_NO;
	}
	public String getEND_TIME() {
		return END_TIME;
	}
	
	/*___________SETTER___________*/
	public void setSCHE_NO(int SCHE_NO) {
		this.SCHE_NO = SCHE_NO;
	}
	public void setSCHE_NAME(String SCHE_NAME) {
		this.SCHE_NAME = SCHE_NAME;
	}
	public void setSCHE_DATE(String SCHE_DATE) {
		this.SCHE_DATE = SCHE_DATE;
	}
	public void setSCHE_START_DATE(String SCHE_START_DATE) {
		this.SCHE_START_DATE = SCHE_START_DATE;
	}
	public void setSCHE_END_DATE(String SCHE_END_DATE) {
		this.SCHE_END_DATE = SCHE_END_DATE;
	}
	public void setSCHE_DETAIL(String SCHE_DETAIL) {
		this.SCHE_DETAIL = SCHE_DETAIL;
	}
	public void setSCHE_FILE(String SCHE_FILE) {
		this.SCHE_FILE = SCHE_FILE;
	}
	public void setMEM_NO(int MEM_NO) {
		this.MEM_NO = MEM_NO;
	}
	public void setMEM_NAME(String MEM_NAME) {
		this.MEM_NAME = MEM_NAME;
	}
	public void setTYPE_NO(int TYPE_NO) {
		this.TYPE_NO = TYPE_NO;
	}
	public void setTYPE_TYPE(String TYPE_TYPE) {
		this.TYPE_TYPE = TYPE_TYPE;
	}
	public void setPART_NO(int PART_NO) {
		this.PART_NO = PART_NO;
	}
	public void setPART_TYPE(String PART_TYPE) {
		this.PART_TYPE = PART_TYPE;
	}
	public void setST_NO(int ST_NO) {
		this.ST_NO = ST_NO;
	}
	public void setST_TIME(String ST_TIME) {
		this.ST_TIME = ST_TIME;
	}
	public void setEND_NO(int END_NO) {
		this.END_NO = END_NO;
	}
	public void setEND_TIME(String END_TIME) {
		this.END_TIME = END_TIME;
	}
}
