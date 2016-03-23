//
//  STQQActivity.m
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "STShareActivities.h"
#import "UMSocial.h"
#import "AppDelegate.h"

@interface STBaseActivity ()

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSURL *url;
@property (strong, nonatomic) UIImage *image;

@end

@implementation STBaseActivity

+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (NSString *)activityType {
    return NSStringFromClass([self class]);
}

- (UIImage *)activityImage {
    return [UIImage new];
}

- (NSString *)activityTitle {
    return @"QQ好友";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    if (activityItems.count > 0) {
        return YES;
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSString class]]) {
            self.content = item;
            continue;
        }
        if ([item isKindOfClass:[NSURL class]]) {
            self.url = item;
            continue;
        }
        if ([item isKindOfClass:[UIImage class]]) {
            self.image = item;
            continue;
        }
    }
}

@end

@implementation STQQActivity

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"STShareResources.bundle/sns_icon_01.jpg"];
}

- (NSString *)activityTitle {
    return @"QQ好友";
}

- (void)performActivity {
    if (self.action) {
        self.action(STSharePlatformQQ);
    }
}

@end

@implementation STQZoneActivity

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"STShareResources.bundle/sns_icon_02.jpg"];
}

- (NSString *)activityTitle {
    return @"QQ空间";
}

- (void)performActivity {
    if (self.action) {
        self.action(STSharePlatformQZone);
    }
}

@end

@implementation STWeChatSessionActivity

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"STShareResources.bundle/sns_icon_03.jpg"];
}

- (NSString *)activityTitle {
    return @"微信朋友";
}

- (void)performActivity {
    if (self.action) {
        self.action(STSharePlatformWechatSession);
    }
}

@end

@implementation STWeChatTimelineActivity

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"STShareResources.bundle/sns_icon_04.jpg"];
}

- (NSString *)activityTitle {
    return @"朋友圈";
}

- (void)performActivity {
    if (self.action) {
        self.action(STSharePlatformWechatTimeline);
    }
}

@end

@interface STWeiboActivity () <UMSocialUIDelegate>

@end

@implementation STWeiboActivity

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"STShareResources.bundle/sns_icon_05.jpg"];
}

- (NSString *)activityTitle {
    return @"新浪微博";
}

- (void)performActivity {
    if (self.action) {
        self.action(STSharePlatformWeibo);
    }
}

@end