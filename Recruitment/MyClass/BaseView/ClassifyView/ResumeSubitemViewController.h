//
//  ResumeSubitemViewController.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

#define             ResumeSubitemViewCellHeight                 60.0f

typedef NS_OPTIONS(NSInteger, ResumeSubitemInitType){
    ResumeSubitemWorkExperience,
    ResumeSubitemEduExperience
};

@interface ResumeSubitemViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSMutableArray            *dataSource;

@property (assign, nonatomic) ResumeSubitemInitType     type;

- (id)initWithType:(ResumeSubitemInitType)initType;

@end


@interface ResumeSubitemCell : UITableViewCell

@property (strong, nonatomic) UILabel               *titleLabel;
@property (strong, nonatomic) UILabel               *detailLabel;
@property (strong, nonatomic) UIImageView           *leftImageView;
@property (strong, nonatomic) UIImageView           *rightImageView;

- (void)setLeftImage:(UIImage*)image;
- (void)setRightImage:(UIImage*)image;
- (void)setBackGroundImage:(UIImage*)image;

@end