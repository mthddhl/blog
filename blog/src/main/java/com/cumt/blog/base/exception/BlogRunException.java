package com.cumt.blog.base.exception;

public class BlogRunException extends RuntimeException{
    private BlogEnumLogin blogEnumLogin;
    public BlogRunException() {
    }

    public BlogRunException(BlogEnumLogin blogEumnLogin) {
        super(blogEumnLogin.getExceptionmsg());
        this.blogEnumLogin=blogEumnLogin;
    }
}
