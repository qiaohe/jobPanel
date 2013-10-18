//
//  RecommendViewController.h
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

@class CustomButton;

#define                 RecommendViewCellHeight                 75.0f

@interface RecommendViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView               *progressBar;
@property (strong, nonatomic) UIImageView               *selectStatus;

- (void)setBackgroundImage:(UIImage*)image;

@end

@interface RecommendViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray        *dataSource;
@property (strong, nonatomic) UITableView           *theTableView;
@property (strong, nonatomic) UIScrollView          *scrollView;

@end
