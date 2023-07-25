package familyEvent;

public class ConBean {
	
	private int con_no;	
	private String con_title;
	private String con_content;
	private String con_type;
	private String con_regdate;
	private String con_desdate;
	private String con_location;
	private String con_map;
	private String con_file;
	private int con_hit;
	private int mem_no;
	private String mem_name;
	private String part_type;
	
	public int getCon_no() {
		return con_no;
	}
	public void setCon_no(int con_no) {
		this.con_no = con_no;
	}
	public String getCon_title() {
		return con_title;
	}
	public void setCon_title(String con_title) {
		this.con_title = con_title;
	}
	public String getCon_content() {
		return con_content;
	}
	public void setCon_content(String con_content) {
		this.con_content = con_content;
	}
	public String getCon_type() {
		return con_type;
	}
	public void setCon_type(String con_type) {
		this.con_type = con_type;
	}
	public String getCon_regdate() {
		return con_regdate;
	}
	public void setCon_regdate(String con_regdate) {
		this.con_regdate = con_regdate;
	}
	public String getCon_desdate() {
		return con_desdate;
	}
	public void setCon_desdate(String con_desdate) {
		this.con_desdate = con_desdate;
	}
	public String getCon_location() {
		return con_location;
	}
	public void setCon_location(String con_location) {
		this.con_location = con_location;
	}
	public String getCon_map() {
		return con_map;
	}
	public void setCon_map(String con_map) {
		this.con_map = con_map;
	}
	public String getCon_file() {
		return con_file;
	}
	public void setCon_file(String con_file) {
		this.con_file = con_file;
	}
	public int getCon_hit() {
		return con_hit;
	}
	public void setCon_hit(int con_hit) {
		this.con_hit = con_hit;
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
	
	public ConBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ConBean(int con_no, String con_title, String con_content, String con_type, String con_regdate,
			String con_desdate, String con_location, String con_map, String con_file, int con_hit, int mem_no,
			String mem_name, String part_type) {
		super();
		this.con_no = con_no;
		this.con_title = con_title;
		this.con_content = con_content;
		this.con_type = con_type;
		this.con_regdate = con_regdate;
		this.con_desdate = con_desdate;
		this.con_location = con_location;
		this.con_map = con_map;
		this.con_file = con_file;
		this.con_hit = con_hit;
		this.mem_no = mem_no;
		this.mem_name = mem_name;
		this.part_type = part_type;
	}
}
