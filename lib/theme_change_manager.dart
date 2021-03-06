
import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

const  kThemeDataKey = 'theme_data_key';

/// 用于主题切换的管理类
class ThemeChangeManager with ChangeNotifier{

  /// 设置成一个单例类，让其他所有地方都可以访问到
  /// step1: 声明一个单例对象、
  ThemeChangeManager._instance();
  /// step2: 创建一个静态变量
  static final ThemeChangeManager _singleton = ThemeChangeManager._instance();
  /// step3: 声明一个工厂方法
  factory ThemeChangeManager(){
    return _singleton;
  }


  /// 这里为目前支持的主题类型，key为主题类型的key， 后面的value为主题的主题色。
  Map<String, Color> themeColorMap = {
    'default' : Colors.white70,
    'blue' : Colors.blue,
    'pink'   : Colors.pink,
  };

  /// 这里为目前支持的主题类型，key为主题类型的key， 后面的value为真正的主题对象。
  Map<String, ThemeDataObject> themeDataObjectMap = {
    'default' : DefaultThemeDataObject(),
    'blue' : BlueThemeDataObject(),
    'pink' : PinkThemeDataObject(),
  };


  /// 声明一个变量并从缓存中读取值,使用时只能通过下面的 get themeKey方法来获取值，这里只做保存变量值
  String _themeKey = '';
  /// set 和 get方法
  String get themeKey {
    if (_themeKey.isEmpty) {
      _themeKey = SpUtil.getString(kThemeDataKey, defValue: 'default')!;
    }
    return _themeKey;
  }
  /// 声明一个内部变量
  ThemeDataObject? _currentThemeDataObject;

  ThemeDataObject get currentThemeDataObject {
    if (_currentThemeDataObject == null){
      _currentThemeDataObject = themeDataObjectMap[themeKey] ??  DefaultThemeDataObject();
    }
    return _currentThemeDataObject!;
  }

  setTheme(String themeKey){
    if (!themeDataObjectMap.keys.contains(themeKey)) return;
    _themeKey = themeKey;
    /// 将真正的主题对象保存起来
    SpUtil.putString(kThemeDataKey, themeKey);

    /// 切换主题
    _currentThemeDataObject = themeDataObjectMap[themeKey] ?? DefaultThemeDataObject();
    /// 通知监听者
    notifyListeners();
  }

}

/// 真正设置并保存的主题设置的对象，内部分为两个部分：系统ThemeData 和自定义 CustomThemeDataObject。
class ThemeDataObject {
  /// 系统自带主题相关设置
  ThemeData themeData;
  /// 自定义额外添加主题相关设置,可为空
  CustomThemeDataObject customThemeDataObject;
  ThemeDataObject({Key? key, required this.themeData, required this.customThemeDataObject});

}

class CustomThemeDataObject{
  CustomThemeDataObject();
  factory CustomThemeDataObject.fromJson(Map<String, dynamic> jsonRes) {
    return CustomThemeDataObject();
  }
  Map<String, dynamic> toJson() => <String, dynamic>{};
}


/// 这里先填写几个默认的配置主题
class DefaultThemeDataObject extends ThemeDataObject{
  DefaultThemeDataObject() : super(themeData: ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.white70,
      textTheme: TextTheme(
        bodyText1: TextStyle(color:Colors.black),
        bodyText2: TextStyle(color:Colors.black),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
      )

  ),customThemeDataObject: CustomThemeDataObject());
}
class BlueThemeDataObject extends ThemeDataObject {
  BlueThemeDataObject() : super(themeData: ThemeData(
      primaryColor: Colors.blue,
      backgroundColor: Colors.blue,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
      )
  ),customThemeDataObject: CustomThemeDataObject());
}
class PinkThemeDataObject extends ThemeDataObject{
  PinkThemeDataObject() : super(themeData: ThemeData(
    primaryColor: Colors.pink,
    backgroundColor: Colors.pink,
      textTheme: TextTheme(
        bodyText1: TextStyle(color:Colors.pink),
        bodyText2: TextStyle(color:Colors.pink),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.pink,
      )
  ),customThemeDataObject: CustomThemeDataObject());
}

