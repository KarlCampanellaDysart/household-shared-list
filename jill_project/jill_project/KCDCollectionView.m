//
//  UIViewController+KCDLoginTableView.m
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/24/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDCollectionView.h"

@interface KCDCollectionView ()

@end

@implementation KCDCollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (NSInteger)collectionView: (UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    // data is an array that holds info for the collection view
    //return [self.places count];
    return [self.relavantNotifications count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    KCDCollectionCellView * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"notificationType" forIndexPath:indexPath];
    
    // Call CollectionViewCell method to set up cell
    [cell setCell: [self.relavantNotifications objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation)
toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)
    [self.collectionView collectionViewLayout];
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        NSLog(@"flipped");
    } else {
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"viewNotification"]){
        NSArray* indexPathArray = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = indexPathArray[0];
        
        NSMutableArray *notifications = [[NSMutableArray alloc]initWithArray:[self.userHouseHold.houseHold objectForKey:@"notifications"]];
        NSString *typeNotif =[[NSString alloc] initWithString:[[self.relavantNotifications objectAtIndex:indexPath.row] objectForKey:@"name"]];
        
        self.userHouseHold.allQuerry = notifications;
        self.userHouseHold.typeNotification = typeNotif;
        
        [self.userHouseHold populateNotifications];
    }
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.userHouseHold = [KCDMyHouseHold sharedModel];
    self.relavantNotifications = [[NSMutableArray alloc] init];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjects:@[@"Chores", @"chores.png"] forKeys:@[@"name",@"image"]];
    [self.relavantNotifications addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjects:@[@"Issues", @"issues.png"] forKeys:@[@"name",@"image"]];
    [self.relavantNotifications addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjects:@[@"Broken", @"broken.png"] forKeys:@[@"name",@"image"]];
    [self.relavantNotifications addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjects:@[@"To Buy", @"toBuy.png"] forKeys:@[@"name",@"image"]];
    [self.relavantNotifications addObject:dict];
    
    dict = [NSDictionary dictionaryWithObjects:@[@"Notifications", @"issues.png"] forKeys:@[@"name",@"image"]];
    [self.relavantNotifications addObject:dict];
}


@end
