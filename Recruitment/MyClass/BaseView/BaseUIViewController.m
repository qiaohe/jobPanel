//
//  BaseUIViewController.m
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "ClassifyViewController.h"

@interface BaseUIViewController ()

@property (strong, nonatomic) UIImageView           *backGroundImageView;
@property (strong, nonatomic) NSMutableArray        *responderArray;
@property (strong, nonatomic) UILabel               *titleLabel;

@end

@implementation BaseUIViewController

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
        self.view.frame = CGRectMake(0, 0, appFrame.size.width, appFrame.size.height);
        _contentView = [[BaseContentView alloc]initWithFrame:self.view.frame];
        _contentView.superResponder = self;
        [self.view addSubview:_contentView];
        _responderArray = [NSMutableArray array];
    }
    return self;
}

- (void)setBackGroundImage:(UIImage*)image
{
    if (image) {
        if (!_backGroundImageView) {
            _backGroundImageView = [[UIImageView alloc]init];
            [_backGroundImageView setFrame:self.view.bounds];
            [_backGroundImageView setBackgroundColor:[UIColor clearColor]];
            if (_contentView) {
                [self.view insertSubview:_backGroundImageView belowSubview:_contentView];
            }else
                [self.view addSubview:_backGroundImageView];
        }
        [_backGroundImageView setImage:image];
    }else{
        if (_backGroundImageView && _backGroundImageView.superview) {
            [_backGroundImageView removeFromSuperview];
        }
    }
}

- (void)setTopBarBackGroundImage:(UIImage*)image
{
    if (!_topBar) {
        _topBar = [[UIImageView alloc]init];
        [_topBar setFrame:CGRectMake(0, 0, appFrame.size.width, 40)];
        [_topBar setBackgroundColor:[UIColor clearColor]];
        if (_titleLabel) {
            [self.view insertSubview:_topBar belowSubview:_titleLabel];
        }else
            [self.view addSubview:_topBar];
    }
    if (image) {
        [_topBar setImage:image];
    }else{
        [_topBar removeFromSuperview];
    }
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, 0, self.view.frame.size.width/2, 40)];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.view addSubview:_titleLabel];
    }
    [_titleLabel setText:title];
}

- (void)setBottomBarBackGroundImage:(UIImage*)image
{
    if (!_bottomBar) {
        _bottomBar = [self createBottomBar];
    }
    [_bottomBar setImage:image forState:UIControlStateNormal];
    [_bottomBar setImage:image forState:UIControlStateHighlighted];
    [_bottomBar setImage:image forState:UIControlStateDisabled];
}

- (void)setBottomBarItems:(NSArray*)items
{
    if (!_bottomBar) {
        _bottomBar = [self createBottomBar];
    }
    for (int i = [items count]; i > 0 ; i--) {
        UIButton *item = [items objectAtIndex:([items count] - i)];
        [item setFrame:CGRectMake(self.view.frame.size.width - 50 * i - 15, 0, 70, 35)];
        [item setBounds:CGRectMake(0, 0, item.frame.size.width*4/5, item.frame.size.height*4/5)];
        [_bottomBar addSubview:item];
    }
}

- (UIButton*)createBottomBar
{
    UIButton *bottomBar = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBar setBackgroundColor:[UIColor clearColor]];
    [bottomBar setTag:101];
    [bottomBar setFrame:CGRectMake(0, self.view.frame.size.height - 35, self.view.frame.size.width, 35)];
    [self.view addSubview:bottomBar];

    return bottomBar;
}

- (void)setReturnButton:(UIButton*)button
{
    [button addTarget:self action:@selector(returnToPrevView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setPopToMainViewButton:(UIButton*)button
{
    [button addTarget:self action:@selector(popToMainView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)returnToPrevView:(UIButton*)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popToMainView:(UIButton*)sender
{
    if (self.navigationController) {
        if (![Model shareModel].mainView) {
            [Model shareModel].mainView = [[ClassifyViewController alloc]init];
        }if (![self.navigationController.viewControllers containsObject:[Model shareModel].mainView]) {
            [self.navigationController pushViewController:[Model shareModel].mainView animated:YES];
        }else{
            [self.navigationController popToViewController:[Model shareModel].mainView animated:YES];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self clearKeyBoard];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - keyboard handle
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self clearKeyBoard];
}

- (BOOL)clearKeyBoard
{
    //subview rewrite
    return YES;
}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    //subview rewrite
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    //subview rewrite
}

- (void)keyBoardChangeFrame:(NSNotification *)notification
{
    //subview rewrite
}

- (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView)
        {
            return keyboardView;
        }
    }
    return nil;
}

- (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }
        else
        {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView)
            {
                return tempView;
            }
        }
    }
    return nil;
}

