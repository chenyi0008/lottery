package com.zcurd.account.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * 登陆日志
 */
@SuppressWarnings({"serial", "unchecked"})
public abstract class BaseSysLoginLog<M extends BaseSysLoginLog<M>> extends Model<M> implements IBean {

	public M setId(java.lang.Integer id) {
		set("id", id);
		return (M)this;
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public M setUsername(java.lang.String username) {
		set("username", username);
		return (M)this;
	}

	public java.lang.String getUsername() {
		return get("username");
	}

	public M setSessionId(java.lang.String sessionId) {
		set("session_id", sessionId);
		return (M)this;
	}

	public java.lang.String getSessionId() {
		return get("session_id");
	}

	public M setIp(java.lang.String ip) {
		set("ip", ip);
		return (M)this;
	}

	public java.lang.String getIp() {
		return get("ip");
	}

	public M setIsSuccess(java.lang.Integer isSuccess) {
		set("is_success", isSuccess);
		return (M)this;
	}

	public java.lang.Integer getIsSuccess() {
		return get("is_success");
	}

	public M setRemark(java.lang.String remark) {
		set("remark", remark);
		return (M)this;
	}

	public java.lang.String getRemark() {
		return get("remark");
	}

	public M setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
		return (M)this;
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

}
