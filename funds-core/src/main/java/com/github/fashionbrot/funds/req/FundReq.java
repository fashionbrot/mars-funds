package com.github.fashionbrot.funds.req;

import lombok.Data;

@Data
public class FundReq extends PageReq {

    private String fundCode;

    private Integer limit;

    /**
     * 推演天数
     * 往前推演（）天,如果当前基金比当天基金估值低，则筛选出来
     */
    private Integer tuiyan;

}
