//
//  ContactsStatusViewController.h
//  Recruitment
//
//  Created by M J on 13-10-15.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

#define             ContactsStatusCellHeight                75.0f
#define             ContactsUnfoldItemHeight                25.0f
#define             ContactsUnfoldCellHeight(object)        (((75.0f + 30.0f) + [object.trends count] * ContactsUnfoldItemHeight) + 10)

@class Contacts;

@interface ContactsStatusViewController : BaseUIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITextField               *searchBar;
@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSMutableArray            *dataSource;

@end

@interface ContactsStatusCell : UITableViewCell<BaseContentViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIImageView               *backGroundImageView;

@property (strong, nonatomic) UIImageView               *leftImage;
@property (strong, nonatomic) UILabel                   *titleLabel;
@property (strong, nonatomic) UILabel                   *detailLabel;
@property (strong, nonatomic) UILabel                   *locationLabel;
@property (strong, nonatomic) UIImageView               *rightImage;

@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSArray                   *dataSource;

- (void)setBackGroundImage:(UIImage*)image;
- (void)subjoinviewShow:(Contacts *)param;

@end


