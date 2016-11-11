//
//  ViewController.m
//  STShareTool
//
//  Created by TangJR on 2/17/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "ViewController.h"
#import "STShareTool.h"

@interface ViewController ()

@property (strong, nonatomic) STShareTool *shareTool;
@property (nonatomic, copy) NSDictionary *shareContent;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

- (IBAction)shareButtonTapped:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)shareButtonTapped:(UIButton *)sender {
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [self.shareTool shareToQQ:self.shareContent];
            break;
        case 1:
            [self.shareTool shareToQZone:self.shareContent];
            break;
        case 2:
            [self.shareTool shareToWeChatSession:self.shareContent];
            break;
        case 3:
            [self.shareTool shareToWeChatTimeline:self.shareContent];
            break;
        case 4:
            [self.shareTool shareToWeibo:self.shareContent];
            break;
        case 5:
            [self.shareTool shareToMail:self.shareContent];
            break;
        default:
            break;
    }
}

- (STShareTool *)shareTool {
    if (!_shareTool) {
        _shareTool = [STShareTool toolWithViewController:self];
    }
    return _shareTool;
}

- (NSDictionary *)shareContent {
    if (!_shareContent) {
        _shareContent = @{STShareTitleKey : @"SwiftGG",
                          STShareContentKey : @"SwiftGG 最帅",
                          STShareImageKey : [UIImage imageNamed:@"60"],
                          STShareURLKey : @"http://www.swift.gg"};
    }
    return _shareContent;
}

@end
