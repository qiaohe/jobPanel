//
//  MyGrowingViewController.h
//  Recruitment
//
//  Created by M J on 13-10-14.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "GrowingDetailViewController.h"


@class CustomButton;

@interface MyGrowingViewCell : UITableViewCell

@property (strong, nonatomic) CustomButton          *cellItem1;
@property (strong, nonatomic) CustomButton          *cellItem2;

- (void)createSubviewWithParams:(NSArray*)params indexPath:(NSIndexPath*)indexPath;

@end

#define         MyGrowingHeaderViewHeight               35.0f
#define         MyGrowingCellHeight                     appFrame.size.width/2

@interface MyGrowingViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,GrowingDetailDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UITextField           *searchBar;
@property (strong, nonatomic) UITableView           *theTableView;
@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic) NSMutableDictionary   *subDataSource;

@end
