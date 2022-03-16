package com.cumt.blog.back.service;

import com.cumt.blog.back.bean.User;

public interface UserService {
    User login(User user, String code, String rightCode);

    void pasVerity(String password, User user);

    void update(User user);
}
