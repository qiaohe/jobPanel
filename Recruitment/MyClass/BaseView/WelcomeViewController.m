//
//  WelcomeViewController.m
//  Recruitment
//
//  Created by M J on 13-10-31.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RegisterViewController.h"
#import "CustomSwipeGestureRecognizer.h"

@interface WelcomeViewController ()

@property (strong, nonatomic) NSArray           *imageSource;
@property (strong, nonatomic) NSArray           *promptDataSource;

@property (assign, nonatomic) BOOL              jumped;

@end

@implementation WelcomeViewController

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
        _jumped = NO;
        [self.contentView setPagingEnabled:YES];
        [self.contentView setBounces:NO];
        [self.contentView setShowsHorizontalScrollIndicator:NO];
        [self.contentView setShowsVerticalScrollIndicator:NO];
        _imageSource = @[@"leadImage1",@"leadImage2",@"leadImage3"];
        _promptDataSource = @[[NSString stringWithFormat:@""],@"",@""];
        [self setSubviewFrame];
    }
    return self;
}

- (void)setSubviewFrame
{
    UIImageView *treeLogo = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80/2, 25, 80, 100)];
    [treeLogo setBackgroundColor:color(clearColor)];
    [treeLogo setImage:imageNameAndType(@"home_treelogo", @"png")];
    [self.view addSubview:treeLogo];
    
    for (int i = 0; i<[_imageSource count]; i++) {
        NSString *imageName = [_imageSource objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [imageView setBackgroundColor:color(clearColor)];
        [imageView setImage:[UIImage imageWithData:UIImageJPEGRepresentation(imageNameAndType(imageName, @"png"), 0.5) scale:0.5]];
        
        [self.contentView addSubview:imageView];
    }
    CustomSwipeGestureRecognizer *leftSwipeGestureRecognizer = [[CustomSwipeGestureRecognizer alloc]init];
    
    [leftSwipeGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [leftSwipeGestureRecognizer setDelegate:self];
    [self.contentView addGestureRecognizer:leftSwipeGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    CustomSwipeGestureRecognizer *swipeGesture = nil;
    if ([gestureRecognizer isMemberOfClass:[CustomSwipeGestureRecognizer class]]) {
        swipeGesture = (CustomSwipeGestureRecognizer*)gestureRecognizer;
    }else if ([otherGestureRecognizer isMemberOfClass:[CustomSwipeGestureRecognizer class]]){
        swipeGesture = (CustomSwipeGestureRecognizer*)otherGestureRecognizer;
    }
    
    if (swipeGesture) {
        if (self.contentView.contentOffset.x >= self.contentView.contentSize.width - self.contentView.frame.size.width) {
            if (!_jumped) {
                _jumped = YES;
                RegisterViewController *viewController = [[RegisterViewController alloc]init];
                Direction direction;
                switch (swipeGesture.direction) {
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
        }
    }
    return YES;
}

- (void)panning:(UISwipeGestureRecognizer*)swipeGesture
{
    if (self.contentView.contentOffset.x >= self.contentView.contentSize.width - self.contentView.frame.size.width) {
        RegisterViewController *viewController = [[RegisterViewController alloc]init];
        Direction direction;
        switch (swipeGesture.direction) {
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
