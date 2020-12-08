package com.github.fashionbrot.funds.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.github.fashionbrot.funds.dao.FundDao;
import com.github.fashionbrot.funds.dao.FundValuationDao;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.entity.FundValuationEntity;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.CurdException;
import com.github.fashionbrot.funds.req.FundReq;
import com.github.fashionbrot.funds.service.FundService;
import com.github.fashionbrot.funds.util.CollectionUtil;
import com.github.fashionbrot.funds.util.StringUtil;
import com.github.fashionbrot.funds.vo.PageVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.logging.log4j.util.Strings;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Service
public class FundServiceImpl implements FundService {

    @Autowired
    private FundDao fundDao;

    @Autowired
    private FundValuationDao fundValuationDao;

    @Override
    public Collection<FundEntity> queryList(Map<String, Object> params) {
        return fundDao.listByMap(params);
    }

    /**
     * 查询数据列表
     * @param params 查询条件
     * @return List<FundEntity>
     */
    public Collection<FundEntity> fundByMap(Map<String, Object> params){
        return fundDao.listByMap(params);
    }

    /**
    * 分页查询
    * @param req
    * @return
    */
    public PageVo pageList(FundReq req){
        Page<?> page= PageHelper.startPage(req.getPage(),req.getPageSize());
        QueryWrapper q=new QueryWrapper();
        if (StringUtil.isNotEmpty(req.getFundCode())){
            q.eq("fund_code",req.getFundCode());
        }
        List<Map<FundReq.Order, String>> order = req.getOrder();
        if (CollectionUtil.isNotEmpty(order)){
            order.forEach(map->{
                String key = map.get(FundReq.Order.column);
                if ("3".equals(key)){
                    if ("desc".equals(map.get(FundReq.Order.dir))){
                        q.orderByDesc(" equity_return");
                    }else{
                        q.orderByAsc(" equity_return");
                    }
                }
                if ("1".equals(key)){
                    if ("desc".equals(map.get(FundReq.Order.dir))){
                        q.orderByDesc("fund_code");
                    }else{
                        q.orderByAsc(" fund_code");
                    }
                }
            });
        }

        List<FundEntity> list = fundDao.list(q);
        List<FundEntity> tuiyanList =null;
        if (CollectionUtils.isNotEmpty(list)){
            tuiyanList = new ArrayList<>(list.size());
            for (FundEntity fundEntity : list) {
                QueryWrapper qq=new QueryWrapper();
                qq.select("equity_return");
                qq.eq("fund_code",fundEntity.getFundCode());
                qq.orderByDesc("fund_date");
                if (req.getVlimit()!=null) {
                    qq.last("limit "+req.getVlimit()+"");
                }
                List<FundValuationEntity> list2 = fundValuationDao.list(qq);
                if (CollectionUtils.isNotEmpty(list2)){
                    List<Double> list3 = list2.stream().map(m-> m.getEquityReturn()).collect(Collectors.toList());
                    if (CollectionUtils.isNotEmpty(list3)) {
                        fundEntity.setLastGuzhi(list3.get(0).toString());

                        if (req.getTuiyan()!=null){
                            double today = list3.get(0);
                            if (!tuiyan(list3,today,req.getTuiyan())){
                                tuiyanList.add(fundEntity);
                            }
                        }
                        Collections.reverse(list3);
                        String guzhi = Strings.join(list3, ',');
                        fundEntity.setGuzhi( guzhi);
                    }
                }
            }
        }

        long total = page.getTotal();
        if (CollectionUtils.isNotEmpty(tuiyanList)){
            list = tuiyanList;
            total = Long.valueOf(list.size()+"");
        }


        return PageVo.builder()
                .data(list)
                .iTotalDisplayRecords(total)
                .build();
    }

    /**
     * 当天估值，循环判断上一天是否比当天低
     * @param list
     * @param today
     * @param tuiyan
     * @return
     */
    public boolean tuiyan(List<Double> list , double today,Integer tuiyan){
        if (CollectionUtils.isNotEmpty(list)){
            if (list.size()<tuiyan){
                return true;
            }
            for (int i = 0; i <list.size() ; i++) {
                Double d = list.get(i+1);
                if (today<0){
                    if (d<0 && today<d){
                        return false;
                    }
                }
                if (tuiyan==(i-1)){
                    return true;
                }
            }
        }

        return true;
    }

    @Override
    public void insert(FundEntity entity) {
        if(!fundDao.save(entity)){
            throw new CurdException(RespCode.SAVE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertBatch(Collection<FundEntity> entityList) {
        return fundDao.saveBatch(entityList,30);
    }

    /**
     * 批量插入
     *
     * @param entityList
     * @param batchSize
     * @return
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertBatch(Collection<FundEntity> entityList, int batchSize) {
        return fundDao.saveBatch(entityList,batchSize);
    }

    @Override
    public void updateById(FundEntity entity) {
        if(!fundDao.updateById(entity)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    public void update(FundEntity entity, Wrapper<FundEntity> updateWrapper) {
        if(!fundDao.update(entity, updateWrapper)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundEntity> entityList) {
        return fundDao.updateBatchById(entityList,30);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundEntity> entityList, int batchSize) {
        return fundDao.updateBatchById(entityList,batchSize);
    }

    @Override
    public FundEntity selectById(Serializable id) {
        return fundDao.getById(id);
    }

    @Override
    public void deleteById(Serializable id) {
        if(!fundDao.removeById(id)){
            throw new CurdException(RespCode.DELETE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatchIds(Collection<? extends Serializable> idList) {
        if (CollectionUtils.isNotEmpty(idList)){
            boolean result = fundDao.removeByIds(idList);
            if (!result){
                throw new CurdException(RespCode.DELETE_ERROR);
            }
        }
    }

    @Override
    public boolean deleteByMap(Map<String, Object> columnMap) {
        return fundDao.removeByMap(columnMap);
    }

    @Override
    public boolean delete(Wrapper<FundEntity> queryWrapper) {
        return fundDao.remove(queryWrapper);
    }



}