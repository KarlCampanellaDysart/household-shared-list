//
//  UIViewController+KCDTableViewController.m
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDTableViewController.h"

@interface KCDTableViewController ()

@end

@implementation KCDTableViewController

- (IBAction)addNotification:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter a new notification" message:@"  " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *text = [alertView textFieldAtIndex:0].text;
        NSLog(@"THis is %@", self.userHouseHold.typeNotification);
        NSMutableDictionary *newNotification = [ [NSMutableDictionary alloc]initWithObjects:@[self.userHouseHold.typeNotification,text] forKeys:@[@"type",@"text"]];
        
        [self.userHouseHold.userQuerry addObject:newNotification];
        [self.userHouseHold.allQuerry addObject:newNotification];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self updateNotifications];
    }
}

-(void)updateNotifications{
    //UUID of the entity to be updated
    NSString *entityID = [self.userHouseHold.houseHold objectForKey:@"uuid"];
    
    //Create an entity object
    
    NSMutableDictionary *houseHold = [[NSMutableDictionary alloc] init];
    
    //Set entity properties
    [houseHold setObject:[self.userHouseHold.houseHold objectForKey:@"name"] forKey:@"name"];
    [houseHold setObject:@"household" forKey:@"type"];
    [houseHold setObject:[self.userHouseHold.houseHold objectForKey:@"password"] forKey:@"password"];
    [houseHold setObject:[self.userHouseHold.houseHold objectForKey:@"location"] forKey:@"location"];
    [houseHold setObject:self.userHouseHold.allQuerry forKey:@"notifications"];

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    ApigeeClientResponse *response = [appDelegate.dataClient updateEntity:entityID entity:houseHold];
    
    @try {
    }
    @catch (NSException * e) {}
}

////table view////

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section{
    NSLog(@"%lu",(unsigned long)[self.userHouseHold.userQuerry count]);
    return [self.userHouseHold.userQuerry count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath{
    static NSString * CellIdentifier = @"notificationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[self.userHouseHold.userQuerry objectAtIndex:indexPath.row] objectForKey:@"text"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.userHouseHold.allQuerry removeObject:[self.userHouseHold.userQuerry objectAtIndex:indexPath.row]];
        [self.userHouseHold.userQuerry removeObjectAtIndex:indexPath.row];
        [self updateNotifications];
    }
    else if(editingStyle==UITableViewCellEditingStyleInsert){}
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.userHouseHold = [KCDMyHouseHold sharedModel];
}

@end
