package com.growth.domain;

public class AjaxResult {
	
	public static final int SUCCESS = 200;
	
	public static final int FAIL = 400;
	
	public static final int EXCEPTION = 500;
	private int status;
	
	private Object data;
	
	private String message;

	public int getStatus() {
		return status;
	}

	public AjaxResult setStatus(int status) {
		this.status = status;
		return this;
	}

	public Object getData() {
		return data;
	}

	public AjaxResult setData(Object data) {
		this.data = data;
		return this;
	}

	public String getMessage() {
		return message;
	}

	public AjaxResult setMessage(String message) {
		this.message = message;
		return this;
	}
	
	
	public AjaxResult() {
		// TODO Auto-generated constructor stub
	}
	public AjaxResult(int status, Object data, String message) {
		super();
		this.status = status;
		this.data = data;
		this.message = message;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((data == null) ? 0 : data.hashCode());
		result = prime * result + ((message == null) ? 0 : message.hashCode());
		result = prime * result + status;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AjaxResult other = (AjaxResult) obj;
		if (data == null) {
			if (other.data != null)
				return false;
		} else if (!data.equals(other.data))
			return false;
		if (message == null) {
			if (other.message != null)
				return false;
		} else if (!message.equals(other.message))
			return false;
		if (status != other.status)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "AjaxResult [status=" + status + ", data=" + data + ", message=" + message + "]";
	}
	
	
}
