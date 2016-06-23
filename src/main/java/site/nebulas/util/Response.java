package site.nebulas.util;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;


public class Response {
	@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
	private String hash ;
	private int ret;
	private String msg;
	private Object data;
	
	
	public Response( ) {
		this.ret = 0;
		this.msg = "success";
	}
	public Response(Object data) {
		this();
		this.data = data;
	}
	

	public int getRet() {
		return ret;
	}

	public void setRet(int ret) {
		this.ret = ret;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

	public String getHash() {
		return hash;
	}
	public void setHash(String hash) {
		this.hash = hash;
	}
	
}
