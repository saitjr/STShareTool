//
//  STShareTool.m
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "STShareTool.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import <MessageUI/MessageUI.h>

#define STSHARE_IMAGE shareContent[STShareImageKey]
#define STSHARE_CONTENT shareContent[STShareContentKey]
#define STSHARE_URL shareContent[STShareURLKey]
#define STSHARE_CONCAT_METHOD_NAME(name) [NSString stringWithFormat:@"shareTo%@:", name]

@interface STShareTool () <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation STShareTool

+ (void)initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UMSocialData setAppKey:STShareUMAppKey];
        // 设置微信
        [UMSocialWechatHandler setWXAppId:STShareWechatAppId appSecret:STShareWechatAppSecret url:STShareURL];
        // 设置QQ
        [UMSocialQQHandler setQQWithAppId:STShareQQAppId appKey:STShareQQAppKey url:STShareURL];
        // 其他配置（因为没有用友盟默认的，所以该设置无效）
        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    });
}

+ (instancetype)toolWithViewController:(UIViewController *)viewController {
    STShareTool *tool = [STShareTool new];
    tool.viewController = viewController;
    return tool;
}

- (void)shareToQQ:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.qqData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.qqData.title = STShareTitle;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:nil];
}

- (void)shareToQZone:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.qzoneData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.qzoneData.title = STShareTitle;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:nil];
}

- (void)shareToWeChatSession:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatSessionData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = STShareTitle;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:NULL];
}

- (void)shareToWeChatTimeline:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = STShareTitle;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:nil];
}

- (void)shareToWeibo:(NSDictionary *)shareContent {
    [[UMSocialControllerService defaultControllerService] setShareText:STSHARE_CONTENT shareImage:STSHARE_IMAGE socialUIDelegate:nil];
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self.viewController ,[UMSocialControllerService defaultControllerService], YES);
}

- (void)shareToMessage:(NSDictionary *)shareContent {
    if( [MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = [NSString stringWithFormat:@"%@ %@", STSHARE_CONTENT, STSHARE_URL];
        controller.messageComposeDelegate = self;
        [self.viewController presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:STShareTitle];//修改短信界面标题
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end