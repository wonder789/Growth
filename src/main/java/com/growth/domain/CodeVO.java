package com.growth.domain;

import java.io.Serializable;

public class CodeVO implements Serializable{
	
	private String code;
	
	private String pCode;
	
	private String codeNm;
	
	private String codeComment1;
	
	private String codeComment2;
	
	private String codeComment3;
	
	private String regDate;
	
	private String modDate;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getpCode() {
		return pCode;
	}

	public void setpCode(String pCode) {
		this.pCode = pCode;
	}

	public String getCodeNm() {
		return codeNm;
	}

	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}

	public String getCodeComment1() {
		return codeComment1;
	}

	public void setCodeComment1(String codeComment1) {
		this.codeComment1 = codeComment1;
	}

	public String getCodeComment2() {
		return codeComment2;
	}

	public void setCodeComment2(String codeComment2) {
		this.codeComment2 = codeComment2;
	}

	public String getCodeComment3() {
		return codeComment3;
	}

	public void setCodeComment3(String codeComment3) {
		this.codeComment3 = codeComment3;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	@Override
	public String toString() {
		return "CodeVO [code=" + code + ", pCode=" + pCode + ", codeNm=" + codeNm + ", codeComment1=" + codeComment1
				+ ", codeComment2=" + codeComment2 + ", codeComment3=" + codeComment3 + ", regDate=" + regDate
				+ ", modDate=" + modDate + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((codeComment1 == null) ? 0 : codeComment1.hashCode());
		result = prime * result + ((codeComment2 == null) ? 0 : codeComment2.hashCode());
		result = prime * result + ((codeComment3 == null) ? 0 : codeComment3.hashCode());
		result = prime * result + ((codeNm == null) ? 0 : codeNm.hashCode());
		result = prime * result + ((modDate == null) ? 0 : modDate.hashCode());
		result = prime * result + ((pCode == null) ? 0 : pCode.hashCode());
		result = prime * result + ((regDate == null) ? 0 : regDate.hashCode());
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
		CodeVO other = (CodeVO) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (codeComment1 == null) {
			if (other.codeComment1 != null)
				return false;
		} else if (!codeComment1.equals(other.codeComment1))
			return false;
		if (codeComment2 == null) {
			if (other.codeComment2 != null)
				return false;
		} else if (!codeComment2.equals(other.codeComment2))
			return false;
		if (codeComment3 == null) {
			if (other.codeComment3 != null)
				return false;
		} else if (!codeComment3.equals(other.codeComment3))
			return false;
		if (codeNm == null) {
			if (other.codeNm != null)
				return false;
		} else if (!codeNm.equals(other.codeNm))
			return false;
		if (modDate == null) {
			if (other.modDate != null)
				return false;
		} else if (!modDate.equals(other.modDate))
			return false;
		if (pCode == null) {
			if (other.pCode != null)
				return false;
		} else if (!pCode.equals(other.pCode))
			return false;
		if (regDate == null) {
			if (other.regDate != null)
				return false;
		} else if (!regDate.equals(other.regDate))
			return false;
		return true;
	}
	
	
	
	
}
