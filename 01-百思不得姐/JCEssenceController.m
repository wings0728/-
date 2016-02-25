//
//  JCEssenceController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCEssenceController.h"
#import "JCBaseTableController.h"

@interface JCEssenceController()<UIScrollViewDelegate>

@property (weak, nonatomic) UIButton *selectedBtn;
@property (weak, nonatomic) UIView *bottomView;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *titleView;
@property (strong, nonatomic) NSMutableArray *tableViewArr;

@end


@implementation JCEssenceController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNav];
    
    [self setupChlidTableView];
    //设置顶部view
    [self setupTitleView];
    //初始化scrollView
    [self setupScrollView];
    //初始化第一个子控件位置
    [self setupChlidViewFrame];
}
/**
 *  初始化scrollView
 */
-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.x = 0;
    scrollView.y = 0;
    scrollView.width = self.view.width;
    scrollView.height = self.view.height;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
//    scrollView.opaque = YES;
//    NSLog(@"scrollView : %f",scrollView.opaque);
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    [self.view insertSubview:self.scrollView atIndex:0];
//    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 *  初始化子tableView
 */
-(void)setupChlidTableView{
    JCBaseTableController *word = [[JCBaseTableController alloc] init];
    word.title = @"段子";
    word.type = JCTableViewTypeWord;
    [self addChildViewController:word];
    
    JCBaseTableController *picture = [[JCBaseTableController alloc] init];
    picture.title = @"图片";
    picture.type = JCTableViewTypePicture;
    [self addChildViewController:picture];
    
    JCBaseTableController *all = [[JCBaseTableController alloc] init];
    all.title = @"全部";
    all.type = JCTableViewTypeAll;
    [self addChildViewController:all];
    
    JCBaseTableController *video = [[JCBaseTableController alloc] init];
    video.title = @"视频";
    video.type = JCTableViewTypeVideo;
    [self addChildViewController:video];
    
    JCBaseTableController *voice = [[JCBaseTableController alloc] init];
    voice.title = @"声音";
    voice.type = JCTableViewTypeVoice;
    [self addChildViewController:voice];
    
}
/**
 *  初始子控制器View的位置
 */
-(void)setupChlidViewFrame{
    //设置位置
        UITableViewController *vc = self.childViewControllers[0];
        vc.tableView.contentInset = UIEdgeInsetsMake(100, 0, 49, 0);
        vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
        vc.view.x = 0;
        vc.view.y = 0;
        vc.view.height = self.view.height;
        vc.view.width = self.view.width;
        [self.scrollView addSubview:vc.view];
}
/**
 *  初始化顶部view
 */
-(void)setupTitleView{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 60, self.view.frame.size.width, 44);
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //初始化5个按钮
    CGFloat btnY = 0;
    CGFloat btnW = titleView.frame.size.width / self.childViewControllers.count;
    CGFloat btnH = titleView.frame.size.height;
    CGFloat titleW = 0;
    //创建红色底View
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor redColor];
    CGFloat bvX = 0;
    CGFloat bvW = titleW;
    CGFloat bvH = 5;
    CGFloat bvY = btnH - bvH;
    bottomView.frame = CGRectMake(bvX, bvY, bvW, bvH);
    self.bottomView = bottomView;
    for (NSInteger index = 0; index < self.childViewControllers.count; index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnX = index * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:self.childViewControllers[index].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        //绑定tag
        btn.tag = index;
        //监听按钮点击
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //立即刷新控件的frame，不用等layoutSubview方法
        [btn layoutIfNeeded];
        titleW = btn.titleLabel.width;
        [titleView addSubview:btn];
        if (index == 0) {
            btn.enabled = NO;
            self.selectedBtn = btn;
            self.bottomView.width = btn.titleLabel.width;
            self.bottomView.centerX = btn.centerX;
            UITableViewController *tvc = self.childViewControllers[index];
            [tvc.tableView.mj_header beginRefreshing];
        }
    }
    
    [titleView addSubview:bottomView];
}
/**
 *  titleView按钮被点击
 */
-(void)titleBtnClick:(UIButton *)btn{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    //把scrollView移到对应位置
    self.scrollView.contentOffset = CGPointMake(btn.tag * self.view.width, 0);
    //显示对应位置的tableView
//    [self updateScrollView:btn.tag];
    //删除多余view
//    [self removeTableView];
    //底部View的动画
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bottomView.width = btn.titleLabel.width;
        self.bottomView.centerX = btn.centerX;
        
    }];
    // 滚动
//    CGPoint offset = self.scrollView.contentOffset;
//    offset.x = btn.tag * self.scrollView.width;
//    [self.scrollView setContentOffset:offset animated:YES];
//    NSLog(@"%f",offset.x);
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

/**
 *  初始化导航栏
 */
-(void)setupNav{
    //设置导航栏titleView
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    titleImage.bounds = (CGRect){CGPointZero, titleImage.image.size};
    self.navigationItem.titleView = titleImage;
    //利用分类方法快速创建leftItem
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick" target:self action:@selector(leftClick)];
}

/**
 *  监听左上按钮点击
 */
-(void)leftClick{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - scrollView代理
//开始拖拽scrollView时
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    //把此刻tableView左右两边的tableView加入scrollView
//    NSInteger index = scrollView.contentOffset.x / self.view.width;//为此时显示的table
//    //首先要判断此时的index是否大于0
//    if (index > 0) {
//        [self updateScrollView:(index - 1)];
//    }
//    //再判断index是否小于子控制器数量
//    if (index < self.childViewControllers.count - 1) {
//        [self updateScrollView:(index + 1)];
//    }
//
//    [self.scrollView layoutIfNeeded];
//}
//更新scroll子view
//-(void)updateScrollView:(NSInteger)index{
//    UITableViewController *vc = self.childViewControllers[index];
//    vc.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
//    vc.view.x = index * self.view.width;
//    vc.view.y = 0;
//    vc.view.height = self.view.height;
//    vc.view.width = self.view.width;
//    [self.scrollView addSubview:vc.view];
//}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //拿出索引
    NSInteger index = self.scrollView.contentOffset.x / self.view.width;
    //拿出自控制器
    UIViewController *vc = self.childViewControllers[index];
    //设置frame
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = self.view.height;
    vc.view.width = self.view.width;
    
    [scrollView addSubview:vc.view];
}

/**
 *  删除其余tableview
 */
//-(void)removeTableView{
//    for (UITableView *tv in self.scrollView.subviews) {
//        if (tv.frame.origin.x != self.scrollView.contentOffset.x) {
//            [tv removeFromSuperview];
//        }
//    }
//}
/**
 *  scrollView滑动放开时
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = self.scrollView.contentOffset.x / self.view.width;
    [self titleBtnClick:self.titleView.subviews[index]];
//    [self removeTableView];
//    [self.scrollView layoutIfNeeded];
}

@end
