package com.github.fashionbrot.funds.interceptor;


import com.alibaba.fastjson.JSON;
import com.github.fashionbrot.funds.annotation.IsMenu;
import com.github.fashionbrot.funds.consts.MarsConst;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.MarsException;
import com.github.fashionbrot.funds.model.LoginModel;
import com.github.fashionbrot.funds.service.MenuService;
import com.github.fashionbrot.funds.service.UserLoginService;
import com.github.fashionbrot.funds.util.CookieUtil;
import com.github.fashionbrot.funds.vo.RespVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author fashionbrot
 * @version 0.1.0
 * @date 2019/12/8 22:45
 */
@Slf4j
@Component
public class Interceptor implements HandlerInterceptor {

    @Autowired
    private MenuService menuService;
    @Autowired
    private UserLoginService userLoginService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
        if (log.isDebugEnabled()){
            log.debug("request url:{}",request.getRequestURI());
        }
        String  authValue  = CookieUtil.getCookieValue(request, MarsConst.AUTH_KEY,false);
        if (!StringUtils.isEmpty(authValue)) {
            LoginModel model = userLoginService.getLogin();
            if (model == null) {
                throw new MarsException(RespCode.SIGNATURE_MISMATCH);
            }
            if (!menuService.checkPermissionUrl(handler, request)) {
                if (handler instanceof  HandlerMethod) {
                    HandlerMethod handlerMethod = (HandlerMethod) handler;
                    if ( handlerMethod.hasMethodAnnotation(ResponseBody.class)){
                        returnJson(response, RespVo.builder()
                                .code(MarsConst.FAILED)
                                .msg(RespCode.NOT_PERMISSION_ERROR.getMsg())
                                .build());
                        return false;
                    }
                }
                response.sendRedirect(url(request)+"/401?requestUrl="+request.getRequestURI());
                return false;
            }
            return true;
        }
        String header=request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(header)) {
            response.setHeader("REQUIRE_AUTH","true");
            return false;
        }else {
            response.sendRedirect(url(request)+"/user/login");
        }
        return true;
    }

    public String url(HttpServletRequest request){
        String path = request.getContextPath();
        return request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        menuService.loadMenuList(handler,request);
        if(handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            if (handlerMethod.hasMethodAnnotation(IsMenu.class)) {
                CookieUtil.rewriteCookie(request, response, true);
            }
        }
    }

    private void returnJson(HttpServletResponse response, Object json){
        PrintWriter writer = null;
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=utf-8");
        try {
            writer = response.getWriter();
            writer.print(JSON.toJSON(json));
        } catch (IOException e) {
            log.error("response error",e);
        } finally {
            if (writer != null)
                writer.close();
        }
    }

}
