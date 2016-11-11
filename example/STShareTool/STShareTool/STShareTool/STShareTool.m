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

#define STSHARE_TITLE shareContent[STShareTitleKey] == nil ? @"1" : shareContent[STShareTitleKey]
#define STSHARE_IMAGE shareContent[STShareImageKey] == nil ? @"1" : shareContent[STShareImageKey]
#define STSHARE_CONTENT shareContent[STShareContentKey] == nil ? @"1" : shareContent[STShareContentKey]
#define STSHARE_URL shareContent[STShareURLKey] == nil ? @"1" : shareContent[STShareURLKey]
#define STSHARE_CONCAT_METHOD_NAME(name) [NSString stringWithFormat:@"shareTo%@:", name]

@interface STShareTool () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *viewController;

@end

@implementation STShareTool

#pragma mark - Initialize

+ (void)initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UMSocialData setAppKey:STShareUMAppKey];
        // 设置微信
        [UMSocialWechatHandler setWXAppId:STShareWechatAppId appSecret:STShareWechatAppSecret url:STShareURL];
        // 设置QQ
        [UMSocialQQHandler setQQWithAppId:STShareQQAppId appKey:STShareQQAppKey url:STShareURL];
        [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:STShareWeiboAppKey secret:STShareWeiboAppSecret RedirectURL:STShareWeiboCallbackURL];
        // 其他配置（因为没有用友盟默认的，所以该设置无效）
        [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    });
}

+ (instancetype)toolWithViewController:(UIViewController *)viewController {
    STShareTool *tool = [STShareTool new];
    tool.viewController = viewController;
    return tool;
}

#pragma mark - Public Methods

+ (BOOL)canSendMail {
    return [MFMailComposeViewController canSendMail];
}

#pragma mark - Share Implementation

- (void)shareToQQ:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.qqData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.qqData.title = STSHARE_TITLE;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            if (self.success) {
                self.success();
            }
        } else {
            if (self.failure) {
                self.failure();
            }
        }
    }];
}

- (void)shareToQZone:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.qzoneData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.qzoneData.title = STSHARE_TITLE;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            if (self.success) {
                self.success();
            }
        } else {
            if (self.failure) {
                self.failure();
            }
        }
    }];
}

- (void)shareToWeChatSession:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatSessionData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = STSHARE_TITLE;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            if (self.success) {
                self.success();
            }
        } else {
            if (self.failure) {
                self.failure();
            }
        }
    }];
}

- (void)shareToWeChatTimeline:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = STSHARE_URL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = STSHARE_TITLE;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil presentedController:self.viewController completion:^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            if (self.success) {
                self.success();
            }
        } else {
            if (self.failure) {
                self.failure();
            }
        }
    }];
}

- (void)shareToWeibo:(NSDictionary *)shareContent {
    [UMSocialData defaultData].extConfig.sinaData.snsName = @"ddd";
    [UMSocialData defaultData].extConfig.sinaData.shareText = STSHARE_CONTENT;
    [UMSocialData defaultData].extConfig.sinaData.shareImage = STSHARE_IMAGE;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina] content:STSHARE_CONTENT image:STSHARE_IMAGE location:nil urlResource:nil completion:^(UMSocialResponseEntity *response) {
        NSLog(@"%d", response.responseCode);
    }];
//    [[UMSocialControllerService defaultControllerService] setShareText:STSHARE_CONTENT shareImage:STSHARE_IMAGE socialUIDelegate:nil];
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self.viewController, [UMSocialControllerService defaultControllerService], YES);
}

- (void)shareToMessage:(NSDictionary *)shareContent {
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = [NSString stringWithFormat:@"%@ %@", STSHARE_CONTENT, STSHARE_URL];
        controller.messageComposeDelegate = self;
        [self.viewController presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:STSHARE_TITLE];
    }
}

- (void)shareToMail:(NSDictionary *)shareContent {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
        [mailCompose setMailComposeDelegate:self];
        [mailCompose setSubject:STSHARE_TITLE];
        [mailCompose setMessageBody:[NSString stringWithFormat:@"%@ %@", STSHARE_CONTENT, STSHARE_URL] isHTML:NO];
        [self.viewController presentViewController:mailCompose animated:YES completion:nil];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (result == MFMailComposeResultSent) {
        if (self.success) {
            self.success();
        }
    } else {
        if (self.failure) {
            self.failure();
        }
    }
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
