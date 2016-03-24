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
#import "STShareActivities.h"
#import "AppDelegate.h"

#define STSHARE_IMAGE shareContent[STShareImageKey]
#define STSHARE_CONTENT [NSString stringWithFormat:@"%@ %@", shareContent[STShareContentKey], STSHARE_URL]
#define STSHARE_URL shareContent[STShareURLKey]
#define STSHARE_CONCAT_METHOD_NAME(name) [NSString stringWithFormat:@"shareTo%@:", name]

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
        // 设置微博
        [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:STShareWeiboAppKey secret:STShareWeiboAppSecret RedirectURL:STShareWeiboCallbackURL];
        // 其他配置（因为没有用友盟默认的，所以该设置无效）
        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    });
}

+ (void)presentShareViewController:(NSDictionary *)shareContent sender:(UIView *)sender {
    
    NSArray *activityClasses = @[[STQQActivity class], [STQZoneActivity class], [STWeChatSessionActivity class], [STWeChatTimelineActivity class], [STWeiboActivity class]];
    NSMutableArray *activities = [NSMutableArray new];
    
    for (Class class in activityClasses) {
        STBaseActivity *activity = [class new];
        activity.action = ^(NSString *platform) {
            NSString *methodName = STSHARE_CONCAT_METHOD_NAME(platform);
            SEL methodSEL = NSSelectorFromString(methodName);
            [STShareTool performSelector:methodSEL withObject:shareContent withObject:nil];
        };
        [activities addObject:activity];
    }
    NSArray* itemsToShare = @[STSHARE_CONTENT, [NSURL URLWithString:STSHARE_URL], STSHARE_IMAGE];
    UIActivityViewController* activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:activities];
    
    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypeAirDrop, UIActivityTypeOpenInIBooks];
    
    if ( [activityViewController respondsToSelector:@selector(popoverPresentationController)] ) {
        activityViewController.popoverPresentationController.sourceView = sender.superview;
        activityViewController.popoverPresentationController.sourceRect = sender.frame;
    }
    
    [STSHARE_ROOT_VC presentViewController:activityViewController animated:YES completion:NULL];
}

+ (void)shareToQQ:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.qqData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.qqData.title = STShareTitle;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:STSHARE_ROOT_VC completion:nil];
}

+ (void)shareToQZone:(NSDictionary *)shareContent {
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:STSHARE_ROOT_VC completion:nil];
}

+ (void)shareToWeChatSession:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatSessionData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = STShareTitle;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:STSHARE_ROOT_VC completion:nil];
}

+ (void)shareToWeChatTimeline:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = STShareTitle;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:STSHARE_ROOT_VC completion:nil];
}

+ (void)shareToWeibo:(NSDictionary *)shareContent {
    [[UMSocialControllerService defaultControllerService] setShareText:STSHARE_CONTENT shareImage:STSHARE_IMAGE socialUIDelegate:nil];
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(STSHARE_ROOT_VC ,[UMSocialControllerService defaultControllerService], YES);
}

@end