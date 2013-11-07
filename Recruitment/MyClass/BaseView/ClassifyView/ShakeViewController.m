//
//  ShakeViewController.m
//  Recruitment
//
//  Created by Jack Wang on 10/31/13.
//  Copyright (c) 2013 M J. All rights reserved.
//

#import "ShakeViewController.h"
#import "InformationDetailViewController.h"

@interface ShakeViewController ()

@end

@implementation ShakeViewController

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
        self.dataSource = [NSMutableArray arrayWithArray:[CompanyDetail getRecommendDataWithNum:7]];
        
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &messageSound);
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
{
    [self setTopBarBackGroundImage:imageNameAndType(@"topImage", @"png")];
    [self setBackGroundImage:imageNameAndType(@"shake_view_bg", @"png")];
    [self setTitle:@"摇一摇"];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnButton setBackgroundColor:[UIColor clearColor]];
    [returnButton setFrame:CGRectMake(5, 0, 40, 40)];
    [returnButton setImage:imageNameAndType(@"return_normal", @"png") forState:UIControlStateNormal];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateSelected];
    [returnButton setImage:imageNameAndType(@"return_press", @"png") forState:UIControlStateHighlighted];
    [self setReturnButton:returnButton];
    [self.view addSubview:returnButton];
    
    UIImageView *shakeImage = [[UIImageView alloc]initWithFrame:CGRectMake(109, (appFrame.size.height - 180)/2, 102, 180)];
    [shakeImage setBackgroundColor:color(clearColor)];
    [shakeImage setImage:imageNameAndType(@"shake_img", @"png")];
    [self.contentView addSubview:shakeImage];
    
    
    //[self updateRandomCompany];
    
    
    [self.view addSubview:cell];
    
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

-(void)updateRandomCompany{
    UIButton *cellButton;
    if(!cell){
        static NSString *identifierString = @"cell";
        cell = [[ContactsStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierString];
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell addSubview:cellButton];
        [cellButton setBackgroundColor:color(clearColor)];
        cellButton.tag = 311;
        
        [cellButton addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cell];
    }
    AudioServicesPlaySystemSound(messageSound);
    cellButton = (UIButton *)[cell viewWithTag:311];
    
    NSInteger randomNumber = arc4random() % 7;
    jobDetail = [_dataSource objectAtIndex:randomNumber];
    [cell.leftImage setImage:imageNameAndType(jobDetail.companyLogo, nil)];
    NSString *text = [jobDetail.jobArray componentsJoinedByString:@"+"];
    text = jobDetail.title?[NSString stringWithFormat:@"%@:%@",jobDetail.title,text]:text;
    [cell.titleLabel setText:text];
    [cell.detailLabel setText:jobDetail.detail];
    [cell.locationLabel setText:[NSString stringWithFormat:@"距离%d米",arc4random()%500 + 20]];
    [cell setBackGroundImage:imageNameAndType(@"information_textbackimage", nil)];
    
    cell.frame = CGRectMake(10, appFrame.size.height + ContactsStatusCellHeight, self.view.frame.size.width - 20, ContactsStatusCellHeight);
    [cell.backGroundImageView setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [cellButton setFrame:cell.bounds];
    [UIView transitionWithView:cell
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        cell.frame = CGRectMake(10, appFrame.size.height - ContactsStatusCellHeight - 40 - 20, self.view.frame.size.width - 20, ContactsStatusCellHeight);
                    }
                    completion:^(BOOL finished){
                        
                    }];
    
}

- (void)pressButton:(UIButton*)sender
{
    InformationDetailViewController *informationDetail = [[InformationDetailViewController alloc]initWithObject:jobDetail];
    [self.navigationController pushViewController:informationDetail animated:YES];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        // your code
        NSLog(@"shake");
        [self updateRandomCompany];
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
