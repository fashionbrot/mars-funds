package com.github.fashionbrot.funds.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.github.fashionbrot.funds.dao.FundStockDao;
import com.github.fashionbrot.funds.entity.FundStockEntity;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.CurdException;
import com.github.fashionbrot.funds.req.FundStockReq;
import com.github.fashionbrot.funds.service.FundStockService;
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
 * 基金-持仓股票
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
@Service
public class FundStockServiceImpl implements FundStockService {

    @Autowired
    private FundStockDao fundStockDao;

    @Override
    public Collection<FundStockEntity> queryList(Map<String, Object> params) {
        return fundStockDao.listByMap(params);
    }

    /**
     * 查询数据列表
     * @param params 查询条件
     * @return List<FundStockEntity>
     */
    public Collection<FundStockEntity> fundStockByMap(Map<String, Object> params){
        return fundStockDao.listByMap(params);
    }

    /**
    * 分页查询
    * @param req
    * @return
    */
    public PageVo pageList(FundStockReq req){
        Page<?> page= PageHelper.startPage(req.getPageNo(),req.getPageSize());
        List<FundStockEntity> list = fundStockDao.list(null);

        return PageVo.builder()
                .data(list)
                .iTotalDisplayRecords(page.getTotal())
                .build();
    }


    @Override
    public void insert(FundStockEntity entity) {
        if(!fundStockDao.save(entity)){
            throw new CurdException(RespCode.SAVE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean insertBatch(Collection<FundStockEntity> entityList) {
        return fundStockDao.saveBatch(entityList,30);
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
    public boolean insertBatch(Collection<FundStockEntity> entityList, int batchSize) {
        return fundStockDao.saveBatch(entityList,batchSize);
    }

    @Override
    public void updateById(FundStockEntity entity) {
        if(!fundStockDao.updateById(entity)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    public void update(FundStockEntity entity, Wrapper<FundStockEntity> updateWrapper) {
        if(!fundStockDao.update(entity, updateWrapper)){
            throw new CurdException(RespCode.UPDATE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundStockEntity> entityList) {
        return fundStockDao.updateBatchById(entityList,30);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateBatchById(Collection<FundStockEntity> entityList, int batchSize) {
        return fundStockDao.updateBatchById(entityList,batchSize);
    }

    @Override
    public FundStockEntity selectById(Serializable id) {
        return fundStockDao.getById(id);
    }

    @Override
    public void deleteById(Serializable id) {
        if(!fundStockDao.removeById(id)){
            throw new CurdException(RespCode.DELETE_ERROR);
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatchIds(Collection<? extends Serializable> idList) {
        if (CollectionUtils.isNotEmpty(idList)){
            boolean result = fundStockDao.removeByIds(idList);
            if (!result){
                throw new CurdException(RespCode.DELETE_ERROR);
            }
        }
    }

    @Override
    public boolean deleteByMap(Map<String, Object> columnMap) {
        return fundStockDao.removeByMap(columnMap);
    }

    @Override
    public boolean delete(Wrapper<FundStockEntity> queryWrapper) {
        return fundStockDao.remove(queryWrapper);
    }



}