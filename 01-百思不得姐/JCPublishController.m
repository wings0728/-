//
//  JCPublishController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/28.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCPublishController.h"

@interface JCPublishController ()
- (IBAction)dismissButton;

@end

@implementation JCPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
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

- (IBAction)dismissButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
