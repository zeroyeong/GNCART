package freeBoard;
   
public class reply {
	
	private int replyNo;
	private int MEM_NO;
	private String replyContent;
	private int FREE_NO;
	private int replyAvailable;
	private String replyDate;
	private String MEM_NAME;


	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getMEM_NO() {
		return MEM_NO;
	}
	public void setMEM_NO(int mEM_NO) {
		MEM_NO = mEM_NO;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public int getFREE_NO() {
		return FREE_NO;
	}
	public void setFREE_NO(int fREE_NO) {
		FREE_NO = fREE_NO;
	}
	public int getReplyAvailable() {
		return replyAvailable;
	}
	public void setReplyAvailable(int replyAvailable) {
		this.replyAvailable = replyAvailable;
	}
	public String getreplyDate() {
		return replyDate;
	}
	public void setreplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public String getMEM_NAME() {
		return MEM_NAME;
	}
	public void setMEM_NAME(String mEM_NAME) {
		MEM_NAME = mEM_NAME;
	}
	public reply(int replyNo, int mEM_NO, String replyContent, int fREE_NO, int replyAvailable, String replyDate,
			String mEM_NAME) {
		super();
		this.replyNo = replyNo;
		MEM_NO = mEM_NO;
		this.replyContent = replyContent;
		FREE_NO = fREE_NO;
		this.replyAvailable = replyAvailable;
		this.replyDate = replyDate;
		MEM_NAME = mEM_NAME;
	}
	public reply() {
		super();
		// TODO Auto-generated constructor stub
	}
   
}