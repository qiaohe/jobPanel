//
//  InformationViewController.h
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

typedef NS_OPTIONS(NSInteger, InformationType){
    InformationOpportunityPage,
    InformationIndustryPage,
    Informationcollect
};

@interface InformationViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) UITextField               *searchBar;
@property (strong, nonatomic) NSMutableArray            *dataSource;

- (id)initWithType:(InformationType)type;

@end
