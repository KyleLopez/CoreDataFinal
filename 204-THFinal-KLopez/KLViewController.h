//
//  KLViewController.h
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Developer;

@interface KLViewController : UIViewController <UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *table;
@property (nonatomic,strong) Developer *returnedDeveloper;

@end
