//
//  ShakeViewController.h
//  Recruitment
//
//  Created by Jack Wang on 10/31/13.
//  Copyright (c) 2013 M J. All rights reserved.
//

#import "BaseUIViewController.h"
#import "ContactsStatusViewController.h"
#import "CompanyDetail.h"
#import <AudioToolbox/AudioToolbox.h>


@interface ShakeViewController : BaseUIViewController{
    ContactsStatusCell *cell;
    CompanyDetail *jobDetail;
    SystemSoundID messageSound;
}

@property (strong, nonatomic) NSMutableArray            *dataSource;

@end
