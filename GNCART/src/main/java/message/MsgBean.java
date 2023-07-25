package message;

public class MsgBean {
	
	private int msg_no;	
	private String msg_title;
	private String msg_content;
	private String msg_toname;
	private String msg_fromname;
	private String msg_sendtime;
	private String msg_readtime;
	private String msg_read;
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
	public String getMsg_toname() {
		return msg_toname;
	}
	public void setMsg_toname(String msg_toname) {
		this.msg_toname = msg_toname;
	}
	public String getMsg_fromname() {
		return msg_fromname;
	}
	public void setMsg_fromname(String msg_fromname) {
		this.msg_fromname = msg_fromname;
	}
	public String getMsg_sendtime() {
		return msg_sendtime;
	}
	public void setMsg_sendtime(String msg_sendtime) {
		this.msg_sendtime = msg_sendtime;
	}
	public String getMsg_readtime() {
		return msg_readtime;
	}
	public void setMsg_readtime(String msg_readtime) {
		this.msg_readtime = msg_readtime;
	}
	public String getMsg_read() {
		return msg_read;
	}
	public void setMsg_read(String msg_read) {
		this.msg_read = msg_read;
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
	
	public MsgBean(int msg_no, String msg_title, String msg_content, String msg_toname, String msg_fromname,
			String msg_sendtime, String msg_readtime, String msg_read, int mem_no, String mem_name, String part_type) {
		super();
		this.msg_no = msg_no;
		this.msg_title = msg_title;
		this.msg_content = msg_content;
		this.msg_toname = msg_toname;
		this.msg_fromname = msg_fromname;
		this.msg_sendtime = msg_sendtime;
		this.msg_readtime = msg_readtime;
		this.msg_read = msg_read;
		this.mem_no = mem_no;
		this.mem_name = mem_name;
		this.part_type = part_type;
	}
	
}
