//
//  KLDeveloperData.h
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Developer;

@interface KLDeveloperData : NSObject <UITableViewDataSource>

-(void)fetchData;
-(void)resort:(int)value;
-(Developer*)developerAtIndexPath:(NSIndexPath*)indexPath;
-(Developer*)emptyDeveloper;
-(void)saveDeveloper:(Developer*)developer atIndexPath:(NSIndexPath*)indexPath;
-(void)deleteDeveloper:(Developer*)developer;
-(void)rollback;
@end
