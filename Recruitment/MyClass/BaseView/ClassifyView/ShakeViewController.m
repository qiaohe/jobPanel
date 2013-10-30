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
    self.dataSource = [NSMutableArray arrayWithArray:[CompanyDetail getCommentDataWithNum:7]];
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &messageSound);
    
    self = [super init];
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
    [self.view addSubview:shakeImage];
    
    
    //[self updateRandomCompany];
    
    
    [self.view addSubview:cell];
    
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
    [cell.locationLabel setText:jobDetail.location];
    [cell setBackGroundImage:imageNameAndType(@"information_textbackimage", nil)];
    
    cell.frame = CGRectMake(10, appFrame.size.height + ContactsStatusCellHeight, 300, ContactsStatusCellHeight);
    [cellButton setFrame:cell.bounds];
    [UIView transitionWithView:cell
                      duration:0.65f
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        cell.frame = CGRectMake(10, appFrame.size.height - ContactsStatusCellHeight - 20, 300, ContactsStatusCellHeight);
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
