package com.cumt.blog.base.bean;


import lombok.Data;

@Data
public class ResultVo {
    private String mess;
    private boolean isOk;
    private Object object;
}
