# CocoaAsyncSocket_InstructionForUse

这俩天在搞游戏的通讯，因为是游戏就不断的需要客户端和服务器端交互，而且此过程不想浏览网页一样发送请求后服务器返回给我们数据然后就断开连接了，也不想之前使用的AFNetworking的get和post请求，请求后也断开了。CocoaAsyncSocket是一个长连接通讯。关于socket的理论请看相关文档，这里只介绍CocoaAsyncSocket的实用方法......

（通络通讯里只要链接成功，发送数据就会回应，这是ping的原理）。只要协商好数据格式就没事的。网上有很多对CocoaAsyncSocket又一次封装的案例，有些太高大上没看懂，就直接用CocoaAsyncSocket里的方法了。网上对CocoaAsyncSocket二次封装的有：

1.https://github.com/zhu410289616/RHSocketKit绝对🐂可惜我没看懂

2.https://github.com/Yuzeyang/GCDAsyncSocketManagerGitHub - Yuzeyang/GCDAsyncSocketManager: GCDAsyncSocketManager provides qiuick-to-use GCDAsyncSocket to build socket

3.https://github.com/icoderRo/LCWeChatGitHub - icoderRo/LCWeChat: 有需要的小伙伴

没事可以看看，祝大家多学习学习
争取以后有机会封装下
