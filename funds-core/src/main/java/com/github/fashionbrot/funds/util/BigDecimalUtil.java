package com.github.fashionbrot.funds.util;

import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;

@Slf4j
public class BigDecimalUtil {

    private BigDecimalUtil(){

    }


    public static BigDecimal formatBigDecimal(Object object){
        if (object==null){
            return BigDecimal.ZERO;
        }else{
            try {
                return new BigDecimal(object.toString());
            }catch (Exception e){
                return BigDecimal.ZERO;
            }
        }
    }

    public static BigDecimal formatBigDecimal(Long value){
        if (value==null){
            return BigDecimal.ZERO;
        }else{
            try {
                return new BigDecimal(value.toString()+"");
            }catch (Exception e){
                log.error("formatBigDecimal value:{} error:{}",value,e);
                return BigDecimal.ZERO;
            }
        }
    }

    public static BigDecimal formatBigDecimal(Double value){
        if (value==null){
            return BigDecimal.ZERO;
        }else{
            try {
                return new BigDecimal(value.doubleValue()+"");
            }catch (Exception e){
                log.error("formatBigDecimal value:{} error:{}",value,e);
                return BigDecimal.ZERO;
            }
        }
    }

    public static BigDecimal formatBigDecimal(String value){
        if (StringUtil.isEmpty(value)){
            return BigDecimal.ZERO;
        }else{
            try {
                return new BigDecimal(value);
            }catch (Exception e){
                log.error("formatBigDecimal value:{} error:{}",value,e);
                return BigDecimal.ZERO;
            }
        }
    }

}
