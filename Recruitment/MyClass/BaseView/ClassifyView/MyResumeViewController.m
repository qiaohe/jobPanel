//
//  MyResumeViewController.m
//  Recruitment
//
//  Created by M J on 13-10-17.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyResumeViewController.h"
#import "MyResumeDetailViewController.h"
#import "CustomButton.h"
#import "MyResumeDetail.h"

@interface MyResumeViewController ()

@property (assign, nonatomic) MyResumeInitType          type;

@end

@implementation MyResumeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(MyResumeInitType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _dataSource = [NSMutableArray array];
        for (int i = 0; i<8; i++) {
            MyResumeDetail *detail = [[MyResumeDetail alloc]init];
            [detail setTitle:@"resume_selectimage_normal"];
            [_dataSource addObject:detail];
        }
        [self setSubviewFrame];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setSubviewFrame];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MyResumeCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifierString = [NSString stringWithFormat:@"%d",_type];
    MyResumeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierString];
    
    if (cell == nil) {
        cell = [[MyResumeViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
    }
    [cell.leftButton removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    [cell.leftButton addTarget:self action:@selector(pressUserPicture:) forControlEvents:UIControlEventTouchUpInside];
    [cell.rightButton addTarget:self action:@selector(pressRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [cell.leftButton setIndexPath:indexPath];
    [cell.rightButton setIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyResumeDetailViewController *resumeDetailView = [[MyResumeDetailViewController alloc]init];
    [self.navigationController pushViewController:resumeDetailView animated:YES];
}

- (void)pressUserPicture:(CustomButton*)sender
{
    _selectButton = sender;
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [imagePicker setAllowsEditing:NO];
        //imagePicker.allowsImageEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)pressRightButton:(CustomButton*)sender
{
    MyResumeViewCell *cell = (MyResumeViewCell*)[_theTableView cellForRowAtIndexPath:sender.indexPath];

    if (_type == MyResumeDeliver) {
        if (![cell.rightButton.titleLabel.text isEqualToString:@"已投递"]) {
            [[Model shareModel] showPromptText:@"投递成功" model:YES];
            [cell.rightButton setTitle:@"已投递" forState:UIControlStateNormal];
        }else{
            [[Model shareModel] showPromptText:@"您已投递过" model:YES];
        }
    }else if (_type == MyResumeEdit){
        [cell.titleLabel setEnabled:!cell.titleLabel.enabled];
        if (cell.titleLabel.enabled) {
            [cell.rightButton setTitle:@"确认" forState:UIControlStateNormal];
            if ([cell.titleLabel canBecomeFirstResponder]) {
                [cell.titleLabel becomeFirstResponder];
            }
        }else{
            [cell.rightButton setTitle:@"修改名称" forState:UIControlStateNormal];
        }
    }else {
        [[Model shareModel] showPromptText:@"错误！！！" model:YES];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_selectButton setImage:image forState:UIControlStateNormal];
    [_selectButton setImage:image forState:UIControlStateHighlighted];
    [_selectButton setImage:image forState:UIControlStateSelected];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"subview_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"我的简历"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    _theTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.contentView.frame.size.width, self.contentView.frame.size.height - controlYLength(self.topBar))];
    [_theTableView setDelegate:self];
    [_theTableView setDataSource:self];
    [_theTableView setBackgroundColor:color(clearColor)];
    [_theTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.contentView addSubview:_theTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@interface MyResumeViewCell ()

@property (assign, nonatomic) MyResumeInitType          cellType;

@end

@implementation MyResumeViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellType = [self.reuseIdentifier integerValue];
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _backGroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, appFrame.size.width - 10, MyResumeCellHeight - 10)];
    [_backGroundImage setImage:imageNameAndType(@"resume_item_backimage", @"png")];
    [_backGroundImage setUserInteractionEnabled:YES];
    [_backGroundImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:_backGroundImage];
    
    _leftButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setBackgroundImage:imageNameAndType(@"resume_selectimage_normal", @"png") forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:imageNameAndType(@"resume_selectimage_press", @"png") forState:UIControlStateHighlighted];
    [_leftButton setFrame:CGRectMake(_backGroundImage.frame.origin.x + 5, _backGroundImage.frame.origin.y + 5, _backGroundImage.frame.size.height - 10, _backGroundImage.frame.size.height - 10)];
    [_leftButton setBackgroundColor:color(clearColor)];
    _leftButton.layer.masksToBounds = YES;
    _leftButton.layer.cornerRadius = _leftButton.frame.size.width/2;
    [self.contentView addSubview:_leftButton];
    
    NSInteger random = arc4random()%3;
    
    _titleLabel =[[UITextField alloc]initWithFrame:CGRectMake(controlXLength(_leftButton) + 5, _leftButton.frame.origin.y, _backGroundImage.frame.size.width - controlXLength(_leftButton) * 2, _leftButton.frame.size.height/4)];
    [_titleLabel setBackgroundColor:color(clearColor)];
    [_titleLabel setEnabled:NO];
    [_titleLabel setDelegate:self];
    [_titleLabel setReturnKeyType:UIReturnKeyDone];
    [_titleLabel setFont:[UIFont systemFontOfSize:14]];
    switch (random) {
        case 0:
            [_titleLabel setText:@"UI设计师"];
            break;
        case 1:
            [_titleLabel setText:@"平面设计师"];
            break;
        case 2:
            [_titleLabel setText:@"前端开发工程师"];
            break;
        default:
            break;
    }
    [_backGroundImage addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_titleLabel) + 2.50f, _titleLabel.frame.size.width, _titleLabel.frame.size.height*2/3)];
    [_detailLabel setBackgroundColor:color(clearColor)];
    [_detailLabel setFont:[UIFont systemFontOfSize:10]];
    [_detailLabel setTextColor:color(darkGrayColor)];
    switch (random) {
        case 0:
            [_detailLabel setText:@"郑爽"];
            break;
        case 1:
            [_detailLabel setText:@"赵军"];
            break;
        case 2:
            [_detailLabel setText:@"李杰"];
            break;
        default:
            break;
    }
    [_backGroundImage addSubview:_detailLabel];
    
    _locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x, controlYLength(_detailLabel) + 8.5, 25, 20)];
    [_locationImage setBackgroundColor:color(clearColor)];
    [_locationImage setImage:imageNameAndType(@"resume_location", @"png")];
    [_backGroundImage addSubview:_locationImage];
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_locationImage) + 5, _locationImage.frame.origin.y, _detailLabel.frame.size.width/2 - _locationImage.frame.size.width - 5, _locationImage.frame.size.height)];
    [_locationLabel setBackgroundColor:color(clearColor)];
    [_locationLabel setFont:[UIFont systemFontOfSize:11]];
    switch (random) {
        case 0:
            [_locationLabel setText:@"普陀区"];
            break;
        case 1:
            [_locationLabel setText:@"浦东新区"];
            break;
        case 2:
            [_locationLabel setText:@"海淀区"];
            break;
        default:
            break;
    }
    
    [_backGroundImage addSubview:_locationLabel];
    
    _timeImage = [[UIImageView alloc]initWithFrame:CGRectMake(controlXLength(_locationLabel), _locationImage.frame.origin.y, _locationImage.frame.size.width, _locationImage.frame.size.height)];
    [_timeImage setBackgroundColor:color(clearColor)];
    [_timeImage setImage:imageNameAndType(@"resume_time", @"png")];
    [_backGroundImage addSubview:_timeImage];
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(controlXLength(_timeImage) + 5, _locationLabel.frame.origin.y, _locationLabel.frame.size.width, _locationLabel.frame.size.height)];
    [_timeLabel setBackgroundColor:color(clearColor)];
    [_timeLabel setFont:[UIFont systemFontOfSize:11]];
    [_timeLabel setText:[Utils stringWithDate:[NSDate date] withFormat:@"yyyy/MM/dd"]];
    [_backGroundImage addSubview:_timeLabel];
    
    NSString *rightButtonTitle = nil;
    if (_cellType == MyResumeDeliver) {
        rightButtonTitle = @"投递简历";
    }else if (_cellType == MyResumeEdit){
        rightButtonTitle = @"修改名称";
    }else{
        rightButtonTitle = @"修改名称";
    }
    _rightButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setBackgroundColor:color(clearColor)];
    [_rightButton setBackgroundImage:imageNameAndType(@"resume_button_normal", @"png") forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:imageNameAndType(@"resume_button_press", @"png") forState:UIControlStateHighlighted];
    [_rightButton setTitle:rightButtonTitle forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_rightButton setTitleColor:color(blackColor) forState:UIControlStateNormal];
    [_rightButton setFrame:CGRectMake(controlXLength(_titleLabel) + 2.50f, _backGroundImage.frame.size.height/2 - 30.0/2, _leftButton.frame.size.width - 5, 30.0f)];
    [_backGroundImage addSubview:_rightButton];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self clearKeyBoard]) {
        [super touchesEnded:touches withEvent:event];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isFirstResponder]) {
        textField.enabled = NO;
        [_rightButton setTitle:_cellType == MyResumeDeliver?@"投递简历":@"修改名称" forState:UIControlStateNormal];
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_titleLabel isFirstResponder]) {
        [_titleLabel resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
}

@end
