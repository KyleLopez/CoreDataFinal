//
//  KLViewController.m
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import "KLViewController.h"
#import "KLDeveloperData.h"
#import "KLDetailViewController.h"
#import "Developer.h"

@interface KLViewController () {
    NSIndexPath *storedIndexPath;
}

@end

@implementation KLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [((KLDeveloperData*)self.table.dataSource) fetchData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeSort:(UISegmentedControl*)sender {
    [((KLDeveloperData*)self.table.dataSource) resort:sender.selectedSegmentIndex];
    [self.table reloadData];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KLDetailViewController *vc = [segue destinationViewController];
    
    storedIndexPath = [self.table indexPathForCell:(UITableViewCell*)sender];
    
    if (storedIndexPath.row != 0) {
        vc.dev = [((KLDeveloperData*)self.table.dataSource) developerAtIndexPath:storedIndexPath];
    }
    else {
        vc.dev = [((KLDeveloperData*)self.table.dataSource) emptyDeveloper];
    }
}

-(IBAction)cancelButton:(UIStoryboardSegue*)segue
{
    [((KLDeveloperData*)self.table.dataSource) rollback];
    
    [self.table deselectRowAtIndexPath:storedIndexPath animated:YES];
}

-(IBAction)saveButton:(UIStoryboardSegue*)segue
{
    KLDetailViewController *source = [segue sourceViewController];
    [((KLDeveloperData*)self.table.dataSource) saveDeveloper:source.dev atIndexPath:storedIndexPath];
    
    [self.table deselectRowAtIndexPath:storedIndexPath animated:YES];
    
    [self.table reloadData];
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return UITableViewCellEditingStyleNone;
    return UITableViewCellEditingStyleDelete;
}

@end
