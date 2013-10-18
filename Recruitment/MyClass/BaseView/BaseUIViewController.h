//
//  BaseUIViewController.h
//  Recruitment
//
//  Created by M J on 13-10-12.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"
#import "Model.h"

#define                 footScreenSize                  CGSizeMake(320,460)
#define                 rect(rect,adapt)                [self frameWithRect:rect adaptWidthOrHeight:adapt]

@class BaseContentView;

@protocol BaseContentViewDelegate <NSObject>

@optional
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end


typedef NS_OPTIONS(NSInteger, adaptType){
    adaptNone,
    adaptWidth,
    adaptHeight
};


@interface BaseUIViewController : UIViewController<BaseContentViewDelegate>

@property (strong, nonatomic, setter = setTopBar:)  UIImageView         *topBar;
@property (strong, nonatomic)                       UIButton            *bottomBar;

@property (strong, nonatomic)                       BaseContentView     *contentView;

- (void)setBackGroundImage:(UIImage*)image;
- (void)setTopBarBackGroundImage:(UIImage*)image;

- (void)setBottomBarBackGroundImage:(UIImage*)image;
- (void)setBottomBarItems:(NSArray*)items;

- (void)setReturnButton:(UIButton*)button;
- (void)setPopToMainViewButton:(UIButton*)button;

- (void)keyBoardWillShow:(NSNotification *)notification;
- (void)keyBoardWillHide:(NSNotification *)notification;
- (void)keyBoardChangeFrame:(NSNotification *)notification;

- (UIView *)findKeyboard;

- (CGRect)frameWithRect:(CGRect)rect adaptWidthOrHeight:(adaptType)adapt;

- (void)pushViewController:(BaseUIViewController*)_viewController transitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler;
- (void)popViewControllerTransitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler;
- (void)popToMainViewControllerTransitionType:(TransitionType)_transitionType completionHandler:(void (^) (void))_compleHandler;

@end

@interface BaseContentView : UIScrollView

@property (assign, nonatomic) id <BaseContentViewDelegate>      superResponder;
@property (strong, nonatomic) UIView                            *largeWidth;
@property (strong, nonatomic) UIView                            *largeHeight;

- (void)removeSubview:(UIView*)subview;

@end






