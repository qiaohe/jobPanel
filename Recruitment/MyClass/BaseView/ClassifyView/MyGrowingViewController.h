//
//  MyGrowingViewController.h
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@interface MyGrowingViewCell : UITableViewCell

@property (strong, nonatomic) UIView                *cellItem1;
@property (strong, nonatomic) UIView                *cellItem2;

- (void)createSubviewWithParams:(NSArray*)params indexPath:(NSIndexPath*)indexPath;

@end

#define         MyGrowingHeaderViewHeight               35.0f
#define         MyGrowingCellHeight                     appFrame.size.width/2

@interface MyGrowingViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UITextField           *searchBar;
@property (strong, nonatomic) UITableView           *theTableView;
@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic) NSMutableArray        *subDataSource;

@end
