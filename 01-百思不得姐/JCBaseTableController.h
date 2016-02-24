//
//  JCBaseTableController.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/20.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JCTableViewTypeAll = 1,
    JCTableViewTypePicture = 10,
    JCTableViewTypeWord = 29,
    JCTableViewTypeVoice = 31,
    JCTableViewTypeVideo = 41

} JCTableViewType;


@interface JCBaseTableController : UITableViewController

@property (assign, nonatomic) JCTableViewType type;

@end
