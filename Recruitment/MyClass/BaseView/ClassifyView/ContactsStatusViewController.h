//
//  ContactsStatusViewController.h
//  Recruitment
//
//  Created by M J on 13-10-15.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

#define             ContactsStatusCellHeight                75.0f

@interface ContactsStatusViewController : BaseUIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITextField               *searchBar;
@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSMutableArray            *dataSource;

@end

@interface ContactsStatusCell : UITableViewCell

@property (strong, nonatomic) UIImageView               *leftImage;
@property (strong, nonatomic) UILabel                   *titleLabel;
@property (strong, nonatomic) UILabel                   *detailLabel;
@property (strong, nonatomic) UILabel                   *locationLabel;
@property (strong, nonatomic) UIImageView               *rightImage;

- (void)setBackGroundImage:(UIImage*)image;

@end


