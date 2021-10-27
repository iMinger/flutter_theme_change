# flutter_theme_change

这个工程用来实验provider+Sp 来切换flutter 工程主题切换。

实施思路：将选中的主题(默认的主题)保存起来到Sp中，下次启动，从Sp中将上一次保存的主题取出来展示。
Sp存储我们的主题key。

核心类：
`ThemeChangeManager` 该类是一个单例类，用来处理主题设置相关操作：读取当前主题，目前支持的所有主题，切换主题等操作。
`ThemeDataObject` 是定义的主题实体类。内部包含两个部分：
>1 `ThemeData` 系统的主题对象
>2 自定义的`CustomThemeDataObject` ，是对系统`ThemeData` 类的补充，目前 `CustomThemeDataObject` 中没有任何字段，后期有需求后可以进行添加。


整体切换思路：入口MyApp()中用 `MltiProvider`包一层，用来监听我们主题切换的Provider发送的 `notifyListeners()`。

在需要切换主题的页面，根据用户选择的主题Key,调用`ThemeChangeManager`中的 `setTheme(String themeKey)` 方法。
`setTheme()` 内部进行了主题相关的切换和存储，并最后调用`notifyListeners()` 来通知App的最顶层来重新 `build`.

目前`ThemeChangeManager` 类集成了所有相关操作和主题相关的配置，后期可考虑将这部分拆开出来，每一个配置文件有一个文件来专门设置和保存。


