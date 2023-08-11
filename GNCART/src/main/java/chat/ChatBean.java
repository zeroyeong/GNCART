package chat;

public class ChatBean {
	

	private int chat_no;	
	private String chat_toPartType;
	private String chat_toName;
	private String chat_fromPartType;
	private String chat_fromName;
	private String chat_content;
	private String chat_time;	
	private String chat_read;	
	private int mem_no;
	private String mem_name;
	private String part_type;
	
	
	
	public int getChat_no() {
		return chat_no;
	}
	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}
	public String getChat_toPartType() {
		return chat_toPartType;
	}
	public void setChat_toPartType(String chat_toPartType) {
		this.chat_toPartType = chat_toPartType;
	}
	public String getChat_toName() {
		return chat_toName;
	}
	public void setChat_toName(String chat_toName) {
		this.chat_toName = chat_toName;
	}
	public String getChat_fromPartType() {
		return chat_fromPartType;
	}
	public void setChat_fromPartType(String chat_fromPartType) {
		this.chat_fromPartType = chat_fromPartType;
	}
	public String getChat_fromName() {
		return chat_fromName;
	}
	public void setChat_fromName(String chat_fromName) {
		this.chat_fromName = chat_fromName;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	public String getChat_time() {
		return chat_time;
	}
	public void setChat_time(String chat_time) {
		this.chat_time = chat_time;
	}
	public String getChat_read() {
		return chat_read;
	}
	public void setChat_read(String chat_read) {
		this.chat_read = chat_read;
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
	
	
	public ChatBean(int chat_no, String chat_toPartType, String chat_toName, String chat_fromPartType,
			String chat_fromName, String chat_content, String chat_time, String chat_read, int mem_no, String mem_name,
			String part_type) {
		super();
		this.chat_no = chat_no;
		this.chat_toPartType = chat_toPartType;
		this.chat_toName = chat_toName;
		this.chat_fromPartType = chat_fromPartType;
		this.chat_fromName = chat_fromName;
		this.chat_content = chat_content;
		this.chat_time = chat_time;
		this.chat_read = chat_read;
		this.mem_no = mem_no;
		this.mem_name = mem_name;
		this.part_type = part_type;
	}


	public ChatBean() {
		super();
		// TODO Auto-generated constructor stub
	}


}
