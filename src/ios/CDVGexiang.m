#define GIUID_KEY @"giuid_key"

#import "CDVGexiang.h"
#import "GInsightSDK.h"
#import <CoreLocation/CoreLocation.h>


@interface CDVGexiang()<GInsightSDKDelegate>

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *giUid;
@property (nonatomic, copy) CDVInvokedUrlCommand *lastCmd;

@end


@implementation CDVGexiang


- (void)pluginInitialize
{
    [super pluginInitialize];
    self.appId = @"appId";
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:GIUID_KEY];
    if (uid) {
        _giUid= uid;
    }
}


- (void)startSDKWithAppId:(CDVInvokedUrlCommand *)command
{
    [GInsightSDK startSDKWithAppId:self.appId channel:@"appstore" delegate:self];
    _lastCmd = command;
    NSLog(@"startSDKWithAppId\n");
}


//绑定成功GIUid回调
//TODO 上传服务器用于查询画像
- (void)GInsightSDKDidReceiveGiuid:(NSString *)giUid
{
    [self setGiUid:giUid];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"debug ok"];
    [self.commandDelegate sendPluginResult:result callbackId:self.lastCmd.callbackId];
    NSLog(@"GInsightSDKDidReceiveGiuid SUCCESS\n");
    NSLog(@"giUid: %@\n", giUid);
}


- (void)GInsightSDKDidReceiveError:(NSError *)error
{
    /* 回调错误码类型
     * 1001 APPID 不能为空
     * 1002 IDFA 获取失败
     * 1003 绑定失败
     * 1004 异常错误
     */
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsNSInteger:error.code];
    [self.commandDelegate sendPluginResult:result callbackId:self.lastCmd.callbackId];
    int errCode = (int)error.code;
    NSLog(@"GInsightSDKDidReceiveError ERROR\n");
    NSLog(@"%d", errCode);
}


#pragma mark GETTER/SETTER of giUid
- (void)getGiUid:(CDVInvokedUrlCommand *)command
{
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.giUid];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


- (void)setGiUid:(NSString *)giUid
{
    _giUid = [giUid copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setObject:_giUid forKey:GIUID_KEY];
    });
}


#pragma mark just for DEBUG use

- (void)openURL:(CDVInvokedUrlCommand *)command
{
    NSLog(@"%@\n", self.giUid);
    // if (!self.giUid) {
    //     return;
    // }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://demo-gi.getui.com/?os=ios&giuid=%@",self.giUid]];
    [[UIApplication sharedApplication] openURL:url];
}


- (void)debug:(CDVInvokedUrlCommand *)command
{
    NSLog(@"CDVGexiang debug");
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"debug ok"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


@end
