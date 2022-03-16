package com.cumt.blog.back.bean;


import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "emp_copy")
@NameStyle(Style.normal)
public class Emp {
    @Id
    private String EMPNO;
    private String ENAME;
    private String JOB;
    private String MGR;
    private String HIREDATE;
    private String SAL;
    private String COMM;
    private String deptno;
}
