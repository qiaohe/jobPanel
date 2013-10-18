//
//  ResumeTraceViewController.h
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface ResumeTraceViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UITabBarDelegate>

@property (strong, nonatomic) UITabBar              *theTabBar;
@property (strong, nonatomic) UITableView           *theTableView;
@property (strong, nonatomic) NSMutableArray        *dataSource;

@end
