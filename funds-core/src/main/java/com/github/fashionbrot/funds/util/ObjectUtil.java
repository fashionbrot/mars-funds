package com.github.fashionbrot.funds.util;

import com.github.fashionbrot.funds.enums.ClassTypeEnum;
import lombok.extern.slf4j.Slf4j;

import static org.apache.commons.lang3.StringUtils.isNumeric;


@Slf4j
public class ObjectUtil {
    private ObjectUtil(){

    }

    public static final String EMPTY = "";

    public static String formatString(Object object){
        if (object==null){
            return EMPTY;
        }else{
            return object.toString();
        }
    }

    public static Integer parseInteger(String str ,Integer defaultValue){
        if (StringUtil.isEmpty(str)){
            return defaultValue;
        }
        try {
            return Integer.valueOf(str);
        }catch (Exception e){
            return defaultValue;
        }
    }

    public static Long parseLong(String str ,Long defaultValue){
        if (StringUtil.isEmpty(str)){
            return defaultValue;
        }
        try {
            return Long.parseLong(str);
        }catch (Exception e){
            return defaultValue;
        }
    }

    public static boolean parseBoolean(String str,boolean defaultValue){
        if (StringUtil.isEmpty(str)){
            return defaultValue;
        }
        try {
            return Boolean.parseBoolean(str);
        }catch (Exception e){
            return defaultValue;
        }
    }

    public static Integer formatInteger(Object object){
        if (object==null){
            return 0;
        }else{
            String str=object.toString();
            if (!isNumeric(str)){
                return 0;
            }else{
                try {
                    return Integer.valueOf(str);
                }catch (Exception e){
                    return 0;
                }
            }
        }
    }

    public static Long formatLong(Object object){
        if (object==null){
            return 0L;
        }else{
            String str=object.toString();
            if (!isNumeric(str)){
                return 0L;
            }else{
                try {
                    return Long.valueOf(str);
                }catch (Exception e){
                    return 0L;
                }
            }
        }
    }

    public static Double formatDouble(Object object){
        if (object==null){
            return 0.00;
        }else{
            try {
                return Double.valueOf(object.toString());
            }catch (Exception e){
                return 0.00;
            }
        }
    }

    public static Float formatFloat(Object object){
        if (object==null){
            return 0F;
        }else{
            try {
                return Float.valueOf(object.toString());
            }catch (Exception e){
                return 0F;
            }
        }
    }

    public static Short formatShort(Object object){
        if (object==null){
            return 0;
        }else{
            try {
                return Short.valueOf(object.toString());
            }catch (Exception e){
                return 0;
            }
        }
    }




    public static boolean formatBoolean(Object object){
        if (object==null){
            return false;
        }else{
            String str=object.toString();
            try {
                return Boolean.valueOf(str);
            }catch (Exception e){
                return false;
            }
        }
    }

    public static Object formatObject(Object defaultValue,Class type){
        ClassTypeEnum classTypeEnum = ClassTypeEnum.getValue(type.getTypeName());
        try {
            if (classTypeEnum != null) {
                switch (classTypeEnum) {
                    case PACK_BOOLEAN:
                        return formatBoolean(defaultValue);
                    case PACK_INT:
                        return formatInteger(defaultValue);
                    case PACK_LONG:
                        return  formatLong(defaultValue);
                    case PACK_DOUBLE:
                        return formatDouble(defaultValue);
                    case PACK_FLOAT:
                        return formatFloat(defaultValue);
                    case PACK_SHORT:
                        return formatShort(defaultValue);
                    case BIGDECIMAL:
                        return BigDecimalUtil.formatBigDecimal(defaultValue);
                    default:
                        return defaultValue;
                }
            }else{
                return defaultValue;
            }
        } catch (Exception e){
            log.error("formatObject classType:{} value:{} error:",type,defaultValue,e);
        }
        return null;
    }

}