- (CGRect)frameWithRect:(CGRect)rect adaptWidthOrHeight:(adaptType)adapt
{
    CGFloat width;
    CGFloat height;
    if (adapt == adaptNone) {
        width = rect.size.width  * appFrame.size.width/ footScreenSize.width;
        height = rect.size.height * appFrame.size.height/ footScreenSize.height;
    }else if(adapt == adaptWidth){
        width = rect.size.width * appFrame.size.width/ footScreenSize.width ;
        height = width*rect.size.height/rect.size.width;
    }else {
        height = rect.size.height * appFrame.size.height/ footScreenSize.height ;
        width = height*rect.size.width/rect.size.height;
    }
    return CGRectMake((rect.origin.x  * appFrame.size.width/ footScreenSize.width), (rect.origin.y  * appFrame.size.height/footScreenSize.height), width, height);
}
- (void)pushViewController:(BaseUIViewController*)_viewController transitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler
{
    if (self.navigationController) {
        [self.navigationController pushViewController:_viewController animated:NO];
        CATransition *transition = [Utils getAnimation:_transitionType subType:DirectionRight];
        [self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
        [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
    }
}

- (void)pushViewController:(BaseUIViewController*)_viewController transitionType:(TransitionType)_transitionType Direction:(Direction)_direction completionHandler:(void (^) (void))_compleHandler
{
    if (self.navigationController) {
        [self.navigationController pushViewController:_viewController animated:NO];
        CATransition *transition = [Utils getAnimation:_transitionType subType:_direction];
        [self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
        [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
    }
}

- (void)pushViewControllers:(NSArray*)viewControllers transitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler
{
    for (UIViewController *_viewController in viewControllers) {
        if (viewControllers.lastObject != _viewController) {
            if (self.navigationController) {
                [self.navigationController pushViewController:_viewController animated:NO];
            }
        }else{
            [self.navigationController pushViewController:_viewController animated:NO];
            CATransition *transition = [Utils getAnimation:_transitionType subType:DirectionRight];
            [self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
            [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
        }
    }
}


- (void)popViewControllerTransitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
        //CATransition *transition = [Utils getAnimation:_transitionType subType:DirectionLeft];
        //[self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
        [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
    }
}

- (void)popToMainViewControllerTransitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler
{
    if (self.navigationController) {
        [self.navigationController popToViewController:[Model shareModel].mainView animated:NO];
        CATransition *transition = [Utils getAnimation:_transitionType subType:DirectionLeft];
        [self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
        [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
    }
}

- (void)popToViewController:(BaseUIViewController*)_viewController transitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler
{
    if (self.navigationController) {
        [self.navigationController popToViewController:_viewController animated:YES];
        CATransition *transition = [Utils getAnimation:_transitionType subType:DirectionLeft];
        [self.navigationController.view.layer addAnimation:transition forKey:@"viewtransition"];
        [self performSelector:@selector(completionHandler:) withObject:_compleHandler afterDelay:transitionDuration];
    }
}

- (void)completionHandler:(void (^) (void))_compleHandler
{
    if (_compleHandler) {
        _compleHandler();
    }
    [self.navigationController.view.layer removeAnimationForKey:@"viewtransition"];
}

@end

@implementation BaseContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _baseRect = frame;
    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    if (!_largeHeight ) {
        _largeHeight = self;
    }if (!_largeWidth) {
        _largeWidth = self;
    }
    if (controlXLength(_largeWidth) < controlXLength(view)) {
        [self setXSize];
    }if (controlYLength(_largeHeight) < controlYLength(view)) {
        [self setYSize];
    }
}

- (void)removeSubview:(UIView*)subview
{
    [subview removeFromSuperview];
    [self resetContentSize];
}

- (void)removeAllSubview
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    [self resetContentSize];
}

- (void)resetContentSize
{
    [self setXSize];
    [self setYSize];
}

- (void)setXSize
{
    if ([self.subviews count] != 0) {
        NSComparator cmptr = ^(UIView *obj1, UIView *obj2){
            if (controlXLength(obj1) >= controlXLength(obj2)) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if (controlXLength(obj1) < controlXLength(obj2)) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *array = [self.subviews sortedArrayUsingComparator:cmptr];
        
        _largeWidth = [array lastObject];
        
        CGFloat contentWidth = controlXLength(_largeWidth) > self.frame.size.width?controlXLength(_largeWidth) + 10:self.frame.size.width;
        
        [self setContentSize:CGSizeMake(contentWidth,self.contentSize.height)];
    }else{
        [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    }
}

- (void)setYSize
{
    if ([self.subviews count] != 0) {
        NSComparator cmptr = ^(UIView *obj1, UIView *obj2){
            if (controlYLength(obj1) >= controlYLength(obj2)) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if (controlYLength(obj1) < controlYLength(obj2)) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *array = [self.subviews sortedArrayUsingComparator:cmptr];
        
        _largeHeight = [array lastObject];
        
        CGFloat contentHeight = controlYLength(_largeHeight) > self.frame.size.width?controlYLength(_largeHeight) + 40:self.frame.size.width;
        
        [self setContentSize:CGSizeMake(self.contentSize.width, contentHeight)];
    }else{
        [self setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    }
}

- (NSInteger)getXPageNum:(UIView*)view
{
    CGFloat pageNum = controlXLength(view)/self.frame.size.width;
    NSInteger integerNum = [[NSString stringWithFormat:@"%.0f",pageNum] integerValue];
    integerNum = pageNum > integerNum ? integerNum + 1 : integerNum;
    
    return integerNum > 0?integerNum:1;
}

- (NSInteger)getYPageNum:(UIView*)view
{
    CGFloat pageNum = controlYLength(view)/self.frame.size.width;
    NSInteger integerNum = [[NSString stringWithFormat:@"%.0f",pageNum] integerValue];
    integerNum = pageNum > integerNum ? integerNum + 1 : integerNum;
    
    return integerNum > 0?integerNum:1;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superResponder touchesEnded:touches withEvent:event];
}

@end




