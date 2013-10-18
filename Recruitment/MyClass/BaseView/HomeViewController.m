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

@interface HomeViewController ()

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
        [self setViewFrame];
    }
    return self;
}

- (void)pressBottomLeftView:(UIButton*)sender
{
    [self jumpToClassifyView];
}

- (void)pressBottomRightView:(UIButton*)sender
{
    [self jumpToClassifyView];
}

- (void)pressPromptButton:(UIButton*)sender
{
    ResumeTraceViewController *resumeTraceView = [[ResumeTraceViewController alloc]init];
    [self.navigationController pushViewController:resumeTraceView animated:YES];
}

- (void)setViewFrame
{
    [self setBackGroundImage:imageNameAndType(@"home_blackback", @"png")];
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*5/7)];
    [topImageView setBackgroundColor:[UIColor clearColor]];
    [topImageView setImage:imageNameAndType(@"home_backimage", @"png")];
    [self.view addSubview:topImageView];
    
    UIButton *bottomLeftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomLeftView setFrame:CGRectMake(1.50f, self.view.frame.size.height*5/7, topImageView.frame.size.width/2 - 2.25f, self.view.frame.size.height - topImageView.frame.size.height )];
    [bottomLeftView setBackgroundColor:[UIColor clearColor]];
    [bottomLeftView addTarget:self action:@selector(pressBottomLeftView:) forControlEvents:UIControlEventTouchUpInside];
    [bottomLeftView setImage:imageNameAndType(@"home_item1", @"png") forState:UIControlStateNormal];
    [bottomLeftView setImage:imageNameAndType(@"home_item1", @"png") forState:UIControlStateDisabled];
    [self.view addSubview:bottomLeftView];
    
    UIButton *bottomRightView = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomRightView setFrame:CGRectMake(self.view.frame.size.width/2 + 0.75f, bottomLeftView.frame.origin.y, bottomLeftView.frame.size.width, bottomLeftView.frame.size.height)];
    [bottomRightView setBackgroundColor:[UIColor clearColor]];
    [bottomLeftView addTarget:self action:@selector(pressBottomRightView:) forControlEvents:UIControlEventTouchUpInside];
    [bottomRightView setImage:imageNameAndType(@"home_item2", @"png") forState:UIControlStateNormal];
    [bottomRightView setImage:imageNameAndType(@"home_item2", @"png") forState:UIControlStateDisabled];
    [self.view addSubview:bottomRightView];
    
    UIButton *promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [promptButton setBackgroundColor:color(clearColor)];
    [promptButton setBackgroundImage:imageNameAndType(@"home_prompt", @"png") forState:UIControlStateNormal];
    [promptButton setTitle:@"3" forState:UIControlStateNormal];
    [promptButton setFrame:CGRectMake(bottomRightView.frame.size.width - 5 - 35, 0 + 30, 35, 35)];
    [promptButton addTarget:self action:@selector(pressPromptButton:) forControlEvents:UIControlEventTouchUpInside];
    [bottomRightView addSubview:promptButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self jumpToClassifyView];
}

- (void)jumpToClassifyView
{
    ClassifyViewController *viewController= [[ClassifyViewController alloc]init];
    [Model shareModel].mainView = viewController;
    [self pushViewController:viewController transitionType:TransitionFade completionHandler:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
