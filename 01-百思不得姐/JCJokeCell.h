//
//  JCJokeCell.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCJokeModel;


@interface JCJokeCell : UITableViewCell

@property (strong, nonatomic) JCJokeModel *model;
-(CGFloat)setCellHeight;


@end
