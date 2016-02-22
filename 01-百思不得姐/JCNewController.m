//
//  JCNewController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCNewController.h"

@interface JCNewController ()

@end

@implementation JCNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏titleView
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    titleImage.bounds = (CGRect){CGPointZero, titleImage.image.size};
    self.navigationItem.titleView = titleImage;
    //利用分类方法快速创建leftItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick" target:self action:@selector(leftClick)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
