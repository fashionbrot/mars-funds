package com.github.fashionbrot.funds.service;


import com.github.fashionbrot.funds.dao.RoleInfoDao;
import com.github.fashionbrot.funds.entity.RoleInfo;
import com.github.fashionbrot.funds.enums.RespCode;
import com.github.fashionbrot.funds.exception.MarsException;
import com.github.fashionbrot.funds.util.ChineseToSpellUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author fashionbrot
 * @version 0.1.0
 * @date 2019/12/8 22:45
 */
@Service
@Slf4j
public class RoleInfoService  {

    @Autowired
    protected RoleInfoDao roleInfoDao;


    public void add(RoleInfo roleInfo) {
        roleInfo.setRoleCode(ChineseToSpellUtil.getPingYin(roleInfo.getRoleName()));
        if (roleInfoDao.add(roleInfo)!=1){
            throw new MarsException(RespCode.SAVE_ERROR);
        }
    }


    public void update(RoleInfo roleInfo) {
        roleInfo.setRoleCode(ChineseToSpellUtil.getPingYin(roleInfo.getRoleName()));
        if (roleInfoDao.update(roleInfo)!=1){
            throw new MarsException(RespCode.UPDATE_ERROR);
        }
    }


    public void deleteById(Long id) {
        if(roleInfoDao.deleteById(id)!=1){
            throw new MarsException(RespCode.DELETE_ERROR);
        }
    }


    public RoleInfo queryById(Long id) {
        return roleInfoDao.queryById(id);
    }


    public List<RoleInfo> queryAll() {
        return roleInfoDao.queryAll(null);
    }


}
