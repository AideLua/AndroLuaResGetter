# 更新日志

## v1.0 (alpha4)

1. 支持获取 XML
2. 新增 `res.getOrNewResWithRClass(rClass)`，相当于 `res(rClass)` ，用于指定 `R` 类
3. 新增 `res.getOrNewResWithStyle(resWithRClass,style)`，相当于 `res(style)` ，用于指定主题 ID
4. 新增 `res:clearCache()` 清除缓存，用于在配置更改时刷新资源
5. 新增 `res.setSupportCacheGetterMap(getterText,state)` 设置支持缓存的 Getter
6. 修复 `ResGetterTypeHolder` 未被缓存的问题

## v1.0 (alpha3)

1. `res` 改为 `_M`
2. 支持 `res.dimensionPixelOffset.xxx` 和 `res.dimensionPixelSize.xxx`

## v1.0 (alpha2)

1. 修复 `res.colorStateList.xxx` 无法正确读取 `R.color.xxx`
2. 修复 `res.dimension.xxx` 无法正确读取 `R.dimen.xxx`
3. 修复 `res.int.xxx` 无法正确读取的问题
4. 修复...（一系列问题）

## v1.0 (alpha)

初始版本
