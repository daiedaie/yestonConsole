package com.mrbt.yeston.web.echo.DO;

import java.io.Serializable;

import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="personal_info")	
public class PersonalInfo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String _id;
	
	private String persional_name;
	
	private String id_no;
	
	private String create_time;
	
	private String last_query_time;
	
	private int share;

	public String get_id() {
		return _id;
	}

	public void set_id(String _id) {
		this._id = _id;
	}

	public String getPersional_name() {
		return persional_name;
	}

	public void setPersional_name(String persional_name) {
		this.persional_name = persional_name;
	}

	public String getId_no() {
		return id_no;
	}

	public void setId_no(String id_no) {
		this.id_no = id_no;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getLast_query_time() {
		return last_query_time;
	}

	public void setLast_query_time(String last_query_time) {
		this.last_query_time = last_query_time;
	}

	public int getShare() {
		return share;
	}

	public void setShare(int share) {
		this.share = share;
	}
}
