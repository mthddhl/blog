/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2022-03-16 10:13:19
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) DEFAULT NULL COMMENT '文章标题',
  `digest` longtext COMMENT '摘要',
  `content` longtext COMMENT '文章内容',
  `cid` int(10) DEFAULT NULL COMMENT '所属标签分类',
  `visit_count` int(20) DEFAULT NULL COMMENT '访问量',
  `create_time` char(19) DEFAULT NULL COMMENT '发布时间',
  `update_time` char(19) DEFAULT NULL COMMENT '更新时间',
  `is_hot` int(255) DEFAULT NULL COMMENT '是否热门 0：不热门 1：热门',
  `logo` varchar(255) DEFAULT NULL COMMENT '文章logo',
  `uid` int(11) DEFAULT NULL COMMENT '发布者',
  `isOpen` char(1) DEFAULT NULL COMMENT '是否公开 0:不公开 1:公开',
  `thumbsUp` bigint(255) DEFAULT NULL COMMENT '点赞数',
  `tagNames` varchar(255) DEFAULT NULL COMMENT '文章标签',
  `isCommented` char(1) DEFAULT NULL COMMENT '是否被评论',
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES ('59', '学习', '这篇文章是为了介绍自己自学用过的Java视频资料。本套整合教程总共180+G，共450+小时。考虑到绝大部分视频至少要看两遍，而且视频总时长并不代表学习时长，所以零基础初学者总学习时间大约为：600小时视频时长 + 100小时理解 + 100小时练习，至少需要800小时。你可能觉得自己能一天学习8小时，实际上平均下来每天能学4小时都算厉害了。总会有各种原因，比如当天内容太难，公司聚会，要出差等等。如果周末你也是坚持学习，那么最理想状况下，6个半月就可以学完，达到工作后能被人带的水平。但我知道那其实基本不可能。', '                                                > 使用Editor.md保存的html代码 前端页面如何显示\r\n\r\n1.引入css:grimacing: :kissing_heart:\r\n```css\r\n<link rel=\"stylesheet\" href=\"/editor.md/css/editormd.css\" />\r\n```\r\n2.引入js\r\n```javascript\r\n<script  src=\"/js/jquery-1.11.3.min.js\"></script>\r\n<script  src=\"/editor.md/editormd.js\"></script>\r\n<script  src=\"/editor.md/lib/marked.min.js\"></script>\r\n<script  src=\"/editor.md/lib/prettify.min.js\"></script>\r\n```\r\n3.模板引擎渲染html,取出html代码\r\n```css\r\n<div id=\"content\">\r\n  {{ $article->editor-html-code }}   // laravel blade\r\n</div>\r\n```\r\n![](http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611504372466伙伴.jpg)\r\n                ', '3', '10', '2020-09-20', '2021-01-25 00:07:29', '0', 'http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611504449851', '1', '0', null, 'null', null);
INSERT INTO `t_article` VALUES ('64', 'Java学习路线推荐1', '在网上看到有很多的前端学习路线图，但大部分的前端学习路线图是很零碎的，没有系统的前端学习目标和重点知识，也不知道学到什么程度可以找工作。 前端入门小白在网上搜到前端 . . .', '```\r\npackage com.bjpowernode.blog.back.controller;\r\n\r\nimport com.bjpowernode.blog.back.bean.Article;\r\nimport com.bjpowernode.blog.back.bean.Category;\r\nimport com.bjpowernode.blog.back.bean.Tag;\r\nimport com.bjpowernode.blog.back.bean.User;\r\nimport com.bjpowernode.blog.back.service.ArticleService;\r\nimport com.bjpowernode.blog.base.bean.PaginationVo;\r\nimport com.bjpowernode.blog.base.bean.ResultVo;\r\nimport com.bjpowernode.blog.base.constants.BlogConstants;\r\nimport com.bjpowernode.blog.base.exception.BlogException;\r\nimport com.bjpowernode.blog.base.util.FileUploadUtil;\r\nimport com.github.pagehelper.PageHelper;\r\nimport com.github.pagehelper.PageInfo;\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.ui.Model;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.RequestParam;\r\nimport org.springframework.web.bind.annotation.ResponseBody;\r\nimport org.springframework.web.multipart.MultipartFile;\r\n\r\nimport javax.servlet.http.HttpServletRequest;\r\nimport javax.servlet.http.HttpSession;\r\nimport java.util.Arrays;\r\nimport java.util.List;\r\nimport java.util.Map;\r\n\r\n/**\r\n * Company :  北京动力节点\r\n * Author :   Andy\r\n * Date : 2021/1/12\r\n * Description :\r\n */\r\n@Controller\r\npublic class ArticleController {\r\n\r\n    @Autowired\r\n    private ArticleService articleService;\r\n\r\n    //增加点赞数\r\n    @RequestMapping(\"/article/addThumbsUp\")\r\n    @ResponseBody\r\n    public ResultVo addThumbsUp(String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            String thumbsUp = articleService.addThumbsUp(aid);\r\n            resultVo.setOk(true);\r\n            resultVo.setMess(thumbsUp);\r\n        }catch (BlogException e){\r\n            resultVo.setOk(true);\r\n            e.printStackTrace();\r\n        }\r\n        return resultVo;\r\n    }\r\n\r\n    //前提查询文章\r\n    @RequestMapping(\"/article/articleList\")\r\n    public String articleList(Model model){\r\n        //查询最新发布的前6篇文章\r\n        List<Article> articles = articleService.queryTop6();\r\n        model.addAttribute(\"articles\",articles);\r\n        return \"../../view/article/article\";\r\n    }\r\n    //根据主键查询文章信息\r\n    @RequestMapping(\"/article/queryById\")\r\n    public String queryById(String aid, Model model){\r\n        Article article = articleService.queryById(aid);\r\n        model.addAttribute(\"article\",article);\r\n        return \"updateArticle\";\r\n    }\r\n\r\n    //根据主键查询文章信息,跳转到前台文章详情页\r\n    @RequestMapping(\"/article/queryByIdToDetail\")\r\n    public String queryByIdToDetail(String aid, Model model){\r\n        Article article = articleService.queryById(aid);\r\n        model.addAttribute(\"article\",article);\r\n        return \"../../view/article/articleDetail\";\r\n    }\r\n\r\n    //异步更新文章是否公开\r\n    @RequestMapping(\"/article/updateIsOpen\")\r\n    @ResponseBody\r\n    public ResultVo updateIsOpen(String isOpen,String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            articleService.updateIsOpen(isOpen,aid);\r\n            resultVo.setOk(true);\r\n            if(\"1\".equals(isOpen)){\r\n                //公开\r\n                resultVo.setMess(\"已将文章设为公开\");\r\n            }else{\r\n                //私密\r\n                resultVo.setMess(\"已将文章设为私密\");\r\n            }\r\n\r\n        } catch (BlogException e) {\r\n            e.printStackTrace();\r\n            resultVo.setOk(false);\r\n            if(\"1\".equals(isOpen)){\r\n                //公开\r\n                resultVo.setMess(\"已将文章设为公开失败\");\r\n            }else{\r\n                //私密\r\n                resultVo.setMess(\"已将文章设为私密失败\");\r\n            }\r\n        }\r\n        return resultVo;\r\n    }\r\n\r\n    //选中栏目查询栏目下所有的标签\r\n    @RequestMapping(\"/article/queryByCategory\")\r\n    @ResponseBody\r\n    public List<Tag> queryByCategory(String cid,HttpSession session){\r\n        //从ServletContext中获取栏目信息\r\n        List<Category> categories =\r\n                (List<Category>) session.getServletContext().getAttribute(\"categories\");\r\n        List<Tag> tags = null;\r\n        for (Category category : categories) {\r\n            if(cid.equals(category.getCid())){\r\n                //获取栏目下对应的标签\r\n               tags = category.getTags();\r\n            }\r\n        }\r\n        return tags;\r\n    }\r\n\r\n    //文章列表和条件查询列表\r\n    @RequestMapping(\"/article/list\")\r\n    @ResponseBody\r\n    public PaginationVo list(@RequestParam(defaultValue = \"1\",required = false) int page,\r\n                             @RequestParam(defaultValue = \"2\",required = false) int pageSize,\r\n                             String title, HttpSession session){\r\n        //开启分页功能 limit a,b\r\n        PageHelper.startPage(page, pageSize);\r\n        //获取当前登录用户信息\r\n        User user = (User) session.getAttribute(BlogConstants.LOGIN_USER);\r\n        //查询所有文章信息\r\n        List<Article> articles = articleService.list(user.getUid(),title);\r\n        PageInfo<Article> pageInfo = new PageInfo<>(articles);\r\n        //把前台分页插件需要的数据都封装到paginationVo\r\n        PaginationVo<Article> paginationVo = new PaginationVo<>(pageInfo);\r\n        return paginationVo;\r\n    }\r\n\r\n    //发布和修改文章\r\n    @RequestMapping(\"/article/saveOrUpdateArticle\")\r\n    public String saveOrUpdateArticle(Article article, HttpServletRequest request,\r\n                                        MultipartFile img,String[] tid,String aid){\r\n        //获取文章LOGO图片\r\n        Map<String,Object> map = FileUploadUtil.fileUpload(img,request);\r\n        String logo = (String) map.get(\"url\");\r\n        article.setLogo(logo);\r\n\r\n        //文章标签\r\n        article.setTagNames(Arrays.toString(tid));\r\n\r\n        //将登录用户主键设置到外键中\r\n        User user =\r\n                (User) request.getSession().getAttribute(BlogConstants.LOGIN_USER);\r\n        article.setUid(user.getUid());\r\n        ResultVo resultVo = new ResultVo();\r\n        try{\r\n            articleService.saveOrUpdateArticle(article,aid);\r\n        }catch (BlogException e){\r\n            System.out.println(\"添加文章失败\");\r\n        }\r\n\r\n        return \"article\";\r\n    }\r\n\r\n    //异步删除文章\r\n    @RequestMapping(\"/article/deleteArticle\")\r\n    @ResponseBody\r\n    public ResultVo deleteArticle(String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            articleService.deleteArticle(aid);\r\n            resultVo.setOk(true);\r\n            resultVo.setMess(\"删除文章成功\");\r\n        } catch (BlogException e) {\r\n            e.printStackTrace();\r\n            resultVo.setOk(false);\r\n        }\r\n        return resultVo;\r\n    }\r\n}\r\n\r\n```\r\n![](http://localhost:8080/blog\\upload\\2021-01-13\\admin\\1610504718461a1.jpg)', '4', '10', '2021-01-13', '2021-01-25 00:39:18', '0', 'http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611506358721', '1', '1', '3', 'null', null);
INSERT INTO `t_article` VALUES ('65', 'Java学习路线推荐2', '这篇文章是为了介绍自己自学用过的Java视频资料。本套整合教程总共180+G，共450+小时。考虑到绝大部分视频至少要看两遍，而且视频总时长并不代表学习时长，所以零基础初学者总学习时间大约为：600小时视频时长 + 100小时理解 + 100小时练习，至少需要800小时。你可能觉得自己能一天学习8小时，实际上平均下来每天能学4小时都算厉害了。总会有各种原因，比如当天内容太难，公司聚会，要出差等等。如果周末你也是坚持学习，那么最理想状况下，6个半月就可以学完，达到工作后能被人带的水平。但我知道那其实基本不可能。', '```\r\npackage com.bjpowernode.blog.back.controller;\r\n\r\nimport com.bjpowernode.blog.back.bean.Article;\r\nimport com.bjpowernode.blog.back.bean.User;\r\nimport com.bjpowernode.blog.back.service.ArticleService;\r\nimport com.bjpowernode.blog.base.bean.ResultVo;\r\nimport com.bjpowernode.blog.base.constants.BlogConstants;\r\nimport com.bjpowernode.blog.base.exception.BlogException;\r\nimport com.bjpowernode.blog.base.util.FileUploadUtil;\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.RestController;\r\nimport org.springframework.web.multipart.MultipartFile;\r\n\r\nimport javax.servlet.http.HttpServletRequest;\r\nimport java.util.Map;\r\n\r\n/**\r\n * Company :  北京动力节点\r\n * Author :   Andy\r\n * Date : 2021/1/12\r\n * Description :\r\n */\r\n@Controller\r\npublic class ArticleController {\r\n\r\n    @Autowired\r\n    private ArticleService articleService;\r\n\r\n    //发布和修改文章\r\n    @RequestMapping(\"/article/saveOrUpdateArticle\")\r\n    public String saveOrUpdateArticle(Article article, HttpServletRequest request,\r\n                                        MultipartFile img){\r\n        //获取文章LOGO图片\r\n        Map<String,Object> map = FileUploadUtil.fileUpload(img,request);\r\n        String logo = (String) map.get(\"url\");\r\n        article.setLogo(logo);\r\n\r\n        //将登录用户主键设置到外键中\r\n        User user =\r\n                (User) request.getSession().getAttribute(BlogConstants.LOGIN_USER);\r\n        article.setUid(user.getUid());\r\n        ResultVo resultVo = new ResultVo();\r\n        try{\r\n            articleService.saveOrUpdateArticle(article);\r\n        }catch (BlogException e){\r\n            System.out.println(\"添加文章失败\");\r\n        }\r\n\r\n        return \"article\";\r\n    }\r\n}\r\n\r\n```\r\n![](http://localhost:8080/blog\\upload\\2021-01-13\\admin\\1610504718461a1.jpg)\r\n\r\n                \r\n                ', '4', '200', '2021-03-13', '2021-01-25 00:16:49', '0', 'http://localhost:8080/blog\\upload\\2021-01-13\\admin\\1610539885667a1.jpg', '1', '1', '6', '自驾游, 飞机旅游', null);
INSERT INTO `t_article` VALUES ('66', '去云南旅游', null, '> 去云南旅游\r\n\r\n01月或春节打算去三亚玩！请问三亚有哪些比较好玩景点？听说三亚的海景房超赞，还想体验一次深海潜水和游艇出海，但消费比较高又很抢手，怎么玩省心省力还省钱？有去过的朋友可以推荐一下游玩路线和景点吗?:blush:\r\n![](http://localhost:8080/blog\\upload\\2021-01-13\\admin\\1610519083028a1.jpg)\r\n                ', '2', '30', '2021-01-14', null, '0', 'http://localhost:8080/blog\\upload\\2021-01-13\\admin\\16105197886023.png', '1', '1', '5', '自驾游, 飞机旅游', null);
INSERT INTO `t_article` VALUES ('67', '赛艇', '赛艇运动', '\r\n                ', '1', '1', '2021-01-24', null, '0', 'http://localhost:8080/blog\\upload\\2021-01-24\\admin\\1611422013336伙伴.jpg', '1', '0', '0', '自驾游, 飞机旅游', null);
INSERT INTO `t_article` VALUES ('68', '关于Java编程', '这篇文章是为了介绍自己自学用过的Java视频资料。本套整合教程总共180+G，共450+小时。考虑到绝大部分视频至少要看两遍，而且视频总时长并不代表学习时长，所以零基础初学者总学习时间大约为：600小时视频时长 + 100小时理解 + 100小时练习，至少需要800小时。你可能觉得自己能一天学习8小时，实际上平均下来每天能学4小时都算厉害了。总会有各种原因，比如当天内容太难，公司聚会，要出差等等。如果周末你也是坚持学习，那么最理想状况下，6个半月就可以学完，达到工作后能被人带的水平。但我知道那其实基本不可能。', ' ```java\r\npackage com.bjpowernode.blog.back.controller;\r\n\r\nimport com.bjpowernode.blog.back.bean.Article;\r\nimport com.bjpowernode.blog.back.bean.Category;\r\nimport com.bjpowernode.blog.back.bean.Tag;\r\nimport com.bjpowernode.blog.back.bean.User;\r\nimport com.bjpowernode.blog.back.service.ArticleService;\r\nimport com.bjpowernode.blog.base.bean.PaginationVo;\r\nimport com.bjpowernode.blog.base.bean.ResultVo;\r\nimport com.bjpowernode.blog.base.constants.BlogConstants;\r\nimport com.bjpowernode.blog.base.exception.BlogException;\r\nimport com.bjpowernode.blog.base.util.FileUploadUtil;\r\nimport com.github.pagehelper.PageHelper;\r\nimport com.github.pagehelper.PageInfo;\r\nimport org.springframework.beans.factory.annotation.Autowired;\r\nimport org.springframework.stereotype.Controller;\r\nimport org.springframework.ui.Model;\r\nimport org.springframework.web.bind.annotation.RequestMapping;\r\nimport org.springframework.web.bind.annotation.RequestParam;\r\nimport org.springframework.web.bind.annotation.ResponseBody;\r\nimport org.springframework.web.multipart.MultipartFile;\r\n\r\nimport javax.servlet.http.HttpServletRequest;\r\nimport javax.servlet.http.HttpSession;\r\nimport java.util.Arrays;\r\nimport java.util.List;\r\nimport java.util.Map;\r\n\r\n/**\r\n * Company :  北京动力节点\r\n * Author :   Andy\r\n * Date : 2021/1/12\r\n * Description :\r\n */\r\n@Controller\r\npublic class ArticleController {\r\n\r\n    @Autowired\r\n    private ArticleService articleService;\r\n\r\n    //增加点赞数\r\n    @RequestMapping(\"/article/addThumbsUp\")\r\n    @ResponseBody\r\n    public ResultVo addThumbsUp(String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            String thumbsUp = articleService.addThumbsUp(aid);\r\n            resultVo.setOk(true);\r\n            resultVo.setMess(thumbsUp);\r\n        }catch (BlogException e){\r\n            resultVo.setOk(true);\r\n            e.printStackTrace();\r\n        }\r\n        return resultVo;\r\n    }\r\n\r\n    //前提查询文章\r\n    @RequestMapping(\"/article/articleList\")\r\n    public String articleList(Model model){\r\n        //查询最新发布的前6篇文章\r\n        List<Article> articles = articleService.queryTop6();\r\n        model.addAttribute(\"articles\",articles);\r\n        return \"../../view/article/article\";\r\n    }\r\n    //根据主键查询文章信息\r\n    @RequestMapping(\"/article/queryById\")\r\n    public String queryById(String aid, Model model){\r\n        Article article = articleService.queryById(aid);\r\n        model.addAttribute(\"article\",article);\r\n        return \"updateArticle\";\r\n    }\r\n\r\n    //根据主键查询文章信息,跳转到前台文章详情页\r\n    @RequestMapping(\"/article/queryByIdToDetail\")\r\n    public String queryByIdToDetail(String aid, Model model){\r\n        Article article = articleService.queryById(aid);\r\n        model.addAttribute(\"article\",article);\r\n        return \"../../view/article/articleDetail\";\r\n    }\r\n\r\n    //异步更新文章是否公开\r\n    @RequestMapping(\"/article/updateIsOpen\")\r\n    @ResponseBody\r\n    public ResultVo updateIsOpen(String isOpen,String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            articleService.updateIsOpen(isOpen,aid);\r\n            resultVo.setOk(true);\r\n            if(\"1\".equals(isOpen)){\r\n                //公开\r\n                resultVo.setMess(\"已将文章设为公开\");\r\n            }else{\r\n                //私密\r\n                resultVo.setMess(\"已将文章设为私密\");\r\n            }\r\n\r\n        } catch (BlogException e) {\r\n            e.printStackTrace();\r\n            resultVo.setOk(false);\r\n            if(\"1\".equals(isOpen)){\r\n                //公开\r\n                resultVo.setMess(\"已将文章设为公开失败\");\r\n            }else{\r\n                //私密\r\n                resultVo.setMess(\"已将文章设为私密失败\");\r\n            }\r\n        }\r\n        return resultVo;\r\n    }\r\n\r\n    //选中栏目查询栏目下所有的标签\r\n    @RequestMapping(\"/article/queryByCategory\")\r\n    @ResponseBody\r\n    public List<Tag> queryByCategory(String cid,HttpSession session){\r\n        //从ServletContext中获取栏目信息\r\n        List<Category> categories =\r\n                (List<Category>) session.getServletContext().getAttribute(\"categories\");\r\n        List<Tag> tags = null;\r\n        for (Category category : categories) {\r\n            if(cid.equals(category.getCid())){\r\n                //获取栏目下对应的标签\r\n               tags = category.getTags();\r\n            }\r\n        }\r\n        return tags;\r\n    }\r\n\r\n    //文章列表和条件查询列表\r\n    @RequestMapping(\"/article/list\")\r\n    @ResponseBody\r\n    public PaginationVo list(@RequestParam(defaultValue = \"1\",required = false) int page,\r\n                             @RequestParam(defaultValue = \"2\",required = false) int pageSize,\r\n                             String title, HttpSession session){\r\n        //开启分页功能 limit a,b\r\n        PageHelper.startPage(page, pageSize);\r\n        //获取当前登录用户信息\r\n        User user = (User) session.getAttribute(BlogConstants.LOGIN_USER);\r\n        //查询所有文章信息\r\n        List<Article> articles = articleService.list(user.getUid(),title);\r\n        PageInfo<Article> pageInfo = new PageInfo<>(articles);\r\n        //把前台分页插件需要的数据都封装到paginationVo\r\n        PaginationVo<Article> paginationVo = new PaginationVo<>(pageInfo);\r\n        return paginationVo;\r\n    }\r\n\r\n    //发布和修改文章\r\n    @RequestMapping(\"/article/saveOrUpdateArticle\")\r\n    public String saveOrUpdateArticle(Article article, HttpServletRequest request,\r\n                                        MultipartFile img,String[] tid,String aid){\r\n        //获取文章LOGO图片\r\n        Map<String,Object> map = FileUploadUtil.fileUpload(img,request);\r\n        String logo = (String) map.get(\"url\");\r\n        article.setLogo(logo);\r\n\r\n        //文章标签\r\n        article.setTagNames(Arrays.toString(tid));\r\n\r\n        //将登录用户主键设置到外键中\r\n        User user =\r\n                (User) request.getSession().getAttribute(BlogConstants.LOGIN_USER);\r\n        article.setUid(user.getUid());\r\n        ResultVo resultVo = new ResultVo();\r\n        try{\r\n            articleService.saveOrUpdateArticle(article,aid);\r\n        }catch (BlogException e){\r\n            System.out.println(\"添加文章失败\");\r\n        }\r\n\r\n        return \"article\";\r\n    }\r\n\r\n    //异步删除文章\r\n    @RequestMapping(\"/article/deleteArticle\")\r\n    @ResponseBody\r\n    public ResultVo deleteArticle(String aid){\r\n        ResultVo resultVo = new ResultVo();\r\n        try {\r\n            articleService.deleteArticle(aid);\r\n            resultVo.setOk(true);\r\n            resultVo.setMess(\"删除文章成功\");\r\n        } catch (BlogException e) {\r\n            e.printStackTrace();\r\n            resultVo.setOk(false);\r\n        }\r\n        return resultVo;\r\n    }\r\n}\r\n\r\n```\r\n![](http://localhost:8080/blog\\upload\\2021-01-25\\admin\\16115059327483.png)\r\n|   |   |\r\n| ------------ | ------------ |\r\n|   |   |\r\n|   |   |\r\n\r\n                ', '4', '0', '2021-01-25', '2021-01-25 00:36:27', '0', 'http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611506187244', '1', '1', '0', 'null', null);
INSERT INTO `t_article` VALUES ('69', '最好的Java学习1', '一门永不过时的编程语言——Java 软件开发，5G时代即将来临，万物互联，更多的终端会使用安卓系统，随之而来的Java开发必然是会越来越火爆，所以学习Java是必要且必须的，下边就是', '\n\n## 2021-01-25 00:53:20 星期一\n\n> 第一阶段：JavaSE基础入门\n\n```javascript\n<script  src=\"/js/jquery-1.11.3.min.js\"></script>\n<script  src=\"/editor.md/editormd.js\"></script>\n<script  src=\"/editor.md/lib/marked.min.js\"></script>\n<script  src=\"/editor.md/lib/prettify.min.js\"></script>\n```\n> 第二阶段：JavaSE核心技术\n\n![](http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611506714893伙伴.jpg)\n                \n                \n                \n                \n                \n                \n                ', '2', '0', '2021-12-19 11:15:53', '2021-01-25 00:56:52', '0', 'http://localhost:8080/blog\\upload\\2021-01-25\\admin\\1611507412198', '1', '1', '1', '自驾游,徒步旅游', null);
INSERT INTO `t_article` VALUES ('70', 'fes', 'afsfe', '\n                fesafwaef', '1', null, '2022-02-25 10:56:30', null, null, '', '1', '0', null, '赛艇,羽毛球', null);
INSERT INTO `t_article` VALUES ('71', 'es', 'fsdf', 'efsdf\n                ', '1', null, '2022-02-26 15:25:36', null, null, '', '1', '1', null, '赛艇', null);

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL COMMENT '标签名称',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES ('1', '运动');
INSERT INTO `t_category` VALUES ('2', '旅游');
INSERT INTO `t_category` VALUES ('3', '购物');
INSERT INTO `t_category` VALUES ('4', '编程');

