//
//  KLDetailViewController.m
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import "KLDetailViewController.h"
#import "Developer.h"

@interface KLDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *specialtyField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation KLDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.firstNameField.text = [self.dev firstName];
    self.lastNameField.text = [self.dev lastName];
    self.specialtyField.text = [self.dev speciality];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard:(id)sender
{
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.specialtyField resignFirstResponder];
}

- (IBAction)editsDone:(id)sender {
    self.saveButton.hidden = NO;
    [self.backButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.backButton setTitle:@"Cancel" forState:UIControlStateSelected];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.dev setFirstName:self.firstNameField.text];
    [self.dev setLastName:self.lastNameField.text];
    [self.dev setSpeciality:self.specialtyField.text];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

@end
