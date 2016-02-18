//
//  STShareTool.h
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STSHARE_ROOT_VC ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController

static NSString * const STShareImageKey = @"STShareImageKey"; ///< 分享图片的 key （传入的是字典，所以这个作为key）（image 是 UIImage）
static NSString * const STShareContentKey = @"STShareContentKey"; ///< 分享内容的 key （content 是 NSString 的）
static NSString * const STShareURLKey = @"STShareURLKey"; ///< 分享 url 的 key （url 是 NSString 的）

static NSString * const STShareTitle = @"SwiftGG"; ///< 分享的标题
static NSString * const STShareURL = @"http://www.swift.gg"; ///< 分享的url，实际没用到，写在这占位

static NSString * const STShareQQAppId = @"1105071901";
static NSString * const STShareQQAppKey = @"F2eaA3YcbFePJdOp";

static NSString * const STShareWeiboAppKey = @"1544042551";
static NSString * const STShareWeiboAppSecret = @"2d9d75cac265dece17d97e531090599e";
static NSString * const STShareWeiboCallbackURL = @"http://sns.whalecloud.com/sina2/callback"; ///< 微博回调的 url，就是微博申请高级信息里面那个

static NSString * const STShareWechatAppId = @"wxa0e5907c3dad46c8";
static NSString * const STShareWechatAppSecret = @"3e9e5722930891539c1e3e2c8e72da9b";

static NSString * const STShareUMAppKey = @"56a6e3f0e0f55a772f000ff4";

@interface STShareTool : NSObject

+ (void)shareToQQ:(NSDictionary *)shareContent;
+ (void)shareToQZone:(NSDictionary *)shareContent;
+ (void)shareToWeChatSession:(NSDictionary *)shareContent;
+ (void)shareToWeChatTimeline:(NSDictionary *)shareContent;
+ (void)shareToWeibo:(NSDictionary *)shareContent;

+ (void)presentShareViewController:(NSDictionary *)shareContent;

@end