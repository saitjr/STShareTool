//
//  STQQActivity.h
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const STSharePlatformQQ = @"QQ";
static NSString * const STSharePlatformQZone = @"QZone";
static NSString * const STSharePlatformWechatSession = @"WeChatSession";
static NSString * const STSharePlatformWechatTimeline = @"WeChatTimeline";
static NSString * const STSharePlatformWeibo = @"Weibo";

@interface STBaseActivity : UIActivity

@property (copy, nonatomic) void(^action)(NSString *platform);

@end

@interface STQQActivity : STBaseActivity

@end

@interface STQZoneActivity : STBaseActivity

@end

@interface STWeChatSessionActivity : STBaseActivity

@end

@interface STWeChatTimelineActivity : STBaseActivity

@end

@interface STWeiboActivity : STBaseActivity

@end