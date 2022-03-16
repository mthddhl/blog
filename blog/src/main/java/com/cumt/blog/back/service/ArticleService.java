package com.cumt.blog.back.service;

import com.cumt.blog.back.bean.Article;
import com.cumt.blog.back.bean.Category;
import com.cumt.blog.back.bean.Tag;
import com.cumt.blog.back.bean.User;

import java.util.List;

public interface ArticleService {
    List<Article> searchList(String title, User user);


    void isOpenUpdate(String aid, String isOpen);

    List<Category> selectCategory();

    List<Tag> selectTag(String cid);

    void addArticle(Article article);

    Article selectArticleOne(String aid);

    void updateArticle(Article article);

    void deleteArticle(String aid);
}
