package com.github.fashionbrot.funds.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.github.fashionbrot.funds.dao.FundHoldDao;
import com.github.fashionbrot.funds.entity.FundHoldEntity;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.CurdException;
import com.github.fashionbrot.funds.req.FundHoldReq;
import com.github.fashionbrot.funds.service.FundHoldService;
import com.github.fashionbrot.funds.vo.PageVo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

/**
 * 用户持仓基金
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-07
 */
@Service
public class FundHoldServiceImpl implements FundHoldService {

    @Autowired
    private FundHoldDao fundHoldDao;

    @Override
    public Collection<FundHoldEntity> queryList(Map<String, Object> params) {
        return fundHoldDao.listByMap(params);
    }

    /**
     * 查询数据列表
     * @param params 查询条件
     * @return List<FundHoldEntity>
     */
    public Collection<FundHoldEntity> fundHoldByMap(Map<String, Object> params){
        return fundHoldDao.listByMap(params);
    }

    /**
    * 分页查询
    * @param req
    * @return
    */
    public PageVo pageList(FundHoldReq req){
        Page<?> page= PageHelper.startPage(req.getPage(),req.getPageSize());
        List<FundHoldEntity> list = fundHoldDao.list(null);

        return PageVo.builder()
                .data(list)
                .iTotalDisplayRecords(page.getTotal())
                .build();
    }


    @Override
    public void insert(FundHoldEntity entity) {
        if(!fundHoldDao.save(entity)){
            throw new CurdException(RespCode.SAVE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertBatch(Collection<FundHoldEntity> entityList) {
        return fundHoldDao.saveBatch(entityList,30);
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
    public boolean insertBatch(Collection<FundHoldEntity> entityList, int batchSize) {
        return fundHoldDao.saveBatch(entityList,batchSize);
    }

    @Override
    public void updateById(FundHoldEntity entity) {
        if(!fundHoldDao.updateById(entity)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    public void update(FundHoldEntity entity, Wrapper<FundHoldEntity> updateWrapper) {
        if(!fundHoldDao.update(entity, updateWrapper)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundHoldEntity> entityList) {
        return fundHoldDao.updateBatchById(entityList,30);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundHoldEntity> entityList, int batchSize) {
        return fundHoldDao.updateBatchById(entityList,batchSize);
    }

    @Override
    public FundHoldEntity selectById(Serializable id) {
        return fundHoldDao.getById(id);
    }

    @Override
    public void deleteById(Serializable id) {
        if(!fundHoldDao.removeById(id)){
            throw new CurdException(RespCode.DELETE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatchIds(Collection<? extends Serializable> idList) {
        if (CollectionUtils.isNotEmpty(idList)){
            boolean result = fundHoldDao.removeByIds(idList);
            if (!result){
                throw new CurdException(RespCode.DELETE_ERROR);
            }
        }
    }

    @Override
    public boolean deleteByMap(Map<String, Object> columnMap) {
        return fundHoldDao.removeByMap(columnMap);
    }

    @Override
    public boolean delete(Wrapper<FundHoldEntity> queryWrapper) {
        return fundHoldDao.remove(queryWrapper);
    }



}