package com.github.fashionbrot.funds.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.github.fashionbrot.funds.dao.FundDao;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.CurdException;
import com.github.fashionbrot.funds.req.FundReq;
import com.github.fashionbrot.funds.service.FundService;
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
        Page<?> page= PageHelper.startPage(req.getPageNo(),req.getPageSize());
        List<FundEntity> list = fundDao.list(null);

        return PageVo.builder()
                .data(list)
                .iTotalDisplayRecords(page.getTotal())
                .build();
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