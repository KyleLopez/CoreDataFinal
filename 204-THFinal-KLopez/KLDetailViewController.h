//
//  KLDetailViewController.h
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Developer;

@interface KLDetailViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic,strong) Developer *dev;

@end
