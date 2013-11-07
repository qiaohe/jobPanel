//
//  InformationDetailViewController.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "InformationDetailViewController.h"
#import "CompanyDetail.h"
#import "RecommendJob.h"

@interface InformationDetailViewController ()

@end

@implementation InformationDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithObject:(id)object
{
    self = [super init];
    if (self) {
        if ([object isMemberOfClass:[CompanyDetail class]]) {
            _companyDetail = object;
        }else if ([object isMemberOfClass:[RecommendJob class]]){
            RecommendJob *detail = (RecommendJob*)object;
            _companyDetail = [[CompanyDetail alloc]initWithRecommendJob:detail];
        }else{
            _companyDetail = [[CompanyDetail alloc]init];
        }
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressDoneButton:(UIButton*)sender
{
    [[Model shareModel] showPromptText:@"评论成功" model:YES];
}

- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"information_backimage", @"png")];
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setTitle:@"公司详情"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png")
                  forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png")
                  forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *companyDetailImage = [[UIImageView alloc]initWithFrame:
                                       CGRectMake(0,
                                                  controlYLength(self.topBar),
                                                  self.contentView.frame.size.width,
                                                  self.contentView.frame.size.width * 3/5)];
    NSString *imageName = arc4random()%2 == 0?@"detail_item1":@"detail_item2";
    [companyDetailImage setImage:imageNameAndType(imageName, @"png")];
    [companyDetailImage setBackgroundColor:color(clearColor)];
    [self.contentView addSubview:companyDetailImage];
    
    UIImageView *collectNumImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 25, 25)];
    [collectNumImage setBackgroundColor:color(clearColor)];
    [collectNumImage setImage:imageNameAndType(@"information_collect", nil)];
    [companyDetailImage addSubview:collectNumImage];
    
    UILabel *collectNumLabel = [[UILabel alloc]initWithFrame:
                                CGRectMake(controlXLength(collectNumImage),
                                           collectNumImage.frame.origin.y,
                                           60,
                                           collectNumImage.frame.size.height)];
    [collectNumLabel setBackgroundColor:color(clearColor)];
    [collectNumLabel setTextColor:color(whiteColor)];
    [collectNumLabel setFont:[UIFont systemFontOfSize:12]];
    [collectNumLabel setText:[NSString stringWithFormat:@"%d",_companyDetail.collectNum]];
    [companyDetailImage addSubview:collectNumLabel];
    
    AppraiseStarLevel *averageAppraise = [[AppraiseStarLevel alloc]initWithFrame:
                                          CGRectMake(companyDetailImage.frame.size.width/2,
                                                     companyDetailImage.frame.size.height - 30 - 10,
                                                     self.view.frame.size.width/2,
                                                     30)
                                                                        levelNum:5];
    [averageAppraise setBackgroundColor:color(clearColor)];
    [averageAppraise setLightedStarWithNum:arc4random()%5];
    [companyDetailImage addSubview:averageAppraise];
    
    UIImageView *companyLogoImage = [[UIImageView alloc]initWithFrame:
                                     CGRectMake(0,
                                                controlYLength(companyDetailImage),
                                                80,
                                                80)];
    [companyLogoImage setBackgroundColor:color(clearColor)];
    [companyLogoImage setBounds:CGRectMake(0,
                                           0,
                                           companyLogoImage.frame.size.width * 0.7,
                                           companyLogoImage.frame.size.height * 0.7)];
    [companyLogoImage setImage:imageNameAndType(_companyDetail.companyLogo, nil)];
    [self.contentView addSubview:companyLogoImage];
    
    UILabel     *companyNameLabel = [[UILabel alloc]initWithFrame:
                                     CGRectMake(controlXLength(companyLogoImage) + 5,
                                                companyLogoImage.frame.origin.y + 5,
                                                self.contentView.frame.size.width - controlXLength(companyLogoImage) - 5,
                                                (companyLogoImage.frame.size.height - 5)/3)];
    [companyNameLabel setBackgroundColor:color(clearColor)];
    [companyNameLabel setText:_companyDetail.title];
    [companyNameLabel setFont:[UIFont boldSystemFontOfSize:14]];
    [self.contentView addSubview:companyNameLabel];
    
    UILabel     *companyDetailLabel = [[UILabel alloc]initWithFrame:
                                       CGRectMake(companyNameLabel.frame.origin.x,
                                                  controlYLength(companyNameLabel),
                                                  companyNameLabel.frame.size.width,
                                                  companyNameLabel.frame.size.height)];
    [companyDetailLabel setBackgroundColor:color(clearColor)];
    [companyDetailLabel setNumberOfLines:0];
    [companyDetailLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [companyDetailLabel setAdjustsFontSizeToFitWidth:YES];
    [companyDetailLabel setAdjustsLetterSpacingToFitWidth:YES];
    [companyDetailLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    [companyDetailLabel setMinimumScaleFactor:0.5];
    [companyDetailLabel setText:_companyDetail.companyDetail];
    [companyDetailLabel setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:companyDetailLabel];
    
    UILabel     *locationLabel      = [[UILabel alloc]initWithFrame:
                                       CGRectMake(self.contentView.frame.size.width - 10 - 80,
                                                  controlYLength(companyDetailLabel),
                                                  80,
                                                  30)];
    [locationLabel setBackgroundColor:color(clearColor)];
    [locationLabel setText:_companyDetail.location];
    [locationLabel setFont:[UIFont systemFontOfSize:10]];
    [locationLabel setTextColor:color(grayColor)];
    [self.contentView addSubview:locationLabel];
    
    UIImageView *locationImage      = [[UIImageView alloc]initWithFrame:
                                       CGRectMake(locationLabel.frame.origin.x - 20,
                                                  locationLabel.frame.origin.y + 5,
                                                  20,
                                                  20)];
    [locationImage setBackgroundColor:color(clearColor)];
    [locationImage setImage:imageNameAndType(@"resume_location", @"png")];
    [self.contentView addSubview:locationImage];
    
    UIImageView *detailLine1 = [[UIImageView alloc]initWithFrame:
                                CGRectMake(10,
                                           controlYLength(locationImage),
                                           self.contentView.frame.size.width - 20,
                                           5)];
    [detailLine1 setBackgroundColor:color(clearColor)];
    [detailLine1 setImage:imageNameAndType(@"detail_line", nil)];
    [self.contentView addSubview:detailLine1];
    
    UILabel *jobs = [[UILabel alloc]initWithFrame:
                     CGRectMake(detailLine1.frame.origin.x + 10,
                                controlYLength(detailLine1) + 5,
                                detailLine1.frame.size.width - 20,
                                20)];
    [jobs setTextColor:color(darkGrayColor)];
    NSString *jobDetail = [_companyDetail.jobArray componentsJoinedByString:@","];
    [jobs setText:[NSString stringWithFormat:@"招聘职位:%@",jobDetail]];
    [jobs setFont:[UIFont systemFontOfSize:10]];
    [jobs setBackgroundColor:color(clearColor)];
    [jobs setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:jobs];
    
    UILabel *companyProperty = [[UILabel alloc]initWithFrame:jobs.frame];
    [companyProperty setTextColor:color(darkGrayColor)];
    [companyProperty setText:[NSString stringWithFormat:@"公司性质:%@",_companyDetail.companyProperty]];
    [companyProperty setFont:jobs.font];
    [companyProperty setBackgroundColor:color(clearColor)];
    [companyProperty setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:companyProperty];
    
    UILabel *companySize = [[UILabel alloc]initWithFrame:
                            CGRectMake(jobs.frame.origin.x,
                                       controlYLength(jobs),
                                       jobs.frame.size.width,
                                       jobs.frame.size.height)];
    [companySize setTextColor:color(darkGrayColor)];
    [companySize setText:[NSString stringWithFormat:@"公司规模:%@",_companyDetail.companySize]];
    [companySize setFont:jobs.font];
    [companySize setBackgroundColor:color(clearColor)];
    [companySize setTextAlignment:NSTextAlignmentLeft];
    [self.contentView addSubview:companySize];
    
    UILabel *companyAddress = [[UILabel alloc]initWithFrame:companySize.frame];
    [companyAddress setTextColor:color(darkGrayColor)];
    [companyAddress setText:[NSString stringWithFormat:@"公司地址:%@",_companyDetail.location]];
    [companyAddress setFont:jobs.font];
    [companyAddress setBackgroundColor:color(clearColor)];
    [companyAddress setTextAlignment:NSTextAlignmentRight];
    [self.contentView addSubview:companyAddress];
    
    UIImageView *detailLine2 = [[UIImageView alloc]initWithFrame:
                                CGRectMake(detailLine1.frame.origin.x,
                                           controlYLength(companyAddress) + 5,
                                           detailLine1.frame.size.width,
                                           detailLine1.frame.size.height)];
    [detailLine2 setBackgroundColor:color(clearColor)];
    [detailLine2 setImage:imageNameAndType(@"detail_line", nil)];
    [self.contentView addSubview:detailLine2];
    
    UITextView *companyDescription = [[UITextView alloc]initWithFrame:
                                      CGRectMake(jobs.frame.origin.x,
                                                 controlYLength(detailLine2) + 10,
                                                 jobs.frame.size.width,
                                                 [Utils heightForWidth:jobs.frame.size.width
                                                                  text:[NSString stringWithFormat:@"  %@",_companyDetail.companyDescription]
                                                                  font:[UIFont systemFontOfSize:14]])];
    [companyDescription setBackgroundColor:color(clearColor)];
    [companyDescription setFont:[UIFont systemFontOfSize:14]];
    [companyDescription setEditable:NO];
    [companyDescription setScrollEnabled:NO];
    [companyDescription setText:[NSString stringWithFormat:@"  %@",_companyDetail.companyDescription]];
    [self.contentView addSubview:companyDescription];
    
    UITextField *companyAppriase = [[UITextField alloc]initWithFrame:
                                    CGRectMake(20 ,
                                               controlYLength(companyDescription) + 5,
                                               self.contentView.frame.size.width - 40,
                                               30)];
    [companyAppriase setEnabled:NO];
    
    [companyAppriase setBackground:imageNameAndType(@"companyappraise_title", @"png")];
    [companyAppriase setBackgroundColor:color(clearColor)];
    [companyAppriase setBounds:CGRectMake(companyAppriase.frame.origin.x - 10,
                                          companyAppriase.frame.origin.y,
                                          companyAppriase.frame.size.width + 20,
                                          companyAppriase.frame.size.height)];
    [companyAppriase setPlaceholder:@"  公司评价"];
    [companyAppriase setFont:[UIFont systemFontOfSize:13]];
    [companyAppriase setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self.contentView addSubview:companyAppriase];
    
    UIImageView *appriaseDetail = [[UIImageView alloc]initWithFrame:
                                   CGRectMake(companyAppriase.bounds.origin.x,
                                              controlYLength(companyAppriase),
                                              companyAppriase.bounds.size.width,
                                              companyAppriase.frame.size.height * 3)];
    [appriaseDetail setBackgroundColor:color(clearColor)];
    [appriaseDetail setImage:imageNameAndType(@"companyappraise_detail", nil)];
    [appriaseDetail setUserInteractionEnabled:YES];
    [self.contentView addSubview:appriaseDetail];
    
    AppraiseStarLevel *betterCompany = [[AppraiseStarLevel alloc]initWithFrame:
                                        CGRectMake(0,
                                                   0,
                                                   (appriaseDetail.frame.size.width - 20)/2,
                                                   appriaseDetail.frame.size.height/2)
                                                                      levelNum:5];
    [betterCompany setLeftTitle:@"好公司"];
    [appriaseDetail addSubview:betterCompany];
    
    AppraiseStarLevel *betterTechnology = [[AppraiseStarLevel alloc]initWithFrame:
                                           CGRectMake(controlXLength(betterCompany),
                                                      betterCompany.frame.origin.y,
                                                      betterCompany.frame.size.width,
                                                      betterCompany.frame.size.height)
                                                                         levelNum:5];
    [betterTechnology setLeftTitle:@"技术强"];
    [appriaseDetail addSubview:betterTechnology];
    
    AppraiseStarLevel *individuation = [[AppraiseStarLevel alloc]initWithFrame:
                                           CGRectMake(betterCompany.frame.origin.x,
                                                      controlYLength(betterCompany),
                                                      betterCompany.frame.size.width,
                                                      betterCompany.frame.size.height)
                                                                      levelNum:5];
    [individuation setLeftTitle:@"个性化"];
    [appriaseDetail addSubview:individuation];
    
    AppraiseStarLevel *betterWelfare = [[AppraiseStarLevel alloc]initWithFrame:
                                           CGRectMake(controlXLength(individuation),
                                                      individuation.frame.origin.y,
                                                      betterCompany.frame.size.width,
                                                      betterCompany.frame.size.height)
                                                                      levelNum:5];
    [betterWelfare setLeftTitle:@"福利好"];
    [appriaseDetail addSubview:betterWelfare];
    
    UIImageView *appraiseTextImage = [[UIImageView alloc]initWithFrame:
                                      CGRectMake(appriaseDetail.frame.origin.x,
                                                 controlYLength(appriaseDetail) + 15,
                                                 appriaseDetail.frame.size.width,
                                                 appriaseDetail.frame.size.height)];
    [appraiseTextImage setBackgroundColor:color(clearColor)];
    [appraiseTextImage setImage:stretchImage(@"information_textimage", @"png")];
    [self.contentView addSubview:appraiseTextImage];
    
    _appraiseText = [[UITextView alloc]initWithFrame:appraiseTextImage.frame];
    [_appraiseText setBackgroundColor:color(clearColor)];
    [_appraiseText setText:@"我来评价..."];
    [self.contentView addSubview:_appraiseText];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setBackgroundColor:color(clearColor)];
    [doneButton setFrame:CGRectMake(self.view.frame.size.width/4,
                                    controlYLength(_appraiseText) + 10,
                                    self.view.frame.size.width/2,
                                    40)];
    [doneButton setTitle:@"完成"
                forState:UIControlStateNormal];
    [doneButton addTarget:self
                   action:@selector(pressDoneButton:)
         forControlEvents:UIControlEventTouchUpInside];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_normal", @"png")
                          forState:UIControlStateNormal];
    [doneButton setBackgroundImage:imageNameAndType(@"resume_done_press", @"png")
                          forState:UIControlStateHighlighted];
    [self.contentView addSubview:doneButton];
    
    /*
    UIImageView *item1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, controlYLength(self.topBar), self.contentView.frame.size.width, 500)];
    [item1 setBackgroundColor:color(clearColor)];
    [item1 setImage:imageNameAndType(@"detail_item1", @"png")];
    [self.contentView addSubview:item1];
    
    UIImageView *item2 = [[UIImageView alloc]initWithFrame:CGRectMake(item1.frame.origin.x + 10, controlYLength(item1) + 10, item1.frame.size.width - 20, 110)];
    [item2 setBackgroundColor:color(clearColor)];
    [item2 setImage:imageNameAndType(@"detail_item2", @"png")];
    [self.contentView addSubview:item2];
    
    
    
    */
    
    //UIImageView *companyDetailBackImage = [UIImageView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setBackgroundColor:color(clearColor)];
    [homeButton setTag:102];
    [homeButton setImage:imageNameAndType(@"returnhome_normal", @"png")
                forState:UIControlStateNormal];
    [homeButton setImage:imageNameAndType(@"returnhome_press", @"png")
                forState:UIControlStateHighlighted];
    [self setPopToMainViewButton:homeButton];
    [self setBottomBarItems:@[homeButton]];
    [self setBottomBarBackGroundImage:imageNameAndType(@"bottombar", @"png")];
}

