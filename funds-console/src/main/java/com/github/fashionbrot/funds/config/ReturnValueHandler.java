package com.github.fashionbrot.funds.config;

import com.github.fashionbrot.funds.annotation.NoReturnValue;
import com.github.fashionbrot.funds.vo.RespVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.MethodParameter;
import org.springframework.http.HttpOutputMessage;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.http.server.ServletServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodReturnValueHandler;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpServletResponse;

/**
 * @author fashionbrot
 * @version 0.1.0
 * @date 2019/12/8 22:45
 */
@Slf4j
@Component
public class ReturnValueHandler implements HandlerMethodReturnValueHandler {


    private static MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();

    @Override
    public boolean supportsReturnType(MethodParameter methodParameter) {
        return methodParameter.getMethodAnnotation(NoReturnValue.class) == null;
    }

    @Override
    public void handleReturnValue(Object object, MethodParameter methodParameter, ModelAndViewContainer modelAndViewContainer, NativeWebRequest nativeWebRequest) throws Exception {
        HttpServletResponse response = nativeWebRequest.getNativeResponse(HttpServletResponse.class);

        RespVo respMessage;
        if (object instanceof RespVo){
            respMessage= (RespVo) object;
        }else{
            respMessage = RespVo.success(object);
        }

        HttpOutputMessage outputMessage = new ServletServerHttpResponse(response);
        modelAndViewContainer.setRequestHandled(true);
        converter.write(respMessage, MediaType.APPLICATION_JSON_UTF8, outputMessage);
    }
}