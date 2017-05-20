package com.growth.domain;

import java.util.Arrays;

public class FileVO {
	
	private int fileId;
	
	private String fileNameOrg;
	
	private byte[] fileData;
	
	private String regDate;
	
	private String modDate;

	public int getFileId() {
		return fileId;
	}

	public String getFileNameOrg() {
		return fileNameOrg;
	}

	public void setFileNameOrg(String fileNameOrg) {
		this.fileNameOrg = fileNameOrg;
	}

	public byte[] getFileData() {
		return fileData;
	}

	public void setFileData(byte[] fileData) {
		this.fileData = fileData;
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

	public void setFileId(int fileId) {
		this.fileId = fileId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Arrays.hashCode(fileData);
		result = prime * result + fileId;
		result = prime * result + ((fileNameOrg == null) ? 0 : fileNameOrg.hashCode());
		result = prime * result + ((modDate == null) ? 0 : modDate.hashCode());
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
		FileVO other = (FileVO) obj;
		if (!Arrays.equals(fileData, other.fileData))
			return false;
		if (fileId != other.fileId)
			return false;
		if (fileNameOrg == null) {
			if (other.fileNameOrg != null)
				return false;
		} else if (!fileNameOrg.equals(other.fileNameOrg))
			return false;
		if (modDate == null) {
			if (other.modDate != null)
				return false;
		} else if (!modDate.equals(other.modDate))
			return false;
		if (regDate == null) {
			if (other.regDate != null)
				return false;
		} else if (!regDate.equals(other.regDate))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FileVO [fileId=" + fileId + ", fileNameOrg=" + fileNameOrg + ", fileData=" + Arrays.toString(fileData)
				+ ", regDate=" + regDate + ", modDate=" + modDate + "]";
	}

	
	
	
}
