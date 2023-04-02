-- 请使用AndroLuaX打开
-- 开源地址：
--- Gitee: https://gitee.com/AideLua/AndroLuaResGetter
--- GitHub: https://github.com/AideLua/AndroLuaResGetter
-- 欢迎 Star！`(*∩_∩*)′

require "import"
local startTime=System.currentTimeMillis()
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.text.style.TypefaceSpan"
import "android.text.Spannable"
import "android.text.SpannableString"
import "android.text.style.ForegroundColorSpan"
import "android.graphics.Typeface"
import "androidx.appcompat.widget.Toolbar"
import "androidx.appcompat.view.ContextThemeWrapper"
import "res"

--以下是封装好的各种各样的代码。如需使用请查看 README.md 以及 layout.aly 最后的demo

assert(pcall(function()
  activity.setTheme(R.style.Theme_Material3_DayNight)
end),"请在 AndroLuaX 中打开")


local codeTypeface=Typeface.createFromFile(activity.getLuaDir().."/JetBrainsMono-Regular.ttf")

--分割线布局
divider={
  View;
  layout_width="fill",
  layout_height="1dp",
  backgroundColor=android.res.color.attr.textColorPrimary;
  alpha=0.12;
  layout_marginLeft="4dp";
  layout_marginRight="4dp";
}

---运行代码，并pcall，防止代码报错
---@param code string
---@param code showError
---@return all 代码返回结果。如果代码报错，则返回 "您的设备无此资源资源:\n..."
function pcallLoadCode(code,showError)
  local success,value=pcall(assert(load("return "..code)))
  if success then
    return value
   elseif showError then
    return "您的设备无此资源资源:\n"..value
  end
end

---生成标题布局
---@param text string
---@return table layout 生成的布局
function buildTitle(text)
  return {
    TextView,
    text=text;
    textColor=res.color.attr.colorPrimary;
    textSize="14sp";
    padding="4dp";
    paddingTop="8dp";
    paddingBottom="4dp";
  }
end

---生成颜色展示布局
---@param zhName string
---@param enName string
---@param callName string
---@param enableSwitchView boolean
---@return table layout 生成的布局
function buildColorShow(zhName,enName,callName,enableSwitchView)
  local title=zhName.."\n"..enName
  local text=title.."\n  "..callName
  local spannableText=SpannableString(text)

  return {
    HorizontalScrollView;
    layout_width="fill";
    fillViewport="true";
    {
      enableSwitchView and Switch or TextView,
      text=spannableText,
      textColor=pcallLoadCode(callName,false);
      layout_width="fill",
      padding="8dp";
      paddingTop="4dp";
      paddingBottom="4dp";
      checked=enableSwitchView and "true";
      textIsSelectable="true";
    }
  };
end

---生成值展示布局
---@param resIdCallName string
---@param callNames string[]
---@return table layout 生成的布局
function buildValueShow(resIdCallName,callNames)
  local text=resIdCallName
  local colorList={}
  for key,value in ipairs(callNames) do
    local reallyValue=pcallLoadCode(value,true)
    local valueType=type(reallyValue)
    local dumpValue=dump(reallyValue):match("(.+) ;")
    text=text.."\n  "..value..": "..dumpValue
    local textLength=utf8.len(text)
    local valueLength=utf8.len(dumpValue)
    local color=0xff9e9e9e
    if valueType=="string" then
      color=0xffe91e63
     elseif valueType=="number" then
      color=0xff2196f3
     elseif valueType=="boolean" or valueType=="nil" then
      color=0xff9c27b0
    end
    table.insert(colorList,{color,textLength-valueLength,textLength})
  end
  local spannableText=SpannableString(text)
  for index,content in ipairs(colorList) do
    if content[1] then
      spannableText.setSpan(ForegroundColorSpan(content[1]),content[2],content[3],Spannable.SPAN_INCLUSIVE_INCLUSIVE)
      spannableText.setSpan(TypefaceSpan(codeTypeface),content[2],content[3],Spannable.SPAN_INCLUSIVE_INCLUSIVE)
    end
  end

  return {
    HorizontalScrollView;
    layout_width="fill";
    fillViewport="true";
    {
      TextView,
      text=spannableText;
      layout_width="fill",
      padding="8dp";
      paddingTop="4dp";
      paddingBottom="4dp";
      textIsSelectable="true";
    }
  };
end

local afterLoadModuleTime=System.currentTimeMillis()
local layout=require "layout"
local afterLoadLayTime=System.currentTimeMillis()

table.insert(layout[2],{
  TextView,
  text="获取资源耗时:"..afterLoadLayTime-afterLoadModuleTime,
  textColor=res.color.attr.colorOnSurface;
  layout_width="fill",
  padding="4dp";
})

activity.setContentView(loadlayout(layout))--显示版本信息
actionBar=activity.getSupportActionBar()
actionBar.setSubtitle("v"..res._VERSION)

local endTime=System.currentTimeMillis()
