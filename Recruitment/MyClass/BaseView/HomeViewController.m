//
//  HomeViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "HomeViewController.h"
#import "ClassifyViewController.h"
#import "ResumeTraceViewController.h"
#import "JobDetailViewController.h"
#import "ResumeTraceViewController.h"
#import "ContactsStatusViewController.h"
#import "JobInformation.h"
#import "Contacts.h"

@interface HomeViewController ()

@property (strong, nonatomic) NSMutableArray                *dataSource;
@property (strong, nonatomic) BaseContentView               *topImageView;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"home_topitem1",@"home_topitem2",@"home_topitem3"]];
        
        _recommendDataSource = [NSMutableArray arrayWithArray:[JobInformation getRecommendDataWithNum:2]];
        _contactsStatusDataSource = [NSMutableArray arrayWithArray:[Contacts getContactsWithNum:2]];
        _trendNotificationDataSource = [NSMutableArray arrayWithArray:@[@"应聘追踪",@"人脉动态通知"]];
        
        [self setSubviewFrame];
    }
    return self;
}

- (void)pressPromptButton:(UIButton*)sender
{
    ClassifyViewController *viewController= [[ClassifyViewController alloc]init];
    [Model shareModel].mainView = viewController;
    
    ResumeTraceViewController *resumeTraceView = [[ResumeTraceViewController alloc]init];
    [self pushViewControllers:@[viewController,resumeTraceView] transitionType:TransitionMoveIn completionHandler:nil];
}

