package com.github.fashionbrot.funds.dao;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.github.fashionbrot.funds.entity.Menu;
import com.github.fashionbrot.funds.mapper.MenuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author fashionbrot
 * @version 0.1.0
 * @date 2019/12/8 22:45
 */
@Service
public class MenuDao  {

    @Autowired
    private MenuMapper menuMapper;


    public int add(Menu envInfo) {
        return menuMapper.insert(envInfo);
    }


    public Integer update(Menu envInfo) {
        return menuMapper.updateById(envInfo);
    }


    public Integer deleteById(Long id) {
        return menuMapper.deleteById(id);
    }


    public Menu queryById(Long id) {
        return menuMapper.selectById(id);
    }


    public List<Menu> queryAll(QueryWrapper queryWrapper) {
        return menuMapper.selectList(queryWrapper);
    }


    public List<Menu> selectMenuRole(Long roleId) {
        return menuMapper.selectMenuRole(roleId);
    }


    public List<Menu> selectMenuRoleByUser(Long userId) {
        return menuMapper.selectMenuRoleByUser(userId);
    }
}
