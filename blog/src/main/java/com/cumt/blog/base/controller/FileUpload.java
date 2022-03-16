package com.cumt.blog.base.controller;


import com.cumt.blog.back.bean.User;
import com.cumt.blog.base.util.DateTimeUtil;
import com.cumt.blog.base.util.ImgUploadUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class FileUpload {
    @RequestMapping("/editorUpload")
    @ResponseBody
    public Map<String, Object> editorUpload(@RequestParam(value = "editormd-image-file", required = false) MultipartFile img, HttpSession session) {

        Map<String, Object> map = ImgUploadUtil.imgUploadUtil(img, session);

        return map;
    }

    @RequestMapping("/logoUpload")
    @ResponseBody
    public Map<String, Object> logoUpload(MultipartFile img, HttpSession session) {

        Map<String, Object> map = ImgUploadUtil.imgUploadUtil(img, session);

        return map;
    }
}
