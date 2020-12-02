package com.github.fashionbrot.funds.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.fashionbrot.funds.util.CollectionUtil;
import com.github.fashionbrot.funds.util.HttpClientUtil;
import com.github.fashionbrot.funds.util.HttpResult;
import com.github.fashionbrot.funds.util.StringUtil;


public class FundsService {


    public static void p(){
        HttpResult httpResult = HttpClientUtil.httpGet("http://fund.eastmoney.com/js/jjjz_gs.js?dt=1463791574015", null, null);
        if (httpResult.isSuccess()){
            String text = httpResult.getContent();
            if (StringUtil.isNotEmpty(text)){
                text = text.replace("var gs=","");
                JSONObject jsonObject = JSONObject.parseObject(text);
                if (jsonObject!=null){
                   JSONArray jsonArray =  jsonObject.getJSONArray("op");
                   if (CollectionUtil.isNotEmpty(jsonArray)){
                       for(int i=0;i<jsonArray.size();i++){
                           JSONArray json = (JSONArray) jsonArray.get(i);
                           System.out.println(json.get(1));
                       }
                   }
                }
            }

        }

    }

    public static void main(String[] args) {
        p();
    }

}