- (void)panning:(UISwipeGestureRecognizer*)gestureRecognizer
{
    ClassifyViewController *viewController = [[ClassifyViewController alloc]init];
    [Model shareModel].mainView = viewController;
    Direction direction;
    switch (gestureRecognizer.direction) {
        case UISwipeGestureRecognizerDirectionUp:{
            direction = DirectionTop;
            break;
        }case UISwipeGestureRecognizerDirectionDown:{
            direction = DirectionBottom;
            break;
        }case UISwipeGestureRecognizerDirectionLeft:{
            direction = DirectionRight;
            break;
        }case UISwipeGestureRecognizerDirectionRight:{
            direction = DirectionLeft;
            break;
        }
        default:
            direction = DirectionRight;
            break;
    }
    [self pushViewController:viewController transitionType:TransitionMoveIn Direction:direction completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HomeViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _bottomLeftContentView) {
        return [_recommendDataSource count];
    }else{
        return [_contactsStatusDataSource count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, HomeViewCellHeight/3, HomeViewCellHeight/3)];
        [imageView setBackgroundColor:color(clearColor)];
        [imageView setBounds:CGRectMake(imageView.bounds.origin.x + imageView.frame.size.width/4, imageView.frame.origin.y + imageView.frame.size.height/4, imageView.frame.size.width * 0.6, imageView.frame.size.height * 0.6)];
        [imageView setImage:imageNameAndType(@"home_point", nil)];
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(HomeViewCellHeight/2,5, _bottomLeftContentView.frame.size.width - HomeViewCellHeight, HomeViewCellHeight/3)];
        [titleLabel setBackgroundColor:color(clearColor)];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [titleLabel setTextColor:color(whiteColor)];
        [titleLabel setAdjustsFontSizeToFitWidth:YES];
        [titleLabel setAdjustsLetterSpacingToFitWidth:YES];
        [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [titleLabel setMinimumScaleFactor:0.5];
        [titleLabel setTag:100];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, controlYLength(titleLabel), titleLabel.frame.size.width, titleLabel.frame.size.height * 2 - 5)];
        [detailLabel setBackgroundColor:color(clearColor)];
        [detailLabel setTextColor:color(whiteColor)];
        [detailLabel setFont:[UIFont systemFontOfSize:11]];
        [detailLabel setAdjustsFontSizeToFitWidth:YES];
        [detailLabel setAdjustsLetterSpacingToFitWidth:YES];
        [detailLabel setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
        [detailLabel setMinimumScaleFactor:0.1];
        [detailLabel setNumberOfLines:0];
        [detailLabel setLineBreakMode:NSLineBreakByCharWrapping];
        
        [detailLabel setTag:101];
        [cell.contentView addSubview:detailLabel];
        
        NSInteger randomNum = arc4random()%3;
        UIButton *rightItem = [[UIButton alloc]initWithFrame:CGRectMake(controlXLength(titleLabel), 0, HomeViewCellHeight/2, HomeViewCellHeight/2)];
        [rightItem setBackgroundColor:color(clearColor)];
        [rightItem setBackgroundImage:imageNameAndType(@"home_prompt", nil) forState:UIControlStateDisabled];
        [rightItem setTag:102];
        [rightItem setEnabled:NO];
        [rightItem.titleLabel setFont:[UIFont systemFontOfSize:11]];
        [rightItem   setTitle:[NSString stringWithFormat:@"%d",randomNum] forState:UIControlStateNormal];
        [cell.contentView addSubview:rightItem];
    }
    UILabel *titleLabel  = (UILabel*)[cell.contentView viewWithTag:100];
    UILabel *detailLabel = (UILabel*)[cell.contentView viewWithTag:101];
    UIButton *rightItem  = (UIButton*)[cell.contentView viewWithTag:102];
    rightItem.hidden = YES;
    
    if (tableView == _bottomLeftContentView) {
        JobInformation *jobDetail = [_recommendDataSource objectAtIndex:indexPath.row];
        [titleLabel setText:jobDetail.company];
        [detailLabel setText:jobDetail.position];
    }else{
        NSString *text = [_trendNotificationDataSource objectAtIndex:indexPath.row];
        
        [titleLabel  setText:text];
        NSLog(@"title = %@",rightItem.titleLabel.text);
        if ([rightItem.titleLabel.text integerValue] != 0) {
            rightItem.hidden = NO;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bottomLeftContentView) {
        ClassifyViewController *classifyView = [[ClassifyViewController alloc]init];
        [Model shareModel].mainView = classifyView;
        JobInformation *jobDetail = [_recommendDataSource objectAtIndex:indexPath.row];
        JobDetailViewController *jobDetailView = [[JobDetailViewController alloc]initWithDetail:jobDetail];
        [self pushViewControllers:@[classifyView,jobDetailView] transitionType:TransitionPush completionHandler:nil];
    }else if (tableView == _bottomRightContentView){
        UITableViewCell *cell = [_bottomRightContentView cellForRowAtIndexPath:indexPath];
        UIButton *rightItem  = (UIButton*)[cell.contentView viewWithTag:102];
        NSInteger index = [rightItem.titleLabel.text integerValue];
        if (index == 0) {
            [[Model shareModel] showPromptText:@"无动态" model:YES];
            return;
        }else{
            ClassifyViewController *classifyView = [[ClassifyViewController alloc]init];
            [Model shareModel].mainView = classifyView;
            switch (indexPath.row) {
                case 0:{
                    ResumeTraceViewController *traceView = [[ResumeTraceViewController alloc]init];
                    [self pushViewControllers:@[classifyView,traceView] transitionType:TransitionPush completionHandler:^{
                        [rightItem setTitle:@"0" forState:UIControlStateNormal];
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    break;
                }case 1:{
                    ContactsStatusViewController *contactStatusView = [[ContactsStatusViewController alloc]init];
                    [self pushViewControllers:@[classifyView,contactStatusView] transitionType:TransitionPush completionHandler:^{
                        [rightItem setTitle:@"0" forState:UIControlStateNormal];
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    }
}

#pragma mark - view init
- (void)setSubviewFrame
{
    [self setBackGroundImage:imageNameAndType(@"home_blackback", @"png")];
    
    _topImageView = [[BaseContentView alloc]initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     self.view.frame.size.width,
                                                                     self.view.frame.size.height*5/7)];
    [_topImageView setPagingEnabled:YES];
    [_topImageView setShowsVerticalScrollIndicator:NO];
    [_topImageView setShowsHorizontalScrollIndicator:NO];
    [_topImageView setBounces:NO];
    //[_topImageView setScrollEnabled:NO];
    [_topImageView setBackgroundColor:color(clearColor)];
    for (int i = 0; i<[_dataSource count]; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_topImageView.frame.size.width * i, 0, _topImageView.frame.size.width, _topImageView.frame.size.height)];
        [imageView setImage:imageNameAndType([_dataSource objectAtIndex:i], nil)];
        [imageView setBackgroundColor:color(clearColor)];
        [_topImageView addSubview:imageView];
    }
    [self.view addSubview:_topImageView];
    
    UIImageView *treeLogo = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80/2, 100/2, 80, 100)];
    [treeLogo setBackgroundColor:color(clearColor)];
    [treeLogo setImage:imageNameAndType(@"home_treelogo", @"png")];
    [self.view addSubview:treeLogo];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, controlYLength(_topImageView) - 100, self.view.frame.size.width, 100)];
    [label setBackgroundColor:color(clearColor)];
    [label setText:[NSString stringWithFormat:@"    %@\n\r        %@",@"决定我们成为什么样人的,",@"不是我们的能力,而是我们的选择."]];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:color(whiteColor)];
    [self.view addSubview:label];
    
    UIImageView *bottomLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(1.50f,
                                                                               self.view.frame.size.height*5/7,
                                                                               _topImageView.frame.size.width/2 - 2.25f,
                                                                               self.view.frame.size.height - _topImageView.frame.size.height )];
    [bottomLeftView setBackgroundColor:[UIColor clearColor]];
    [bottomLeftView setUserInteractionEnabled:YES];
    [bottomLeftView setImage:imageNameAndType(@"home_bottomItem", @"png")];
    [self.view addSubview:bottomLeftView];
    
    UILabel *bottomLeftTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, bottomLeftView.frame.size.width - 10, 30)];
    [bottomLeftTitle setBackgroundColor:color(clearColor)];
    [bottomLeftTitle setText:@"精选职位"];
    [bottomLeftTitle setFont:[UIFont systemFontOfSize:14]];
    [bottomLeftTitle setTextColor:color(whiteColor)];
    [bottomLeftView addSubview:bottomLeftTitle];
    
    UIImageView *bottomLeftLine = [[UIImageView alloc]initWithFrame:CGRectMake(bottomLeftTitle.frame.origin.x, controlYLength(bottomLeftTitle), bottomLeftTitle.frame.size.width, 1)];
    [bottomLeftLine setBackgroundColor:color(clearColor)];
    [bottomLeftLine setImage:imageNameAndType(@"home_bottomline", nil)];
    [bottomLeftView addSubview:bottomLeftLine];
    
    _bottomLeftContentView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(bottomLeftLine), bottomLeftView.frame.size.width, bottomLeftView.frame.size.height - controlYLength(bottomLeftLine))];
    [_bottomLeftContentView setBackgroundColor:color(clearColor)];
    [_bottomLeftContentView setDelegate:self];
    [_bottomLeftContentView setDataSource:self];
    [_bottomLeftContentView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_bottomLeftContentView setScrollEnabled:NO];
    [bottomLeftView addSubview:_bottomLeftContentView];
    
    UIImageView *bottomRightView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 + 0.75f,
                                                                             bottomLeftView.frame.origin.y,
                                                                             bottomLeftView.frame.size.width,
                                                                             bottomLeftView.frame.size.height)];
    [bottomRightView setBackgroundColor:[UIColor clearColor]];
    [bottomRightView setUserInteractionEnabled:YES];
    [bottomRightView setImage:imageNameAndType(@"home_bottomItem", @"png")];
    [self.view addSubview:bottomRightView];
    
    UILabel *bottomRightTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, bottomLeftTitle.frame.size.width, bottomLeftTitle.frame.size.height)];
    [bottomRightTitle setBackgroundColor:color(clearColor)];
    [bottomRightTitle setText:@"动态通知"];
    [bottomRightTitle setFont:[UIFont systemFontOfSize:14]];
    [bottomRightTitle setTextColor:color(whiteColor)];
    [bottomRightView addSubview:bottomRightTitle];
    
    UIImageView *bottomRightLine = [[UIImageView alloc]initWithFrame:CGRectMake(bottomRightTitle.frame.origin.x, controlYLength(bottomRightTitle), bottomLeftLine.frame.size.width, bottomLeftLine.frame.size.height)];
    [bottomRightLine setBackgroundColor:color(clearColor)];
    [bottomRightLine setImage:imageNameAndType(@"home_bottomline", nil)];
    [bottomRightView addSubview:bottomRightLine];
    
    _bottomRightContentView = [[UITableView alloc]initWithFrame:CGRectMake(0, controlYLength(bottomRightLine), bottomRightView.frame.size.width, bottomRightView.frame.size.height - controlYLength(bottomRightLine))];
    [_bottomRightContentView setBackgroundColor:color(clearColor)];
    [_bottomRightContentView setDelegate:self];
    [_bottomRightContentView setDataSource:self];
    [_bottomRightContentView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_bottomRightContentView setScrollEnabled:NO];
    [bottomRightView addSubview:_bottomRightContentView];
    
    /*
    UIButton *promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [promptButton setBackgroundColor:color(clearColor)];
    [promptButton setBackgroundImage:imageNameAndType(@"home_prompt", @"png")
                            forState:UIControlStateNormal];
    [promptButton setTitle:@"3"
                  forState:UIControlStateNormal];
    [promptButton setFrame:CGRectMake(bottomRightView.frame.size.width - 5 - 35, 0 + 30, 35, 35)];
    [promptButton addTarget:self
                     action:@selector(pressPromptButton:)
           forControlEvents:UIControlEventTouchUpInside];
    [bottomRightView addSubview:promptButton];*/
    
    UISwipeGestureRecognizer *upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                              action:@selector(panning:)];
    [upSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [upSwipeGestureRecognizer setDelegate:self];
    
    UISwipeGestureRecognizer *downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                                  action:@selector(panning:)];
    [downSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [downSwipeGestureRecognizer setDelegate:self];
    
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                                  action:@selector(panning:)];
    [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [leftSwipeGestureRecognizer setDelegate:self];
    
    [self.view addGestureRecognizer:upSwipeGestureRecognizer];
    [self.view addGestureRecognizer:downSwipeGestureRecognizer];
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
    
   
    [NSTimer scheduledTimerWithTimeInterval:2.50f target:self selector:@selector(playImage:) userInfo:nil repeats:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    CGPoint point = CGPointMake(0, _topImageView.contentOffset.y);
    [_topImageView setContentOffset:point animated:NO];
}

- (void)playImage:(NSTimer*)timer
{
    CGPoint point = CGPointMake(_topImageView.contentOffset.x + _topImageView.frame.size.width, _topImageView.contentOffset.y);
    if (point.x >= _topImageView.contentSize.width) {
        point = CGPointMake(0, _topImageView.contentOffset.y);
    }
    [_topImageView setContentOffset:point animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)jumpToClassifyView
{
    ClassifyViewController *viewController= [[ClassifyViewController alloc]init];
    [Model shareModel].mainView = viewController;
    [self pushViewController:viewController transitionType:TransitionMoveIn completionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
