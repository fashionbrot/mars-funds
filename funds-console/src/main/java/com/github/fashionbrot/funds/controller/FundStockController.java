package com.github.fashionbrot.funds.controller;


import com.github.fashionbrot.funds.entity.FundStockEntity;
import com.github.fashionbrot.funds.req.FundStockReq;
import com.github.fashionbrot.funds.service.FundStockService;
import com.github.fashionbrot.funds.vo.PageVo;
import com.github.fashionbrot.funds.vo.RespVo;
import com.github.xiaoymin.knife4j.annotations.ApiSort;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;


/**
 * 基金-持仓股票
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */

@Controller
@RequestMapping("fund/stock")
@Api(tags="基金-持仓股票")
@ApiSort(21420184)
public class FundStockController {

    @Autowired
    private FundStockService fundStockService;


    @ApiOperation("数据列表—分页")
    @GetMapping("/page")
    @ResponseBody
    public PageVo page(FundStockReq req){
        return  fundStockService.pageList(req);
    }


    @ApiOperation("数据列表")
    @GetMapping("/queryList")
    @ResponseBody
    public Collection<FundStockEntity> queryList(@RequestParam Map<String, Object> params){
        return  fundStockService.queryList(params);
    }


    @ApiOperation("根据id查询")
    @PostMapping("/selectById")
    @ResponseBody
    public RespVo selectById(Long id){
        FundStockEntity data = fundStockService.selectById(id);
        return RespVo.success(data);
    }


    @ApiOperation("新增")
    @PostMapping("/insert")
    @ResponseBody
    public RespVo add(@RequestBody FundStockEntity entity){
        fundStockService.insert(entity);
        return RespVo.success();
    }


    @ApiOperation("修改")
    @PostMapping("/updateById")
    @ResponseBody
    public RespVo updateById(@RequestBody FundStockEntity entity){
        fundStockService.updateById(entity);
        return RespVo.success();
    }
    @ApiOperation("根据id删除")
    @PostMapping("/deleteById")
    @ResponseBody
    public RespVo deleteById(Long id){
        fundStockService.deleteById(id);
        return RespVo.success();
    }


    @ApiOperation("批量删除")
    @PostMapping("/deleteByIds")
    @ResponseBody
    public RespVo delete(@RequestBody Long[] ids){
        fundStockService.deleteBatchIds(Arrays.asList(ids));
        return RespVo.success();
    }


}