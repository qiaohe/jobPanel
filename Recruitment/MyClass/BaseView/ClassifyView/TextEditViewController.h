//
//  TextEditViewController.h
//  Recruitment
//
//  Created by M J on 13-11-5.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "BaseUIViewController.h"

typedef NS_OPTIONS(NSInteger, TextEditType){
    TextEditPersonalLight,
    TextEditReferralCommend
};

@protocol TextEditDelegate <NSObject>

- (void)editDone:(NSString*)string;

@end

@interface TextEditViewController : BaseUIViewController<UITextViewDelegate>

@property (assign, nonatomic) id <TextEditDelegate> delegate;
@property (strong, nonatomic) UITextView            *textDetail;
@property (assign, nonatomic) TextEditType          type;

- (id)initWithType:(TextEditType)initType;

@end
