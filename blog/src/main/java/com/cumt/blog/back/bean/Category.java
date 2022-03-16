package com.cumt.blog.back.bean;


import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name ="t_category" )
@NameStyle(Style.normal)
public class Category {
    @Id
    private String cid;
    private String cname;
}
