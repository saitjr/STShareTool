//
//  STShareTool.h
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const STShareImageKey = @"STShareImageKey"; ///< 分享图片的 key （传入的是字典，所以这个作为key）（image 是 UIImage）
static NSString * const STShareContentKey = @"STShareContentKey"; ///< 分享内容的 key （content 是 NSString 的）
static NSString * const STShareURLKey = @"STShareURLKey"; ///< 分享 url 的 key （url 是 NSString 的）

static NSString * const STShareTitle = @"SwiftGG"; ///< 分享的标题
static NSString * const STShareURL = @"http://www.swift.gg"; ///< 分享的url，实际没用到，写在这占位

static NSString * const STShareQQAppId = @"1105183300";
static NSString * const STShareQQAppKey = @"7xG5PEYoHCx41Es6";

static NSString * const STShareWeiboAppKey = @"2862032238";
static NSString * const STShareWeiboAppSecret = @"2a61af7b29c8562fe440226364cea0b6";
static NSString * const STShareWeiboCallbackURL = @"http://sns.whalecloud.com/sina2/callback"; ///< 微博回调的 url，就是微博申请高级信息里面那个

static NSString * const STShareWechatAppId = @"wx133f6244ca123bb6";
static NSString * const STShareWechatAppSecret = @"ce54fbb731edd5f9f50b12ca8d864405";

static NSString * const STShareUMAppKey = @"507fcab25270157b37000010";

@interface STShareTool : NSObject

+ (instancetype)toolWithViewController:(UIViewController *)viewController;

+ (BOOL)canSendMail;

- (void)shareToQQ:(NSDictionary *)shareContent;
- (void)shareToQZone:(NSDictionary *)shareContent;
- (void)shareToWeChatSession:(NSDictionary *)shareContent;
- (void)shareToWeChatTimeline:(NSDictionary *)shareContent;
- (void)shareToWeibo:(NSDictionary *)shareContent;
- (void)shareToMail:(NSDictionary *)shareContent;

@end