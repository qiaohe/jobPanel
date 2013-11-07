//
//  HomeViewController.h
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

#define             HomeViewCellHeight              50.0f

@interface HomeViewController : BaseUIViewController<UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView               *bottomLeftContentView;
@property (strong, nonatomic) UITableView               *bottomRightContentView;

@property (strong, nonatomic) NSMutableArray            *recommendDataSource;
@property (strong, nonatomic) NSMutableArray            *contactsStatusDataSource;
@property (strong, nonatomic) NSMutableArray            *trendNotificationDataSource;

@end
