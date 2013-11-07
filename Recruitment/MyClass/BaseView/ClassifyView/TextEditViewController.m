//
//  TextEditViewController.m
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "TextEditViewController.h"

@interface TextEditViewController ()

@end

@implementation TextEditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(TextEditType)initType
{
    self = [super init];
    if (self) {
        _type = initType;
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

- (void)pressDoneButton:(UIButton*)sender
{
    [self popViewControllerTransitionType:TransitionPush completionHandler:^{
        [self.delegate editDone:nil];
    }];
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    if (_type == TextEditPersonalLight) {
        [self setTitle:@"个人亮点"];
    }else{
        [self setTitle:@"推荐人评价"];
    }
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    _textDetail = [[UITextView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.view.frame.size.width, self.view.frame.size.height - controlYLength(self.topBar) - 20 - 45 - 40)];
    [_textDetail setBackgroundColor:color(colorWithRed:221 green:229 blue:234 alpha:1)];
    [_textDetail setDelegate:self];
    [_textDetail setFont:[UIFont systemFontOfSize:13]];
    [_textDetail setTextColor:color(darkGrayColor)];
    if (_type == TextEditPersonalLight) {
        [_textDetail setText:@"请填写个人亮点，以便HR更好地了解你。。。"];
    }else{
        [_textDetail setText:@"这里是推荐人对你的评价"];
    }
    [self.contentView addSubview:_textDetail];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/6, controlYLength(_textDetail) + 20, self.view.frame.size.width*2/3, 45)];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png") forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png") forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(pressDoneButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:doneButton];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png") forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png") forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
}

- (BOOL)clearKeyBoard
{
    BOOL canResighFirstResponder = NO;
    if ([_textDetail isFirstResponder]) {
        [_textDetail resignFirstResponder];
        canResighFirstResponder = YES;
    }
    return canResighFirstResponder;
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
