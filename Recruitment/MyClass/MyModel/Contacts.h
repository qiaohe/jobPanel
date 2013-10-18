//
//  Contacts.h
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject

@property (strong, nonatomic) NSString                  *title;
@property (strong, nonatomic) NSString                  *detail;
@property (strong, nonatomic) UIImage                   *userPicture;
@property (strong, nonatomic) NSString                  *location;
@property (assign, nonatomic) BOOL                      isUnfold;

@end
