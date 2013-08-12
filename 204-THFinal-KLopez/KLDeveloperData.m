//
//  KLDeveloperData.m
//  204-THFinal-KLopez
//
//  Created by Kyle Lopez on 5/28/13.
//  Copyright (c) 2013 Kyle Lopez. All rights reserved.
//

#import "KLDeveloperData.h"
#import <Parse/Parse.h>
#import "Developer.h"
#import "KLCell.h"
#import "KLAppDelegate.h"


@interface KLDeveloperData()
{
    BOOL sortLast;
    int storedSort;
}
@property (strong) NSMutableArray *devs;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@end

@implementation KLDeveloperData


-(id)init
{
    if(self = [super init]) {
        _devs = [NSMutableArray arrayWithCapacity:21];
        _managedObjectContext = [((KLAppDelegate*)[[UIApplication sharedApplication] delegate]) managedObjectContext];
        sortLast = NO;
    }
    return self;
}

-(void)fetchData
{   
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Developer" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil || mutableFetchResults.count == 0) {
        // Handle the error.
        PFQuery *query = [PFQuery queryWithClassName:@"iosDeveloper"];
        NSArray *devs = [query findObjects];
        for (PFObject *data in devs) {
            Developer *dev = (Developer *)[NSEntityDescription insertNewObjectForEntityForName:@"Developer" inManagedObjectContext:_managedObjectContext];
            [dev setFirstName:[data objectForKey:@"firstName"]];
            [dev setLastName:[data objectForKey:@"lastName"]];
            [dev setSpeciality:[data objectForKey:@"speciality"]];
            
            NSError *error = nil;
            if (![_managedObjectContext save:&error]) {
                // Handle the error.
                NSLog(@"Error adding: %@", error.localizedDescription);
                return;
            }
            
            [self.devs addObject:dev];
        }
        
        [self.devs sortUsingComparator:^(Developer *obj1, Developer *obj2){
            return [obj1.firstName compare:obj2.firstName];
        }];
        
        return;
    }
    
    self.devs = mutableFetchResults;
}

-(void)resort:(int)value
{
    storedSort = value;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Developer" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    NSString *sort = value == 0 ? @"firstName" : value == 1 ? @"lastName" : @"speciality";
    
    sortLast = value == 1;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sort ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResults == nil)
    {
        NSLog(@"Error Sorting");
        return;
    }
    self.devs = mutableFetchResults;
}

-(Developer*)developerAtIndexPath:(NSIndexPath*)indexPath
{
    return (Developer*)[self.devs objectAtIndex:(indexPath.row - 1)];
}

-(Developer*)emptyDeveloper
{
    Developer *dev = (Developer *)[NSEntityDescription insertNewObjectForEntityForName:@"Developer" inManagedObjectContext:_managedObjectContext];
    [dev setFirstName:@""];
    [dev setLastName:@""];
    [dev setSpeciality:@""];
    
    return dev;
}

-(void)saveDeveloper:(Developer*)developer atIndexPath:(NSIndexPath*)indexPath
{
    if(indexPath.row == 0)
    {
        [self.devs addObject:developer];
    }
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"Error adding: %@", error.localizedDescription);
        return;
    }
    
    [self resort:storedSort];
}

-(void)deleteDeveloper:(Developer*)developer {
    [_managedObjectContext deleteObject:developer];
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        // Handle the error.
        NSLog(@"Error adding event: %@", error.localizedDescription);
        return;
    }
}

-(void)rollback
{
    [_managedObjectContext rollback];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.devs count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"KLCell";
    KLCell *cell = (KLCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(indexPath.row == 0)
    {
        cell.nameLabel.text = @"Add Developer";
        cell.specialityLabel.text = @"+";
        
        return cell;
    }
    
    Developer *dev = (Developer*)[self.devs objectAtIndex:(indexPath.row - 1)];
    
    if (sortLast) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@, %@",[dev lastName],[dev firstName]];
    }
    else {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@",[dev firstName],[dev lastName]];
    }
    cell.specialityLabel.text = [dev speciality];
    
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return NO;
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object at the given index path.
        NSManagedObject *developerToDelete = [self.devs objectAtIndex:indexPath.row];
        [_managedObjectContext deleteObject:developerToDelete];
        
        // Update the array and table view.
        [self.devs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        
        // Commit the change.
        NSError *error = nil;
        if (![_managedObjectContext save:&error]) {
            // Handle the error.
        }
    }
}

@end
