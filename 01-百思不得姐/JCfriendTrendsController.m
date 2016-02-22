//
//  JCfriendTrendsController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCfriendTrendsController.h"
#import "JCfriendsRecommentController.h"

@interface JCfriendTrendsController ()

@end

@implementation JCfriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" selectedImage:@"friendsRecommentIcon-click" target:self action:@selector(leftClick)];
}

-(void)leftClick{
    JCfriendsRecommentController *vc = [[JCfriendsRecommentController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
