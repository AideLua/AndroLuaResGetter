--请使用AndroLuaX打开
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.Color"
activity.setTheme(R.style.Theme_MaterialComponents_Light_DarkActionBar)
import "res"--在主题加载完成后导入此模块
activity.setContentView(loadlayout("layout"))

--显示版本信息
local _,actionBar=pcall(activity.getSupportActionBar)
actionBar=actionBar or activity.getActionBar()
if actionBar then
  actionBar.setSubtitle("v"..res._VERSION)
end

print("res.id.attr.actionBarTheme",res.id.attr.actionBarTheme)

local color=res(res.id.attr.actionBarTheme).color.attr.colorControlNormal
--[[
array=activity.getTheme().obtainStyledAttributes({
  R.attr.actionBarTheme
})
id=array.getResourceId(0,0)

local array = activity.getTheme().obtainStyledAttributes(id,{
  R.attr.colorControlNormal
})
color=array.getColor(0,0)
]]
print(Color.red(color),Color.blue(color),Color.green(color))