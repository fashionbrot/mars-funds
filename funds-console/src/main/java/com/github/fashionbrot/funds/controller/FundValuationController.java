package com.github.fashionbrot.funds.controller;


import com.github.fashionbrot.funds.entity.FundValuationEntity;
import com.github.fashionbrot.funds.req.FundValuationReq;
import com.github.fashionbrot.funds.service.FundValuationService;
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
 * 基金估值表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */

@Controller
@RequestMapping("fund/valuation")
@Api(tags="基金估值表")
@ApiSort(21420184)
public class FundValuationController {

    @Autowired
    private FundValuationService fundValuationService;


    @ApiOperation("数据列表—分页")
    @GetMapping("/page")
    @ResponseBody
    public PageVo page(FundValuationReq req){
        return  fundValuationService.pageList(req);
    }


    @ApiOperation("数据列表")
    @GetMapping("/queryList")
    @ResponseBody
    public Collection<FundValuationEntity> queryList(@RequestParam Map<String, Object> params){
        return  fundValuationService.queryList(params);
    }


    @ApiOperation("根据id查询")
    @PostMapping("/selectById")
    @ResponseBody
    public RespVo selectById(Long id){
        FundValuationEntity data = fundValuationService.selectById(id);
        return RespVo.success(data);
    }


    @ApiOperation("新增")
    @PostMapping("/insert")
    @ResponseBody
    public RespVo add(@RequestBody FundValuationEntity entity){
        fundValuationService.insert(entity);
        return RespVo.success();
    }


    @ApiOperation("修改")
    @PostMapping("/updateById")
    @ResponseBody
    public RespVo updateById(@RequestBody FundValuationEntity entity){
        fundValuationService.updateById(entity);
        return RespVo.success();
    }
    @ApiOperation("根据id删除")
    @PostMapping("/deleteById")
    @ResponseBody
    public RespVo deleteById(Long id){
        fundValuationService.deleteById(id);
        return RespVo.success();
    }


    @ApiOperation("批量删除")
    @PostMapping("/deleteByIds")
    @ResponseBody
    public RespVo delete(@RequestBody Long[] ids){
        fundValuationService.deleteBatchIds(Arrays.asList(ids));
        return RespVo.success();
    }


}