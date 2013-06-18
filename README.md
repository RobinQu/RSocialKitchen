#SocialAgentsKitchenSink

调试weibo的认证流程好烦；写几个可以直接复制粘贴的代码，留给日后用。

##Development

* XCode 5.0
* iOS SDK 5.0+
* ARC


##SinaWeibo

基于OAuth2的官方SDK进行的修改，主要改动

* 解除了和SinaWeiboAuthorizeView的绑定，使用标准的UIViewController封装的一个WebView。详见 `SinaWeiboAuthViewController`
* 自动存储认证信息(AccessToken,Expiration等)；默认是存储到公共的NSUserDefault里面