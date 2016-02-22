//
//  JCJokeCell.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JCJokeModel;

//@protocol JCJokeCellDelegate <NSObject>
//
//@optional
//-(CGFloat)jokeCellSetCellHeight;
//
//@end

@interface JCJokeCell : UITableViewCell

@property (strong, nonatomic) JCJokeModel *model;
-(CGFloat)setCellHeight;
//@property (weak, nonatomic) id<JCJokeCellDelegate> delegate;


@end
