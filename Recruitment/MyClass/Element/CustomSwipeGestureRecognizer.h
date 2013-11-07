//
//  CustomSwipeGestureRecognizer.h
//  Recruitment
//
//  Created by M J on 13-10-31.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSwipeGestureRecognizer : UISwipeGestureRecognizer

@property (assign, nonatomic) NSInteger             tag;
@property (strong, nonatomic) NSIndexPath           *indexPath;

@end
