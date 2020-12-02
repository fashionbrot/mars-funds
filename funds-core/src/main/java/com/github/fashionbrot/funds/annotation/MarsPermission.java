package com.github.fashionbrot.funds.annotation;

import java.lang.annotation.*;

/**
 * 机构后台 权限注解
 */
@Documented
@Target({ ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
public @interface MarsPermission {

    /**
     * 权限code
     * @return
     */
    String value();

}
