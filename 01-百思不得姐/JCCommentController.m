//
//  JCCommentController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/29.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCCommentController.h"
#import "JCJokeModel.h"
#import "JCJokeCell.h"

@interface JCCommentController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commentTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBottom;

@end

static NSString * const ID = @"CommentCell";

@implementation JCCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self setupController];
    //设置tableView
    [self setupTableView];
}

-(void)setupController{
    //设置title
    self.title = @"评论";
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidChang:) name:UIKeyboardDidChangeFrameNotification object:nil];
}
/**
 *  设置tableView
 */
-(void)setupTableView{
    self.commentTableView.dataSource = self;
    self.commentTableView.delegate = self;
    [self setupHeadView];
}
/**
 *  设置tableView的header
 */
-(void)setupHeadView{
    UIView *header = [[UIView alloc] init];
    
    JCJokeCell *cell = [JCJokeCell cell];
    cell.model = self.model;
    cell.size = CGSizeMake(JCScreenWidth, self.model.cellHeight);
    
    header.height = self.model.cellHeight + JCCellMarginY;
    [header addSubview:cell];
    self.commentTableView.tableHeaderView = header;
}

/**
 *  根据通知事件自动改变输入栏Y值
 */
-(void)keyBoardDidChang:(NSNotification *)note{
   CGRect endFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.inputBottom.constant = JCScreenHeight - endFrame.origin.y;
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画 及时刷新
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
/**
 *  移除通知器
 */
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - tableView数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"热门评论";
    if (section == 1) {
        header = @"评论";
    }
    return header;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 今天先写到这里了！
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - tableView代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
