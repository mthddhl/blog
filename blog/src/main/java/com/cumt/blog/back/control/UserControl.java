package com.cumt.blog.back.control;


import com.cumt.blog.back.bean.User;
import com.cumt.blog.back.service.UserService;
import com.cumt.blog.base.bean.ResultVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
public class UserControl {
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    @ResponseBody
    public ResultVo userLogin(User user, String code, HttpSession session) {
        System.out.println(789465);
        ResultVo resultVo=new ResultVo();
        String rightCode= (String) session.getAttribute("code");
        try {
            user=userService.login(user,code,rightCode);
            session.setAttribute("user",user);
            resultVo.setOk(true);
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }
        return resultVo;
    }
    @RequestMapping("/workbench/index")
    public String index(){
        return "workbench/index";
    }

    @RequestMapping("/user/pasVerity")
    @ResponseBody
    public ResultVo pasVerity(String password,HttpSession session){
        ResultVo resultVo =new ResultVo();
        User user= (User) session.getAttribute("user");
        try {
            userService.pasVerity(password,user);
            resultVo.setOk(true);
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }
        return resultVo;
    }

    @RequestMapping("/user/loginOut")
    public String userLogin(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/login.jsp";

    }
    @RequestMapping("/user/update")
    @ResponseBody
    public ResultVo userUpdate(User user,HttpSession session){
        ResultVo resultVo=new ResultVo();
        try {
            userService.update(user);
            session.setAttribute("user",user);
            resultVo.setOk(true);
            resultVo.setMess("更新成功");
        }catch (Exception e){
            resultVo.setMess(e.getMessage());
        }

        return resultVo;
    }
}
