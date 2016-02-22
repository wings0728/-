//
//  JCMainTabBar.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCMainTabBar.h"
#import "JCTabBar.h"
#import "JCMainNavigationController.h"
#import "JCEssenceController.h"
#import "JCNewController.h"
#import "JCfriendTrendsController.h"

@implementation JCMainTabBar

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupTabBar];
}
/**
 *  初始化tabBar
 */
-(void)setupTabBar{
    //利用appearance可以设置所有uitabBarItem属性
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attrNormal = [NSMutableDictionary dictionary];
    attrNormal[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    attrNormal[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    attrSel[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    attrSel[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    //利用KVO替换系统自带tabBar
    [self setValue:[[JCTabBar alloc]init] forKeyPath:@"tabBar"];
    [self creatTabBarItemWithVC:[[JCEssenceController alloc]init] title:@"精华" imageName:@"tabBar_essence_icon" selectImageName:@"tabBar_essence_click_icon"];
    
    [self creatTabBarItemWithVC:[[JCNewController alloc]init] title:@"新帖" imageName:@"tabBar_new_icon" selectImageName:@"tabBar_new_click_icon"];
    
    [self creatTabBarItemWithVC:[[JCfriendTrendsController alloc]init] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectImageName:@"tabBar_friendTrends_click_icon"];
    
    [self creatTabBarItemWithVC:[[UIViewController alloc]init] title:@"我" imageName:@"tabBar_me_icon" selectImageName:@"tabBar_me_click_icon"];
    //设置tabBar背景
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
}

/**
 *  创建一个tabBar子控制器
 *
 *  @param title           子控制器名称
 *  @param imageName       显示图标
 *  @param selectImageName 选中图标
 *
 *  @return 返回一个创建完毕的控制器
 */
-(void)creatTabBarItemWithVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    vc.view.backgroundColor = JCGlobalColor;
    JCMainNavigationController *nav = [[JCMainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
