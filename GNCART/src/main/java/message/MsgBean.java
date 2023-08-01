package message;

public class MsgBean {
	
	private int msg_no;	
	private String msg_title;
	private String msg_content;
	private String msg_toPartType;
	private String msg_toName;
	private String msg_fromPartType;
	private String msg_fromName;
	private String msg_sendTime;
	private String msg_readTime;
	private String msg_read;
	private int msg_delCnt;
	private int msg_showCheck;
	private String msg_file;
	private int mem_no;
	private String mem_name;
	private String part_type;


	public int getMsg_no() {
		return msg_no;
	}


	public void setMsg_no(int msg_no) {
		this.msg_no = msg_no;
	}


	public String getMsg_title() {
		return msg_title;
	}


	public void setMsg_title(String msg_title) {
		this.msg_title = msg_title;
	}


	public String getMsg_content() {
		return msg_content;
	}


	public void setMsg_content(String msg_content) {
		this.msg_content = msg_content;
	}


	public String getMsg_toPartType() {
		return msg_toPartType;
	}


	public void setMsg_toPartType(String msg_toPartType) {
		this.msg_toPartType = msg_toPartType;
	}


	public String getMsg_toName() {
		return msg_toName;
	}


	public void setMsg_toName(String msg_toName) {
		this.msg_toName = msg_toName;
	}


	public String getMsg_fromPartType() {
		return msg_fromPartType;
	}


	public void setMsg_fromPartType(String msg_fromPartType) {
		this.msg_fromPartType = msg_fromPartType;
	}


	public String getMsg_fromName() {
		return msg_fromName;
	}


	public void setMsg_fromName(String msg_fromName) {
		this.msg_fromName = msg_fromName;
	}


	public String getMsg_sendTime() {
		return msg_sendTime;
	}


	public void setMsg_sendTime(String msg_sendTime) {
		this.msg_sendTime = msg_sendTime;
	}


	public String getMsg_readTime() {
		return msg_readTime;
	}


	public void setMsg_readTime(String msg_readTime) {
		this.msg_readTime = msg_readTime;
	}


	public String getMsg_read() {
		return msg_read;
	}


	public void setMsg_read(String msg_read) {
		this.msg_read = msg_read;
	}


	public int getMsg_delCnt() {
		return msg_delCnt;
	}


	public void setMsg_delCnt(int msg_delCnt) {
		this.msg_delCnt = msg_delCnt;
	}


	public int getMsg_showCheck() {
		return msg_showCheck;
	}


	public void setMsg_showCheck(int msg_showCheck) {
		this.msg_showCheck = msg_showCheck;
	}


	public String getMsg_file() {
		return msg_file;
	}


	public void setMsg_file(String msg_file) {
		this.msg_file = msg_file;
	}


	public int getMem_no() {
		return mem_no;
	}


	public void setMem_no(int mem_no) {
		this.mem_no = mem_no;
	}


	public String getMem_name() {
		return mem_name;
	}


	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}


	public String getPart_type() {
		return part_type;
	}


	public void setPart_type(String part_type) {
		this.part_type = part_type;
	}

	public MsgBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	public MsgBean(int msg_no, String msg_title, String msg_content, String msg_toPartType, String msg_toName,
			String msg_fromPartType, String msg_fromName, String msg_sendTime, String msg_readTime, String msg_read,
			int msg_delCnt, int msg_showCheck, String msg_file, int mem_no, String mem_name, String part_type) {
		super();
		this.msg_no = msg_no;
		this.msg_title = msg_title;
		this.msg_content = msg_content;
		this.msg_toPartType = msg_toPartType;
		this.msg_toName = msg_toName;
		this.msg_fromPartType = msg_fromPartType;
		this.msg_fromName = msg_fromName;
		this.msg_sendTime = msg_sendTime;
		this.msg_readTime = msg_readTime;
		this.msg_read = msg_read;
		this.msg_delCnt = msg_delCnt;
		this.msg_showCheck = msg_showCheck;
		this.msg_file = msg_file;
		this.mem_no = mem_no;
		this.mem_name = mem_name;
		this.part_type = part_type;
	}
	
}
