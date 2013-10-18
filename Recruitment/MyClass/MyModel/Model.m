//
//  Model.m
//  Recruitment
//
//  Created by M J on 13-10-16.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "Model.h"

static      Model       *shareModel;

@implementation Model

+ (Model*)shareModel
{
    @synchronized(self){
        if (!shareModel) {
            shareModel = [[Model alloc]init];
        }
    }
    return shareModel;
}

@end
