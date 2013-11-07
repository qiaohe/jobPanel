//
//  MyResumeDetail.m
//  Recruitment
//
//  Created by M J on 13-10-18.
//  Copyright (c) 2013年 M J. All rights reserved.
//

#import "MyResumeDetail.h"

@implementation MyResumeDetail

static NSInteger i = 0;

+(NSArray*)getRecommendDataWithNum:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    i = 0;
    for (int i = 0; i<num; i++) {
        MyResumeDetail *detail = [[MyResumeDetail alloc]init];
        [array addObject:detail];
    }
    return array;
}

- (id)init
{
    self = [super init];
    if (self) {
        _userPicture        = imageNameAndType(@"resume_selectimage_normal", nil);
        i++;
        _resumeName = [NSString stringWithFormat:@"我的简历%d",i];
        
        _name               = @"李雷";
        _birthDate          = @"1990/05/11";
        _currentCompany     = @"网易";
        _currentJob         = @"UI设计师";
        _location           = @"上海";

        NSInteger index = (arc4random() % 4 ) + 1;
        switch (index) {
            case 1:{
                _creationTime = @"2012/06/11";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UI",@"设计",@"前端开发"]];
                break;
            }case 2:{
                _creationTime = @"2010/05/19";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级UE设计师"]];
                break;
            }case 3:{
                _creationTime = @"2012/03/15";
                _jobArray = [NSMutableArray arrayWithArray:@[@"高级Java工程师"]];
                break;
            }case 4:{
                _creationTime = @"2013/09/11";
                _jobArray = [NSMutableArray arrayWithArray:@[@"UE设计师",@"UI设计师",@"android高级开发工程师"]];
                break;
            }
            default:
                break;
        }
    }
    return self;
}


@end
