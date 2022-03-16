package com.cumt.blog.back.control;


import cn.hutool.http.HttpRequest;
import com.cumt.blog.back.bean.Article;
import com.cumt.blog.back.bean.Category;
import com.cumt.blog.back.bean.Tag;
import com.cumt.blog.back.bean.User;
import com.cumt.blog.back.service.ArticleService;
import com.cumt.blog.base.bean.ResultVo;
import com.cumt.blog.base.util.DateTimeUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.Enumeration;
import java.util.List;

@Controller
public class ArticleControl {
    @Resource
    private ArticleService articleService;

    @RequestMapping("/toView/{firstView}/{secondView}/{thirdView}")
    public String articleSearch(@PathVariable("firstView") String firstView,
                                @PathVariable("secondView") String secondView,
                                @PathVariable("thirdView") String thirdView, HttpServletRequest request){
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()){
            String name = parameterNames.nextElement();
            String value=request.getParameter(name);
            request.setAttribute(name,value);
        }

        System.out.println(firstView+ File.separator+secondView+thirdView);
        return firstView+ File.separator+secondView+File.separator+thirdView;
    }
    @RequestMapping("/article/list")
    @ResponseBody
    public PageInfo<Article> articleList(int page, int pagesize, String title, HttpSession session){
        System.out.println(456);
        System.out.println(789);
        System.out.println(465789);
        PageHelper.startPage(page,pagesize);
        User user = (User) session.getAttribute("user");
        List<Article> list=articleService.searchList(title,user);
        PageInfo<Article> pageInfo=new PageInfo<>(list);
        return pageInfo;

    }
    @RequestMapping("/article/isOpen")
    @ResponseBody
    public ResultVo isOpen(String aid,String isOpen){
        ResultVo resultVo=new ResultVo();
        try {
            articleService.isOpenUpdate(aid,isOpen);
            resultVo.setOk(true);
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }
        return resultVo;
    }

    @RequestMapping("/article/selectCategory")
    @ResponseBody
    public List<Category> selectCategory(){
        List<Category> list=articleService.selectCategory();
        return list;
    }
    @RequestMapping("/artrcle/selectTag")
    @ResponseBody
    public List<Tag> selectTag(String cid){
        List<Tag> list=articleService.selectTag(cid);
        return list;
    }

    @RequestMapping("/article/addArticle")
    @ResponseBody
    public ResultVo addArticle(Article article,HttpSession session){
        ResultVo resultVo=new ResultVo();
        article.setCreate_time(DateTimeUtil.getSysTime());
        User user= (User) session.getAttribute("user");
        article.setUid(user.getUid());
        try {
            articleService.addArticle(article);
            resultVo.setOk(true);
            resultVo.setMess("发布成功");
            resultVo.setObject(article);
        }catch (Exception e) {
            resultVo.setMess(e.getMessage());
        }
        return resultVo;
    }
    @RequestMapping("/article/selectArticle")
    @ResponseBody
    public Article selectArticle(String aid){
        Article article = articleService.selectArticleOne(aid);
        return article;
    }
    @RequestMapping("/article/updateArticle")
    @ResponseBody
    public ResultVo updateArticle(Article article,HttpSession session){
        ResultVo resultVo=new ResultVo();
        article.setUpdate_time(DateTimeUtil.getSysTime());
        User user= (User) session.getAttribute("user");
        article.setUid(user.getUid());
        try {
            articleService.updateArticle(article);
            resultVo.setOk(true);
            resultVo.setObject(article);
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }

        return resultVo;
    }
    @RequestMapping("/article/deleteArticle")
    @ResponseBody
    public ResultVo deleteArticle(String aid){
        ResultVo resultVo = new ResultVo();
        try {
            articleService.deleteArticle(aid);
            resultVo.setOk(true);
            resultVo.setMess("删除成功");
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }
        return resultVo;
    }
}
