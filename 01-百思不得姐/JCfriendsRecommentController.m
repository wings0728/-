//
//  JCfriendsRecommentController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCfriendsRecommentController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "JCFriendLeftCell.h"
#import "JCFiendLeftModel.h"
#import "JCFriendRightModel.h"
#import "JCFriendRightCell.h"

@interface JCfriendsRecommentController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) NSArray *leftModelArr;
@property (strong, nonatomic) JCFiendLeftModel *model;
//@property (strong, nonatomic) NSArray *rightModelArr;

@end

@implementation JCfriendsRecommentController

static NSString * const LID = @"leftCell";
static NSString * const RID = @"rightCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化左右tableView
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    //网络请求左边数据
    [self loadLeftTableView];
}
/**
 *  初始化左右tableView
 */
-(void)setupTableView{
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.rightTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.leftTableView.contentInset = self.rightTableView.contentInset;
    self.leftTableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = JCGlobalColor;
    self.navigationItem.title = @"推荐关注";
    //注册cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JCFriendLeftCell class]) bundle:nil] forCellReuseIdentifier:LID];
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JCFriendRightCell class]) bundle:nil] forCellReuseIdentifier:RID];
}
/**
 *  添加刷新控件
 */
-(void)setupRefresh{
    
    self.rightTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefrsh)];
    self.rightTableView.mj_footer.hidden = YES;
//    [self headRefresh];
}
/**
 *  头部刷新
 */
-(void)headRefresh{
    //把现在左边选中那一行的行号所对应数组内的模型拿出来
    JCFiendLeftModel *model = self.leftModelArr[self.leftTableView.indexPathForSelectedRow.row];
    self.model = model;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"list";
    parames[@"c"] = @"subscribe";
    parames[@"category_id"] = @(model.id);
    
    [[AFHTTPSessionManager manager] GET:JCURL parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        [SVProgressHUD show];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.model.rightData = [JCFriendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.model.next_page = [responseObject[@"next_page"] integerValue];
        [self.rightTableView reloadData];
        [self.rightTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"姐姐加载失败了～"];
    }];
}
/**
 *  尾部刷新
 */
-(void)footRefrsh{
    
    JCFiendLeftModel *model = self.leftModelArr[self.leftTableView.indexPathForSelectedRow.row];
    self.model = model;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    if (self.model.total_page >= self.model.next_page) {//如果模型内的总页数大于等于下一个页数，就加载
        parames[@"a"] = @"list";
        parames[@"c"] = @"subscribe";
        parames[@"category_id"] = @(model.id);
        parames[@"page"] = @(self.model.next_page);
        [[AFHTTPSessionManager manager] GET:JCURL parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
            [SVProgressHUD show];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            NSMutableArray *allData = [NSMutableArray arrayWithArray:self.model.rightData];
            NSArray *data = [JCFriendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [allData addObjectsFromArray:data];
            self.model.rightData = [allData copy];
            self.model.next_page = [responseObject[@"next_page"] integerValue];
            [self.rightTableView reloadData];
            [self.rightTableView.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"姐姐加载失败了～"];
        }];
    }else{//如果模型内总页数小于下一个页数，不加载，直接结束刷新
       [self.rightTableView.mj_footer endRefreshing];
    }
    
}
/**
 * 网络请求左边数据
 */
-(void)loadLeftTableView{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"a"] = @"category";
    parames[@"c"] = @"subscribe";
    [SVProgressHUD show];
    [[AFHTTPSessionManager manager] GET:JCURL parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.leftModelArr = [JCFiendLeftModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.leftTableView reloadData];
        //选中第一行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.rightTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"姐姐加载失败了～"];
    }];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.leftModelArr.count;
    }else{
        return self.model.rightData.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {//左边的cell
        JCFriendLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:LID];
        cell.model = self.leftModelArr[indexPath.row];
        return cell;
    }else{//右边的cell
        JCFriendRightCell *cell = [tableView dequeueReusableCellWithIdentifier:RID];
        cell.model = self.model.rightData[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JCFiendLeftModel *model = self.leftModelArr[indexPath.row];
    self.model = model;
    if (model.rightData) {//如果模型里有数据，那就调去模型中数据
        [self.rightTableView reloadData];
    }else{//如果没有就去网络上加载
        [self.rightTableView reloadData];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"a"] = @"list";
        parames[@"c"] = @"subscribe";
        parames[@"category_id"] = @(model.id);
        
        [[AFHTTPSessionManager manager] GET:JCURL parameters:parames progress:^(NSProgress * _Nonnull downloadProgress) {
            [SVProgressHUD show];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            self.model.rightData = [JCFriendRightModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            self.model.next_page = [responseObject[@"next_page"] integerValue];
            self.model.total_page = [responseObject[@"total_page"] integerValue];
            [self.rightTableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"姐姐加载失败了～"];
        }];
    }
    
}

-(void)dealloc{
    NSLog(@"JCfriendsRecommentController-dealloc");
}


@end
