package alert;

public class AlertBean {

	private int ALERT_NO;
	private String ALERT_FROM;
	private String ALERT_TO;
	private String ALERT_MESSAGE;
	private int MEM_NO;
	private String ALERT_STATE;
	
	public int getALERT_NO() {
		return ALERT_NO;
	}
	public void setALERT_NO(int aLERT_NO) {
		ALERT_NO = aLERT_NO;
	}
	public String getALERT_FROM() {
		return ALERT_FROM;
	}
	public void setALERT_FROM(String aLERT_FROM) {
		ALERT_FROM = aLERT_FROM;
	}
	public String getALERT_TO() {
		return ALERT_TO;
	}
	public void setALERT_TO(String aLERT_TO) {
		ALERT_TO = aLERT_TO;
	}
	public String getALERT_MESSAGE() {
		return ALERT_MESSAGE;
	}
	public void setALERT_MESSAGE(String aLERT_MESSAGE) {
		ALERT_MESSAGE = aLERT_MESSAGE;
	}
	public int getMEM_NO() {
		return MEM_NO;
	}
	public void setMEM_NO(int mEM_NO) {
		MEM_NO = mEM_NO;
	}
	public String getALERT_STATE() {
		return ALERT_STATE;
	}
	public void setALERT_STATE(String aLERT_STATE) {
		ALERT_STATE = aLERT_STATE;
	}
	
	
	public AlertBean() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public AlertBean(int aLERT_NO, String aLERT_FROM, String aLERT_TO, String aLERT_MESSAGE, int mEM_NO,
			String aLERT_STATE) {
		super();
		ALERT_NO = aLERT_NO;
		ALERT_FROM = aLERT_FROM;
		ALERT_TO = aLERT_TO;
		ALERT_MESSAGE = aLERT_MESSAGE;
		MEM_NO = mEM_NO;
		ALERT_STATE = aLERT_STATE;
	}
	
}
