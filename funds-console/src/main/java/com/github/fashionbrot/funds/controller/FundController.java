package com.github.fashionbrot.funds.controller;


import com.github.fashionbrot.funds.annotation.IsMenu;
import com.github.fashionbrot.funds.entity.FundEntity;
import com.github.fashionbrot.funds.entity.FundHoldEntity;
import com.github.fashionbrot.funds.req.FundReq;
import com.github.fashionbrot.funds.service.FundService;
import com.github.fashionbrot.funds.service.FundsService;
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
 * 基金表
 *
 * @author fashionbrot
 * @email fashionbrot@163.com
 * @date 2020-12-05
 */

@Controller
@RequestMapping("fund")
@Api(tags="基金表")
@ApiSort(21420184)
public class FundController {

    @Autowired
    private FundService fundService;

    @Autowired
    private FundsService fundsService;

    @ApiOperation("插入数据")
    @RequestMapping("/build")
    @ResponseBody
    public RespVo build(String code,String startDate){
        fundsService.tiantian(code,startDate,false);
        return RespVo.success();
    }

    @ApiOperation("更新当天估值")
    @RequestMapping("/updateGuzhi")
    @ResponseBody
    public RespVo updateGuzhi(){
        fundsService.updateGuzhi();
        return RespVo.success();
    }

    @ApiOperation("用户持有基金绑定")
    @PostMapping("/fundhold")
    @ResponseBody
    public RespVo fundhold(FundHoldEntity entity){
        fundsService.fundhold(entity);
        return RespVo.success();
    }

    @ApiOperation("删除估值数据，备份到 fundhold")
    @PostMapping("/removeGuzhi")
    @ResponseBody
    public RespVo removeGuzhi(){
        fundsService.removeGuzhi();
        return RespVo.success();
    }


    @ApiOperation("重新获取估值")
    @PostMapping("/loadValuation")
    @ResponseBody
    public RespVo loadValuation(String startDate){
        fundsService.loadValuation(startDate);
        return RespVo.success();
    }


    @IsMenu
    @GetMapping("/index")
    public String index(){
        return "/fund/index";
    }

    @ApiOperation("数据列表—分页")
    @GetMapping("/page")
    @ResponseBody
    public RespVo page(FundReq req){
        return  RespVo.success(fundService.pageList(req));
    }


    @ApiOperation("数据列表")
    @GetMapping("/queryList")
    @ResponseBody
    public Collection<FundEntity> queryList(@RequestParam Map<String, Object> params){
        return  fundService.queryList(params);
    }


    @ApiOperation("根据id查询")
    @PostMapping("/selectById")
    @ResponseBody
    public RespVo selectById(Long id){
        FundEntity data = fundService.selectById(id);
        return RespVo.success(data);
    }


    @ApiOperation("新增")
    @PostMapping("/insert")
    @ResponseBody
    public RespVo add(@RequestBody FundEntity entity){
        fundService.insert(entity);
        return RespVo.success();
    }


    @ApiOperation("修改")
    @PostMapping("/updateById")
    @ResponseBody
    public RespVo updateById(@RequestBody FundEntity entity){
        fundService.updateById(entity);
        return RespVo.success();
    }
    @ApiOperation("根据id删除")
    @PostMapping("/deleteById")
    @ResponseBody
    public RespVo deleteById(Long id){
        fundService.deleteById(id);
        return RespVo.success();
    }


    @ApiOperation("批量删除")
    @PostMapping("/deleteByIds")
    @ResponseBody
    public RespVo delete(@RequestBody Long[] ids){
        fundService.deleteBatchIds(Arrays.asList(ids));
        return RespVo.success();
    }


}