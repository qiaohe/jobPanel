//
//  MyResumeViewController.h
//  Recruitment
//
//  Created by M J on 13-10-17.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "ImagePickerViewController.h"

@class CustomButton;

#define             MyResumeCellHeight              85.0f

typedef NS_OPTIONS(NSInteger, MyResumeInitType){
    MyResumeEdit,
    MyResumeDeliver
};

@interface MyResumeViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImagePickerViewControllerDelegate>{
    ImagePickerViewController *imagePicker;
}

@property (strong, nonatomic) CustomButton              *selectButton;
@property (strong, nonatomic) UITableView               *theTableView;
@property (strong, nonatomic) NSMutableArray            *dataSource;

- (id)initWithType:(MyResumeInitType)type;

@end

@interface MyResumeViewCell : UITableViewCell<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView               *backGroundImage;
@property (strong, nonatomic) CustomButton              *leftButton;
@property (strong, nonatomic) UITextField               *titleLabel;
@property (strong, nonatomic) UILabel                   *detailLabel;
@property (strong, nonatomic) UIImageView               *locationImage;
@property (strong, nonatomic) UILabel                   *locationLabel;
@property (strong, nonatomic) UIImageView               *timeImage;
@property (strong, nonatomic) UILabel                   *timeLabel;
@property (strong, nonatomic) CustomButton              *rightButton;

@end