- (BOOL)clearKeyBoard
{
    BOOL canResignFirstResponder = NO;
    if ([_appraiseText isFirstResponder]) {
        [_appraiseText resignFirstResponder];
        canResignFirstResponder = YES;
    }
    return canResignFirstResponder;
}

#pragma mark - keyboard show or dismiss
- (void)keyBoardWillShow:(NSNotification *)notification
{
    [super keyBoardWillShow:notification];
    UIView *keyBoard = [self findKeyboard];
    if (!keyBoard) {
        //CGPoint beginCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGPointValue];
        //CGPoint endCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGPointValue];
        //CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardShow:keyboardFrames animationDuration:animationDuration];
    }
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    [super keyBoardWillHide:notification];
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [self keyBoardHide:keyboardFrames animationDuration:animationDuration];
    }
}


- (void)keyBoardChangeFrame:(NSNotification *)notification
{
    [super keyBoardWillHide:notification];
    UIView *keyBoard = [self findKeyboard];
    if (keyBoard) {
        //CGPoint beginCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGPointValue];
        //CGPoint endCentre = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGPointValue];
        //CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
        CGRect keyboardFrames = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //UIViewAnimationCurve animationCurve = [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
        
        [self keyBoardShow:keyboardFrames animationDuration:0.35f];
    }
}

