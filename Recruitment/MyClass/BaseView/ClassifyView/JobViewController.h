//
//  JobViewController.h
//  Recruitment
//
//  Created by M J on 13-11-6.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface JobViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) UITextField               *searchBar;
@property (strong, nonatomic) NSMutableArray            *dataSource;

@end
