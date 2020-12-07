package com.github.fashionbrot.funds.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.github.fashionbrot.funds.dao.FundValuationDao;
import com.github.fashionbrot.funds.entity.FundValuationEntity;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.CurdException;
import com.github.fashionbrot.funds.req.FundValuationReq;
import com.github.fashionbrot.funds.service.FundValuationService;
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
 * 基金估值表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Service
public class FundValuationServiceImpl implements FundValuationService {

    @Autowired
    private FundValuationDao fundValuationDao;

    @Override
    public Collection<FundValuationEntity> queryList(Map<String, Object> params) {
        return fundValuationDao.listByMap(params);
    }

    /**
     * 查询数据列表
     * @param params 查询条件
     * @return List<FundValuationEntity>
     */
    public Collection<FundValuationEntity> fundValuationByMap(Map<String, Object> params){
        return fundValuationDao.listByMap(params);
    }

    /**
    * 分页查询
    * @param req
    * @return
    */
    public PageVo pageList(FundValuationReq req){
        Page<?> page= PageHelper.startPage(req.getPage(),req.getPageSize());
        List<FundValuationEntity> list = fundValuationDao.list(null);

        return PageVo.builder()
                .data(list)
                .iTotalDisplayRecords(page.getTotal())
                .build();
    }


    @Override
    public void insert(FundValuationEntity entity) {
        if(!fundValuationDao.save(entity)){
            throw new CurdException(RespCode.SAVE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertBatch(Collection<FundValuationEntity> entityList) {
        return fundValuationDao.saveBatch(entityList,30);
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
    public boolean insertBatch(Collection<FundValuationEntity> entityList, int batchSize) {
        return fundValuationDao.saveBatch(entityList,batchSize);
    }

    @Override
    public void updateById(FundValuationEntity entity) {
        if(!fundValuationDao.updateById(entity)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    public void update(FundValuationEntity entity, Wrapper<FundValuationEntity> updateWrapper) {
        if(!fundValuationDao.update(entity, updateWrapper)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundValuationEntity> entityList) {
        return fundValuationDao.updateBatchById(entityList,30);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundValuationEntity> entityList, int batchSize) {
        return fundValuationDao.updateBatchById(entityList,batchSize);
    }

    @Override
    public FundValuationEntity selectById(Serializable id) {
        return fundValuationDao.getById(id);
    }

    @Override
    public void deleteById(Serializable id) {
        if(!fundValuationDao.removeById(id)){
            throw new CurdException(RespCode.DELETE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatchIds(Collection<? extends Serializable> idList) {
        if (CollectionUtils.isNotEmpty(idList)){
            boolean result = fundValuationDao.removeByIds(idList);
            if (!result){
                throw new CurdException(RespCode.DELETE_ERROR);
            }
        }
    }

    @Override
    public boolean deleteByMap(Map<String, Object> columnMap) {
        return fundValuationDao.removeByMap(columnMap);
    }

    @Override
    public boolean delete(Wrapper<FundValuationEntity> queryWrapper) {
        return fundValuationDao.remove(queryWrapper);
    }



}