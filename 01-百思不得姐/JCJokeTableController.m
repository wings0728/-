//
//  JCJokeTableController.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCJokeTableController.h"
#import "JCEssenceController.h"
#import "JCJokeModel.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "JCJokeCell.h"
@interface JCJokeTableController ()

@property (strong, nonatomic) NSMutableArray *data;
@property (assign, nonatomic) NSInteger cellHeight;
@property (assign, nonatomic) NSInteger page;
@property (copy, nonatomic) NSString *maxtime;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) AFHTTPSessionManager *manager;

@end

@implementation JCJokeTableController

static NSString *const ID = @"CellJoke";
//直接转模型
-(void)setData:(NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        JCJokeModel *model = [JCJokeModel jokeModelWithDict:dict];
        [dataArr addObject:model];
    }
    [_data addObjectsFromArray:dataArr];
}

-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JCJokeCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //发送请求，加载数据
    [self setupRefresh];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
}
/**
 *  发送请求，加载数据
 */
-(void)newData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(29);
    self.params = params;
//    params[@"page"] = @(1);
    [self.manager GET:JCURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        [self.data removeAllObjects];
        self.data = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *  发送请求，加载数据
 */
-(void)moreData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(29);
    params[@"page"] = @(self.page++);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [self.manager GET:JCURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) {
            return ;
        }
        self.data = responseObject[@"list"];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.page--;
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JCJokeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[JCJokeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }    
    cell.model = self.data[indexPath.row];
    
    self.cellHeight = [cell setCellHeight];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}
@end
