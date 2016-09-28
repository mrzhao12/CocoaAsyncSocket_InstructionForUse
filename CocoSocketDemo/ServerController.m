//
//  ServerController.m
//  CocoSocketDemo
//
//  Created by lanouhn on 16/3/16.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ServerController.h"
#import <GCDAsyncSocket.h>


@interface ServerController ()<GCDAsyncSocketDelegate>
@property (weak, nonatomic) IBOutlet UITextField *portF;
@property (weak, nonatomic) IBOutlet UITextField *messageTF;
@property (weak, nonatomic) IBOutlet UITextView *showContentMessageTV;

// 服务器socket(开放端口,监听客户端socket的链接)
@property (strong, nonatomic) GCDAsyncSocket *serverSocket;
// 保存客户端socket
@property (strong, nonatomic) GCDAsyncSocket *clientSocket;

@end

@implementation ServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.初始化服务器socket, 在主线程里回调
    self.serverSocket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}
// 开始监听
- (IBAction)startNotice:(id)sender {
    // 2.开放哪一个端口
    NSError *error = nil;
    BOOL result = [self.serverSocket acceptOnPort:self.portF.text.integerValue error:&error];
    if (result && error == nil) {
        // 开放成功
        [self showMessageWithStr:@"开放成功"];
    }
    
    
}
// 发送消息
// socket是保存的客户端scket, 表示给这个socket客户端发送消息
- (IBAction)sendMessage:(id)sender {
    NSData *data = [self.messageTF.text dataUsingEncoding:NSUTF8StringEncoding];
    // withTimeout -1 : 无穷大,一直等
    // tag : 消息标记
    [self.clientSocket writeData:data withTimeout:- 1 tag:0];
    
}
// 接收消息
// socket是客户端socket, 表示从哪一个客户端读取消息
- (IBAction)receiveMessage:(id)sender {
    [self.clientSocket readDataWithTimeout:11 tag:0];
    
}

 // 信息展示
- (void)showMessageWithStr:(NSString *)str {
    self.showContentMessageTV.text = [self.showContentMessageTV.text stringByAppendingFormat:@"%@\n", str];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    
}


#pragma mark - 服务器socketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
// 保存客户端的socket
    self.clientSocket = newSocket;
    [self showMessageWithStr:@"链接成功"];
    [self showMessageWithStr:[NSString stringWithFormat:@"服务器地址: %@ -端口: %d", newSocket.connectedHost, newSocket.connectedPort]];
    [self.clientSocket readDataWithTimeout:- 1 tag:0];
}

// 收到消息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *text = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [self showMessageWithStr:text];
[self.clientSocket readDataWithTimeout:- 1 tag:0];
}


// 链接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{

    NSLog(@"链接成功");
}

// 链接失败
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{

    NSLog(@"链接失败");
}

@end
