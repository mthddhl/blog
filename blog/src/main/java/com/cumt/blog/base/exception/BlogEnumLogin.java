package com.cumt.blog.base.exception;

import com.cumt.blog.back.bean.Article;

public enum BlogEnumLogin {
    User_Login_Code("101-101","验证码错误"),User_Login_Napa("101-102","用户名或密码错误"),
    User_Verify_Password("101-103","旧密码错误"),User_Infro_Updata("101-104","更新失败"),
    Article_isOpen_Update("101-104","私密更新失败"),Article_addArticle_insert("101-105","发布失败"),
    Article_updateArticle_update("101-105","更新失败"),Article_deleteArticle_delete("101-105","更新失败");

    private String exceptioncode;
    private String exceptionmsg;

    public String getExceptioncode() {
        return exceptioncode;
    }

    BlogEnumLogin(String exceptioncode, String exceptionmsg) {
        this.exceptioncode = exceptioncode;
        this.exceptionmsg = exceptionmsg;
    }

    public void setExceptioncode(String exceptioncode) {
        this.exceptioncode = exceptioncode;
    }

    public String getExceptionmsg() {
        return exceptionmsg;
    }

    public void setExceptionmsg(String exceptionmsg) {
        this.exceptionmsg = exceptionmsg;
    }
}
