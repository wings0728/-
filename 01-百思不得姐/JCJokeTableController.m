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

@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) NSInteger cellHeight;
@property (assign, nonatomic) NSInteger page;
@property (copy, nonatomic) NSString *maxtime;


@end

@implementation JCJokeTableController

static NSString *const ID = @"CellJoke";
//直接转模型
-(void)setData:(NSArray *)data{
//    NSArray *dataArr = data;
    NSMutableArray *dataArr = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        JCJokeModel *model = [JCJokeModel jokeModelWithDict:dict];
        [dataArr addObject:model];
    }
    _data = [dataArr copy];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JCJokeCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //发送请求，加载数据
//    [self moreData];
    [self setupRefresh];
}

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(newData)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreData)];
}
/**
 *  发送请求，加载数据
 */
-(void)newData{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(29);
//    params[@"page"] = @(self.page++);
    [[AFHTTPSessionManager manager] GET:JCURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.data = responseObject[@"list"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    [[AFHTTPSessionManager manager] GET:JCURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.data = responseObject[@"list"];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
    return self.cellHeight;
}
@end
