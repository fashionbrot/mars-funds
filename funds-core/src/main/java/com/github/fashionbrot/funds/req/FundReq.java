package com.github.fashionbrot.funds.req;

import com.github.fashionbrot.funds.util.ObjectUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Data
public class FundReq extends PageReq {

    private String fundCode;

    private Integer vlimit;

    /**
     * 推演天数
     * 往前推演（）天,如果当前基金比当天基金估值低，则筛选出来
     */
    private Integer tuiyan;


    private List<Map<Order, String>> order = new ArrayList<Map<Order, String>>();

    @Getter
    @AllArgsConstructor
    public enum Order {
        column, dir
    }
}
