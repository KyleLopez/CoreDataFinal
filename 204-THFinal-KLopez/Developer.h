//
//  Developer.h
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Developer : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * speciality;

@end
