package com.github.fashionbrot.funds.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.fashionbrot.funds.dao.FundDao;
import com.github.fashionbrot.funds.dao.FundStockDao;
import com.github.fashionbrot.funds.dao.FundValuationDao;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.entity.FundStockEntity;
import com.github.fashionbrot.funds.entity.FundValuationEntity;
import com.github.fashionbrot.funds.util.*;
import jdk.nashorn.api.scripting.ScriptObjectMirror;
import net.bytebuddy.asm.Advice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.format.DateTimeFormatter;
import java.util.*;


@Service
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

    private static void parseFundGSZData(String code) {


        String url = "http://fundgz.1234567.com.cn/js/"+code+".js?rt=1589463125600&jzrq=2020-12-02";
        HttpResult httpResult = HttpClientUtil.httpGet(url, null, null,"ISO-8859-1",2000,2000);
        if (httpResult.isSuccess()){
            String content = httpResult.getContent();
            String str = new String(content.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            handleGSJZData(str);
        }
    }

    @Autowired
    private FundDao fundDao;

    @Autowired
    private FundStockDao fundStockDao;

    @Autowired
    private FundValuationDao fundValuationDao;

    //处理估算净值
    private static void handleGSJZData(String data) {

        int start = data.indexOf("(");
        int end = data.indexOf(")");
        if (start < end && start > 0) {
            String jsonData = data.substring(start + 1, end);
            JSONObject jsonObject = JSONObject.parseObject(jsonData);

            String stringBuilder = "代号：" +
                    jsonObject.getString("fundcode") +
                    "\n" +
                    "名称：" +
                    jsonObject.getString("name") +
                    "\n" +
                    "净值日期：" +
                    jsonObject.getString("jzrq") +
                    "\n" +
                    "单位净值：" +
                    jsonObject.getString("dwjz") +
                    "\n" +
                    "估算净值：" +
                    jsonObject.getString("gsz") +
                    "\n" +
                    "估算增长率：" +
                    jsonObject.getString("gszzl") +
                    "\n" +
                    "估值时间：" +
                    jsonObject.getString("gztime") +
                    "\n";
            System.out.println(stringBuilder);
        }
    }
    DateTimeFormatter dd = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Transactional(rollbackFor = Exception.class)
    public  void tiantian(String code,String startDate){
        String url="http://fund.eastmoney.com/pingzhongdata/"+code+".js?v=20201204225315";
        HttpResult httpResult = HttpClientUtil.httpGet(url, null, null,"ISO-8859-1",2000,2000);
        if (httpResult.isSuccess()){
            String content = httpResult.getContent();
            String str = new String(content.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
            ScriptEngineManager manager = new ScriptEngineManager();
            ScriptEngine engine = manager.getEngineByName("JavaScript");
            try {
                engine.eval(str);
            } catch (ScriptException e) {
                e.printStackTrace();
            }


            String fundName= (String) engine.get("fS_name");
            String fund_sourceRate= (String) engine.get("fund_sourceRate");
            String fund_Rate = (String) engine.get("fund_Rate");
            String fund_minsg = getKey(engine,"fund_minsg");

            FundEntity fundEntity = FundEntity.builder()
                    .fundCode(code)
                    .fundName(fundName)
                    .fundSourceRate(fund_sourceRate)
                    .fundRate(fund_Rate)
                    .fundMinsg(fund_minsg)
                    .build();
            fundDao.save(fundEntity);


            ScriptObjectMirror stockCodes = (ScriptObjectMirror) engine.get("stockCodes");
            List<FundStockEntity> list =new ArrayList<>();
            for (Map.Entry<String, Object> map : stockCodes.entrySet()) {
                list.add(FundStockEntity.builder()
                        .fundId(fundEntity.getId())
                        .stockCode(map.getValue().toString())
                        .build());
            }
            fundStockDao.saveBatch(list);

            boolean start=false;
            Object json = engine.get("Data_netWorthTrend");
            List<FundValuationEntity> vList=new ArrayList<>();
            ScriptObjectMirror objectMirror = (ScriptObjectMirror) json;
            Set<Map.Entry<String, Object>> entrySet = objectMirror.entrySet();
            for (Map.Entry<String, Object> map : entrySet) {
                ScriptObjectMirror son =(ScriptObjectMirror) map.getValue();
                Set<Map.Entry<String, Object>>  sonMap = son.entrySet();
                String date = "";
                String equityReturn = "";
                String value="";
                for (Map.Entry<String, Object> ss : sonMap){
                    if ("x".equals(ss.getKey())){
                        date = new BigDecimal(ss.getValue().toString()).toPlainString();
                    }else if ("equityReturn".equals(ss.getKey())){
                        equityReturn = ss.getValue().toString();
                    }else if("y".equals(ss.getKey())){
                        value = ss.getValue().toString();
                    }
                }
                String dataStr = DateUtil.formatDate(dd,new Date(Long.valueOf(date)));
                if (startDate.equals(dataStr)) {
                    start =true;
                }
                if (start){
                    vList.add(FundValuationEntity.builder()
                            .fundId(fundEntity.getId())
                            .equityReturn(equityReturn)
                            .fundDate(dataStr)
                            .dwjz(value)
                            .build());
                }
            }
            fundValuationDao.saveBatch(vList);
        }

    }

    private static String getKey(ScriptEngine engine,String key){
        return (String)engine.get(key);
    }

    public static void main(String[] args) {
        //p();
        //parseFundGSZData("519674");
        //tiantian("519674");
        /*String dateStr = DateUtil.formatDate(DateTimeFormatter.ofPattern("yyyy-MM-dd"),new Date(1607011200000L));
        System.out.println(dateStr);*/
    }

}
