package com.github.fashionbrot.funds;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;


@Slf4j
@SpringBootApplication(scanBasePackages = {"com.github.fashionbrot.funds"})
@MapperScan(basePackages = {"com.github.fashionbrot.funds.mapper"})
public class MarsApplication extends SpringBootServletInitializer {


    public static void main(String[] args) {
        SpringApplication.run(MarsApplication.class,args);
        log.info("Start to finish:{}", System.currentTimeMillis());
    }

}
