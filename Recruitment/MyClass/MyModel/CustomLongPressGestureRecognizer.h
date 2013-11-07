//
//  CustomLongPressGestureRecognizer.h
//  Recruitment
//
//  Created by M J on 13-10-27.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomButton;

@interface CustomLongPressGestureRecognizer : UILongPressGestureRecognizer

@property (strong, nonatomic) NSIndexPath               *indexPath;
@property (assign, nonatomic) CustomButton              *button;

@end
