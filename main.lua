-- 请使用AndroLuaX打开
-- 开源地址：
--- Gitee: https://gitee.com/AideLua/AndroLuaResGetter
--- GitHub: https://github.com/AideLua/AndroLuaResGetter
-- 欢迎 Star！`(*∩_∩*)′

require "import"
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

assert(pcall(function()
  activity.setTheme(R.style.Theme_Material3_DayNight)
end),"请在 AndroLuaX 中打开")

local codeTypeface=Typeface.createFromFile(activity.getLuaDir().."/JetBrainsMono-Regular.ttf")

--分割线
divider={
  View;
  layout_width="fill",
  layout_height="1dp",
  backgroundColor=android.res.color.attr.textColorPrimary;
  alpha=0.12;
  layout_marginLeft="4dp";
  layout_marginRight="4dp";
}

--标题
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

function buildColorShow(zhName,enName,callName,enableSwitchView)
  local title=zhName.."\n"..enName
  local text=title.."\n  "..callName
  local spannableText=SpannableString(text)
  --spannableText.setSpan(TypefaceSpan(codeTypeface),utf8.len(title)+1,utf8.len(text),Spannable.SPAN_INCLUSIVE_INCLUSIVE)

  return {
    HorizontalScrollView;
    layout_width="fill";
    fillViewport="true";
    {
      enableSwitchView and Switch or TextView,
      text=spannableText,
      textColor=assert(load("return "..callName))();
      layout_width="fill",
      padding="8dp";
      paddingTop="4dp";
      paddingBottom="4dp";
      checked=enableSwitchView and "true";
      textIsSelectable="true";
    }
  };
end

function buildValueShow(resIdCallName,callNames)
  local text=resIdCallName
  local colorList={}
  for key,value in ipairs(callNames) do
    local reallyValue=assert(load("return "..value))()
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
    --Spannable.SPAN_INCLUSIVE_INCLUSIVE
    if content[1] then
      spannableText.setSpan(ForegroundColorSpan(content[1]),content[2],content[3],Spannable.SPAN_INCLUSIVE_INCLUSIVE)
      spannableText.setSpan(TypefaceSpan(codeTypeface),content[2],content[3],Spannable.SPAN_INCLUSIVE_INCLUSIVE)
    end
  end
  --spannableText.setSpan(TypefaceSpan(codeTypeface),utf8.len(resIdCallName)+1,utf8.len(text),Spannable.SPAN_INCLUSIVE_INCLUSIVE)

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

activity.setContentView(loadlayout("layout"))--显示版本信息
actionBar=activity.getSupportActionBar()
actionBar.setSubtitle("v"..res._VERSION)
