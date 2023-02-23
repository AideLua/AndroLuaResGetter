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
import "androidx.appcompat.widget.Toolbar"
import "androidx.appcompat.view.ContextThemeWrapper"
import "res"

assert(pcall(function()
  activity.setTheme(R.style.Theme_Material3_DayNight)
end),"请在 AndroLuaX 中打开")

--分割线
divider={
  View;
  layout_width="fill",
  layout_height="1dp",
  backgroundColor=android.res.color.attr.textColorPrimary;
  alpha=0.12;
}
--标题
function buildTitle(text)
  return {
    TextView,
    text=text;
    textColor=res.color.attr.colorPrimary;
    textSize="14sp";
    paddingTop="8dp";
    paddingBottom="4dp";
  }
end
activity.setContentView(loadlayout("layout"))--显示版本信息
actionBar=activity.getSupportActionBar()
actionBar.setSubtitle("v"..res._VERSION)
