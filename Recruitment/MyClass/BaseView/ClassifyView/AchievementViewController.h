//
//  AchievementViewController.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

#define         AchievementViewCellHeight               100.0f

@interface AchievementViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSMutableArray            *dataSource;

@end

@interface AchievementViewCell : UITableViewCell

@property (strong, nonatomic) UILabel                   *titleLabel;
@property (strong, nonatomic) UITextView                *detailLabel;

- (void)setLeftImage:(UIImage*)image;

@end