//
//  JCFriendLeftCell.m
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/18.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import "JCFriendLeftCell.h"

@interface JCFriendLeftCell()

@property (weak, nonatomic) IBOutlet UIView *selectedView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;


@end

@implementation JCFriendLeftCell

- (void)awakeFromNib {
    // Initialization code
    self.selectedView.hidden = YES;
    self.backgroundColor = JCGlobalColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.selectedView.hidden = NO;
    self.selectedView.hidden = !selected;
    if (selected) {
        self.titleView.textColor = [UIColor redColor];
    }else{
        self.titleView.textColor = [UIColor blackColor];
    }
}

-(void)setModel:(JCFiendLeftModel *)model{
    _model = model;
    self.titleView.text = model.name;
}

@end
