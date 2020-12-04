package com.github.fashionbrot.funds.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.github.fashionbrot.funds.entity.FundStockEntity;
import com.github.fashionbrot.funds.req.FundStockReq;
import com.github.fashionbrot.funds.vo.PageVo;

import java.io.Serializable;
import java.util.Collection;
import java.util.Map;

/**
 * 基金-持仓股票
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */
public interface FundStockService  {

    /**
     * 根据 map 查询
     * @param params
     * @return
     */
    Collection<FundStockEntity> queryList(Map<String, Object> params);

    /**
     * 根据 map 查询
     * @param params
     * @return
     */
    Collection<FundStockEntity> fundStockByMap(Map<String, Object> params);

    /**
     * 分页查询
     * @param req
     * @return PageVo
     */
    PageVo pageList(FundStockReq req);


    /**
     * <p>
     * 插入一条记录（选择字段，策略插入）
     * </p>
     *
     * @param entity 实体对象
     */
    void insert(FundStockEntity entity);

    /**
     * <p>
     * 插入（批量），该方法不支持 Oracle、SQL Server
     * </p>
     *
     * @param entityList 实体对象集合
     */
    boolean insertBatch(Collection<FundStockEntity> entityList);

    /**
     * <p>
     * 插入（批量）
     * </p>
     *
     * @param entityList 实体对象集合
     * @param batchSize  插入批次数量
     */
    boolean insertBatch(Collection<FundStockEntity> entityList, int batchSize);

    /**
     * <p>
     * 根据 ID 选择修改
     * </p>
     *
     * @param entity 实体对象
     */
    void updateById(FundStockEntity entity);

    /**
     * <p>
     * 根据 whereEntity 条件，更新记录
     * </p>
     *
     * @param entity        实体对象
     * @param updateWrapper 实体对象封装操作类 {@link com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper}
     */
    void update(FundStockEntity entity, Wrapper<FundStockEntity> updateWrapper);

    /**
     * <p>
     * 根据ID 批量更新
     * </p>
     *
     * @param entityList 实体对象集合
     */
    boolean updateBatchById(Collection<FundStockEntity> entityList);

    /**
     * <p>
     * 根据ID 批量更新
     * </p>
     *
     * @param entityList 实体对象集合
     * @param batchSize  更新批次数量
     */
    boolean updateBatchById(Collection<FundStockEntity> entityList, int batchSize);

    /**
     * <p>
     * 根据 ID 查询
     * </p>
     *
     * @param id 主键ID
     */
    FundStockEntity selectById(Serializable id);

    /**
     * <p>
     * 根据 ID 删除
     * </p>
     *
     * @param id 主键ID
     */
    void deleteById(Serializable id);

    /**
     * <p>
     * 删除（根据ID 批量删除）
     * </p>
     *
     * @param idList 主键ID列表
     */
    void deleteBatchIds(Collection<? extends Serializable> idList);

    /**
     * <p>
     * 根据 columnMap 条件，删除记录
     * </p>
     *
     * @param columnMap 表字段 map 对象
     */
    boolean deleteByMap(Map<String, Object> columnMap);

    /**
     * <p>
     * 根据 entity 条件，删除记录
     * </p>
     *
     * @param queryWrapper 实体对象封装操作类（可以为 null）
     */
    boolean delete(Wrapper<FundStockEntity> queryWrapper);
}