package com.github.fashionbrot.funds.service;


import com.github.fashionbrot.funds.consts.MarsConst;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.MarsException;
import com.github.fashionbrot.funds.model.LoginModel;
import com.github.fashionbrot.funds.util.CookieUtil;
import com.github.fashionbrot.funds.util.JwtTokenUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
public class UserLoginService {

    @Autowired
    private HttpServletRequest request;

    public LoginModel getLogin(){
        String token =  CookieUtil.getCookieValue(request, MarsConst.AUTH_KEY,false);
        if (StringUtils.isEmpty(token)) {
            throw new MarsException(RespCode.SIGNATURE_MISMATCH);
        }
        return JwtTokenUtil.getLogin(token);
    }




}