- (void)keyBoardShow:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UIView *responder = nil;
    if ([_appraiseText isFirstResponder]) {
        responder = _appraiseText;
    }
    if (responder) {
        if (responder.frame.origin.y + 40 - self.contentView.contentOffset.y > self.view.frame.size.height - frame.size.height) {
            CGFloat changeY = responder.frame.origin.y + 40 - self.contentView.contentOffset.y - (self.view.frame.size.height - frame.size.height);
            changeY = changeY >= 0?changeY:0;
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.view.frame.origin.x, 0 - changeY, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
}

- (void)keyBoardHide:(CGRect)frame animationDuration:(NSTimeInterval)duration
{
    UIView *responder = nil;
    if ([_appraiseText isFirstResponder]) {
        responder = _appraiseText;
    }
    if (responder) {
        if (responder.frame.origin.y + 40 - self.contentView.contentOffset.y < frame.origin.y) {
            [UIView animateWithDuration:duration
                             animations:^{
                                 self.contentView.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 
                             }];
        }
    }
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

@interface AppraiseStarLevel ()

@property (strong, nonatomic) UILabel           *appraiseTitleLabel;

@end

@implementation AppraiseStarLevel

@synthesize leftTitle;

- (id)initWithFrame:(CGRect)frame levelNum:(NSInteger)num
{
    self = [super initWithFrame:frame];
    if (self) {
        _levelArray = [NSMutableArray array];
        [self setSubviewWithNum:num];
    }
    return self;
}

- (void)setSubviewWithNum:(NSInteger)num
{
    _appraiseTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/5 >= 50?self.frame.size.width/5:50, self.frame.size.height)];
    _appraiseTitleLabel.adjustsFontSizeToFitWidth       = YES;
    _appraiseTitleLabel.adjustsLetterSpacingToFitWidth  = YES;
    _appraiseTitleLabel.baselineAdjustment              = UIBaselineAdjustmentAlignBaselines;
    _appraiseTitleLabel.minimumScaleFactor              = 0.3;
    [_appraiseTitleLabel setBackgroundColor:color(clearColor)];
    [self addSubview:_appraiseTitleLabel];
    
    UIView *subView = [[UIView alloc]initWithFrame:CGRectMake(controlXLength(_appraiseTitleLabel) + 10, 0, self.frame.size.width - controlXLength(_appraiseTitleLabel) - 10, (self.frame.size.width - controlXLength(_appraiseTitleLabel))/num)];
    [subView setCenter:CGPointMake(controlXLength(_appraiseTitleLabel) + (self.frame.size.width - controlXLength(_appraiseTitleLabel))/2, self.frame.size.height/2)];
    [subView setUserInteractionEnabled:YES];
    [subView setBackgroundColor:color(clearColor)];
    
    UITabBar *tabBar = [[UITabBar alloc]initWithFrame:subView.frame];
    [tabBar setBackgroundColor:color(clearColor)];
    [tabBar setDelegate:self];
    [tabBar setAlpha:0];
    NSMutableArray *tabBarItems = [NSMutableArray array];
    for (int i = 0; i<num; i++) {
        UITabBarItem *item = [[UITabBarItem alloc]init];
        [tabBarItems addObject:item];
    }
    [tabBar setItems:tabBarItems];
    
    for (int i = 0; i<num; i++) {
        UIImageView *starItem = [[UIImageView alloc]initWithFrame:CGRectMake((subView.frame.size.width/num) * i + 0.5, 0.5, subView.frame.size.height - 1, subView.frame.size.height - 1)];
        [starItem setTag:(100 + i)];
        [starItem setBackgroundColor:color(clearColor)];
        [starItem setImage:imageNameAndType(@"star_dim", @"png")];
        [starItem setHighlightedImage:imageNameAndType(@"star_light", @"png")];
        [subView addSubview:starItem];
        [_levelArray addObject:starItem];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:color(clearColor)];
        [button setTag:(200 + i)];
        [button addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:starItem.frame];
        [subView addSubview:button];
    }
    [self addSubview:subView];
    [self insertSubview:tabBar aboveSubview:subView];
}

- (void)setLeftTitle:(NSString *)title
{
    if (leftTitle != title) {
        leftTitle = title;
        [_appraiseTitleLabel setText:[NSString stringWithFormat:@" %@",title]];
    }
}

- (NSString*)leftTitle
{
    leftTitle = [Utils NULLToEmpty:_appraiseTitleLabel.text];
    return leftTitle;
}

- (void)pressButton:(UIButton*)sender
{
    [self setLightedStarWithNum:sender.tag];
}

- (void)setLightedStarWithNum:(NSInteger)num
{
    NSInteger imageTag = num%100 + 100;
    for (UIImageView *image in _levelArray) {
        if (image.tag <= imageTag) {
            image.highlighted = YES;
        }else{
            image.highlighted = NO;
        }
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item] + 100;
    for (UIButton *button in _levelArray) {
        if (button.tag <= index) {
            button.highlighted = YES;
        }else{
            button.highlighted = NO;
        }
    }
}



@end