-- ----------------------------
-- Table structure for t_link
-- ----------------------------
DROP TABLE IF EXISTS `t_link`;
CREATE TABLE `t_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_name` varchar(15) NOT NULL COMMENT '站点名',
  `site_url` varchar(45) NOT NULL COMMENT '站点地址',
  `site_desc` varchar(45) NOT NULL COMMENT '站点描述  简单备注下 ',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='合作伙伴';

-- ----------------------------
-- Records of t_link
-- ----------------------------
INSERT INTO `t_link` VALUES ('1', '亚马逊', 'http://www.baidu.com', '电商', '1');
INSERT INTO `t_link` VALUES ('2', '淘宝', 'http://www.taobao.com', '电商', '0');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tname` varchar(255) DEFAULT NULL COMMENT '标签名称',
  `cid` int(11) DEFAULT NULL COMMENT '所属栏目',
  PRIMARY KEY (`tid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES ('1', '户外运动', '1');
INSERT INTO `t_tag` VALUES ('2', '赛艇', '1');
INSERT INTO `t_tag` VALUES ('3', '羽毛球', '1');
INSERT INTO `t_tag` VALUES ('4', '垒球', '1');
INSERT INTO `t_tag` VALUES ('5', '自驾游', '2');
INSERT INTO `t_tag` VALUES ('6', '徒步旅游', '2');
INSERT INTO `t_tag` VALUES ('7', '飞机旅游', '2');
INSERT INTO `t_tag` VALUES ('8', '女装、男装', '3');
INSERT INTO `t_tag` VALUES ('9', '家电', '3');
INSERT INTO `t_tag` VALUES ('10', '手机、数码', '3');
INSERT INTO `t_tag` VALUES ('11', '厨具', '3');
INSERT INTO `t_tag` VALUES ('12', 'Java', '4');
INSERT INTO `t_tag` VALUES ('13', 'PHP', '4');
INSERT INTO `t_tag` VALUES ('14', 'JavaScript', '4');
INSERT INTO `t_tag` VALUES ('15', 'Dubbo', '4');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `password` varchar(32) NOT NULL COMMENT '密码  采取MD5加密',
  `role` char(1) DEFAULT NULL COMMENT '0:管理员 1:普通用户',
  `createTime` char(10) DEFAULT NULL COMMENT '创建时间',
  `lastLoginTime` char(19) DEFAULT NULL COMMENT '登录时间',
  `state` char(1) DEFAULT NULL COMMENT '账号是否被锁定 0:锁定 1:未锁定',
  `loginIp` varchar(17) DEFAULT NULL COMMENT '登录ip',
  `phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `loginCout` int(11) DEFAULT NULL COMMENT '登录次数',
  `img` varchar(255) DEFAULT NULL COMMENT '用户头像',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '管理员', '21232f297a57a5a743894a0e4a801fc3', '1', null, '2021-04-20 10:01:21', '1', '0:0:0:0:0:0:0:1', '13739242980', '73', null);
INSERT INTO `t_user` VALUES ('2', '小红', '小红', '123', '1', null, null, null, null, null, null, null);
INSERT INTO `t_user` VALUES ('3', '小强', null, '123', '0', null, null, null, null, null, null, null);
