package freeBoard;
 
public class BoardBean {
	
	public BoardBean(int mEM_NO, int fREE_NO, String fREE_TITLE, String fREE_CONTENT, String fREE_DATE, int fREE_HIT,
			String fREE_FILENAME, int fREE_FILESIZE, String pART_TYPE, String mEM_ID, String mEM_NAME, int pART_NO,
			String replyDate) {
		super();
		MEM_NO = mEM_NO;
		FREE_NO = fREE_NO;
		FREE_TITLE = fREE_TITLE;
		FREE_CONTENT = fREE_CONTENT;
		FREE_DATE = fREE_DATE;
		FREE_HIT = fREE_HIT;
		FREE_FILENAME = fREE_FILENAME;
		FREE_FILESIZE = fREE_FILESIZE;
		PART_TYPE = pART_TYPE;
		MEM_ID = mEM_ID;
		MEM_NAME = mEM_NAME;
		PART_NO = pART_NO;
		this.replyDate = replyDate;
	}
    
	private int MEM_NO;
	private int FREE_NO;
	private String FREE_TITLE;//게시물 제목 변수
	private String FREE_CONTENT; //게시물 본문 변수  
	private String FREE_DATE; //게시물 작성 날짜 변수
	private int FREE_HIT; //게시물 조회수 변수
	private String FREE_FILENAME; //게시물 업로드 파일 이름 변수
	private int FREE_FILESIZE; //게시물 업로드 파일 크기 변수
	private String PART_TYPE;
	private String MEM_ID;
	private String MEM_NAME;
	private int PART_NO;
	private String replyDate;
	
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public int getMEM_NO() {
		return MEM_NO;
	}
	public void setMEM_NO(int mEM_NO) {
		MEM_NO = mEM_NO;
	}
	public int getFREE_NO() {
		return FREE_NO;
	}
	public void setFREE_NO(int fREE_NO) {
		FREE_NO = fREE_NO;
	}
	public String getFREE_TITLE() {
		return FREE_TITLE;
	}
	public void setFREE_TITLE(String fREE_TITLE) {
		FREE_TITLE = fREE_TITLE;
	}
	public String getFREE_CONTENT() {
		return FREE_CONTENT;
	}
	public void setFREE_CONTENT(String fREE_CONTENT) {
		FREE_CONTENT = fREE_CONTENT;
	}
	public String getFREE_DATE() {
		return FREE_DATE;
	}
	public void setFREE_DATE(String fREE_DATE) {
		FREE_DATE = fREE_DATE;
	}
	public int getFREE_HIT() {
		return FREE_HIT;
	}
	public void setFREE_HIT(int fREE_HIT) {
		FREE_HIT = fREE_HIT;
	}
	public String getFREE_FILENAME() {
		return FREE_FILENAME;
	}
	public void setFREE_FILENAME(String fREE_FILENAME) {
		FREE_FILENAME = fREE_FILENAME;
	}
	public int getFREE_FILESIZE() {
		return FREE_FILESIZE;
	}
	public void setFREE_FILESIZE(int fREE_FILESIZE) {
		FREE_FILESIZE = fREE_FILESIZE;
	}
	public String getPART_TYPE() {
		return PART_TYPE;
	}
	public void setPART_TYPE(String pART_TYPE) {
		PART_TYPE = pART_TYPE;
	}
	public String getMEM_ID() {
		return MEM_ID;
	}
	public void setMEM_ID(String mEM_ID) {
		MEM_ID = mEM_ID;
	}
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public void setMEM_NAME(String mEM_NAME) {
		MEM_NAME = mEM_NAME;
	}
	public int getPART_NO() {
		return PART_NO;
	}
	public void setPART_NO(int pART_NO) {
		PART_NO = pART_NO;
	}
	
	public BoardBean() {
		super();
		// TODO Auto-generated constructor stub
	}

}
