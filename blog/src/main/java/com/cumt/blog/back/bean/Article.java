package com.cumt.blog.back.bean;

import lombok.Data;
import org.springframework.web.bind.annotation.RequestMapping;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name ="t_article" )
@NameStyle(Style.normal)
public class Article {
    @Id
    private String aid;
    private String title;
    private String digest;
    private String content;
    private String cid;
    private String visit_count;
    private String create_time;
    private String update_time;
    private String is_hot;
    private String logo;
    private String uid;
    private String isOpen;
    private String thumbsUp;
    private String tagNames;
    private String isCommented;

}
