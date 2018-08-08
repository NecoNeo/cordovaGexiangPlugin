#import <Cordova/CDV.h>


@interface CDVGexiang: CDVPlugin

- (void)startSDKWithAppId:(CDVInvokedUrlCommand *)command;
- (void)getGiUid:(CDVInvokedUrlCommand *)command;
- (void)debug:(CDVInvokedUrlCommand *)command;

@end
