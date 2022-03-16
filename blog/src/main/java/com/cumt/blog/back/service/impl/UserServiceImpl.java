package com.cumt.blog.back.service.impl;

import com.cumt.blog.back.bean.User;
import com.cumt.blog.back.mapper.UserMapper;
import com.cumt.blog.back.service.UserService;
import com.cumt.blog.base.exception.BlogEnumLogin;
import com.cumt.blog.base.exception.BlogRunException;
import com.cumt.blog.base.util.MD5Util;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;
    @Override
    public User login(User user, String code, String rightCode) {
        if(!code.equals(rightCode)){
            throw new BlogRunException(BlogEnumLogin.User_Login_Code);
        }
        String passwordMD5=user.getPassword();
        user.setPassword(MD5Util.getMD5(passwordMD5));
        User user1 = userMapper.selectOne(user);
        if (user1==null){
            throw new BlogRunException(BlogEnumLogin.User_Login_Napa);
        }
        return user1;
    }

    @Override
    public void pasVerity(String password, User user) {
//        User user1 = userMapper.selectOne(user);
        String passMd5 = MD5Util.getMD5(password);
        if(!passMd5.equals(user.getPassword())){
            throw new BlogRunException(BlogEnumLogin.User_Verify_Password);
        }
    }

    @Override
    public void update(User user) {

        String password = user.getPassword();
        user.setPassword(MD5Util.getMD5(password));
        int i = userMapper.updateByPrimaryKeySelective(user);
        if(i!=1){
            throw new BlogRunException(BlogEnumLogin.User_Infro_Updata);
        }
    }
}
