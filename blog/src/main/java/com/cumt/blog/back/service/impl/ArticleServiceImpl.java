package com.cumt.blog.back.service.impl;

import com.cumt.blog.back.bean.Article;
import com.cumt.blog.back.bean.Category;
import com.cumt.blog.back.bean.Tag;
import com.cumt.blog.back.bean.User;
import com.cumt.blog.back.mapper.ArticleMapper;
import com.cumt.blog.back.mapper.CategoryMapprt;
import com.cumt.blog.back.mapper.TagMapper;
import com.cumt.blog.back.service.ArticleService;
import com.cumt.blog.base.exception.BlogEnumLogin;
import com.cumt.blog.base.exception.BlogRunException;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArticleServiceImpl implements ArticleService {
    @Resource
    private ArticleMapper articleMapper;
    @Resource
    private CategoryMapprt categoryMapprt;
    @Resource
    private TagMapper tagMapper;
    @Override
    public List<Article> searchList(String title, User user) {

        Example example=new Example(Article.class);
        example.createCriteria().andLike("title", "%" + title + "%").andEqualTo("uid",user.getUid());
        List<Article> list=articleMapper.selectByExample(example);
        for (Article article : list){
            Category category = categoryMapprt.selectByPrimaryKey(article.getCid());
            article.setCid(category.getCname());
        }
        return list;
    }

    @Override
    public void isOpenUpdate(String aid, String isOpen) {
        Article article=new Article();
        article.setAid(aid);
        article.setIsOpen(isOpen);
        int i = articleMapper.updateByPrimaryKeySelective(article);
        if(i!=1){
            throw new BlogRunException(BlogEnumLogin.Article_isOpen_Update);
        }
    }

    @Override
    public List<Category> selectCategory() {
        List<Category> list=categoryMapprt.selectAll();
        return list;
    }

    @Override
    public List<Tag> selectTag(String cid) {
        Example example=new Example(Tag.class);
        example.createCriteria().andEqualTo("cid", cid);
        List<Tag> list=tagMapper.selectByExample(example);
        return list;
    }

    @Override
    public void addArticle(Article article) {
        int insert = articleMapper.insert(article);
        if(insert!=1){
            throw new BlogRunException(BlogEnumLogin.Article_addArticle_insert);
        }
    }

    @Override
    public Article selectArticleOne(String aid) {
        Article article=articleMapper.selectByPrimaryKey(aid);
        return article;
    }

    @Override
    public void updateArticle(Article article) {
        int i = articleMapper.updateByPrimaryKeySelective(article);
        if(i !=1){
            throw new BlogRunException(BlogEnumLogin.Article_updateArticle_update);
        }
    }

    @Override
    public void deleteArticle(String aid) {
        int i = articleMapper.deleteByPrimaryKey(aid);
        if(i !=1){
            throw new BlogRunException(BlogEnumLogin.Article_deleteArticle_delete);
        }

    }

}
