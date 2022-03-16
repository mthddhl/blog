package com.cumt.blog.base.util;

import com.cumt.blog.back.bean.User;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ImgUploadUtil {
    public static Map<String,Object> imgUploadUtil(MultipartFile img, HttpSession session){
//        System.out.println(img);
        String strPath=session.getServletContext().getRealPath("/upload");
        strPath+= File.separator+ DateTimeUtil.getDate()+File.separator+((User)session.getAttribute("user")).getUsername();
        File file=new File(strPath);
        if(!file.exists()){
            file.mkdirs();
        }
        String strImg= img.getOriginalFilename();
        Map<String ,Object> map=new HashMap<>();
        strImg=File.separator+ System.currentTimeMillis()+strImg;
        String url="http://localhost:8080/blog/upload/"+DateTimeUtil.getDate()+File.separator+
                ((User)session.getAttribute("user")).getUsername()+strImg;
        try {
            img.transferTo(new File(strPath+strImg));

            map.put("success",1);
            map.put("url",url);
            map.put("message","上传图片成功");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return map;
    }
}
