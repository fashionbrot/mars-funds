package com.github.fashionbrot.funds.controller;


import com.github.fashionbrot.funds.entity.FundHoldEntity;
import com.github.fashionbrot.funds.req.FundHoldReq;
import com.github.fashionbrot.funds.service.FundHoldService;
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
 * 用户持仓基金
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-07
 */

@Controller
@RequestMapping("fund/hold")
@Api(tags="用户持仓基金")
@ApiSort(21465367)
public class FundHoldController {

    @Autowired
    private FundHoldService fundHoldService;


    @ApiOperation("数据列表—分页")
    @GetMapping("/page")
    @ResponseBody
    public RespVo page(FundHoldReq req){
        return  RespVo.success(fundHoldService.pageList(req));
    }


    @ApiOperation("数据列表")
    @GetMapping("/queryList")
    @ResponseBody
    public Collection<FundHoldEntity> queryList(@RequestParam Map<String, Object> params){
        return  fundHoldService.queryList(params);
    }


    @ApiOperation("根据id查询")
    @PostMapping("/selectById")
    @ResponseBody
    public RespVo selectById(Long id){
        FundHoldEntity data = fundHoldService.selectById(id);
        return RespVo.success(data);
    }


    @ApiOperation("新增")
    @PostMapping("/insert")
    @ResponseBody
    public RespVo add(@RequestBody FundHoldEntity entity){
        fundHoldService.insert(entity);
        return RespVo.success();
    }


    @ApiOperation("修改")
    @PostMapping("/updateById")
    @ResponseBody
    public RespVo updateById(@RequestBody FundHoldEntity entity){
        fundHoldService.updateById(entity);
        return RespVo.success();
    }
    @ApiOperation("根据id删除")
    @PostMapping("/deleteById")
    @ResponseBody
    public RespVo deleteById(Long id){
        fundHoldService.deleteById(id);
        return RespVo.success();
    }


    @ApiOperation("批量删除")
    @PostMapping("/deleteByIds")
    @ResponseBody
    public RespVo delete(@RequestBody Long[] ids){
        fundHoldService.deleteBatchIds(Arrays.asList(ids));
        return RespVo.success();
    }


}