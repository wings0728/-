//
//  UIBarButtonItem+JC.h
//  01-百思不得姐
//
//  Created by Jenny&Jason on 16/2/17.
//  Copyright © 2016年 Jenny&Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JC)

+(instancetype)itemWithImage:(NSString *)image selectedImage:(NSString *)selectedImage target:(id)target action:(SEL)action;

@end
