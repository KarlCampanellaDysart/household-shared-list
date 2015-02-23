//
//  ViewController.m
//  jill_project
//
//  Created by Karl Campanella-Dysart on 12/23/14.
//  Copyright (c) 2014 Karl Campanella-Dysart. All rights reserved.
//

#import "KCDLoginViewController.h"

@interface KCDLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *tableViewOutlet;

@property BOOL isMakingNewHouseHold;
@property (strong, nonatomic) NSString *passwordReal;

@end

@implementation KCDLoginViewController

- (IBAction)backButton:(id)sender {
    self.navBar.hidden = true;
    self.tableViewOutlet.hidden = true;
    self.navigationController.navigationBarHidden = false;
}

- (IBAction)showNearMe:(id)sender {
    //[self getEntityByLocation];
    [self.tableView reloadData];
    self.navigationController.navigationBarHidden = true;
    self.navBar.hidden = false;
    self.tableViewOutlet.hidden = false;
}

- (IBAction)loginToExisting:(id)sender {
    self.isMakingNewHouseHold = false;
    [self getEntityWithName:self.textInput.text];
}

- (IBAction)createNew:(id)sender {
    self.isMakingNewHouseHold = true;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter password" message:@"  " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)getEntityByLocation{
    //specify the entity type to be retrieved
    NSString *type = @"household";
    ApigeeQuery *qs = [[ApigeeQuery alloc] init];
    
    //add the location query to the query
    [qs addRequiredWithin:@"location" latitude:[self.latitude floatValue] longitude:[self.longitude floatValue] distance:500.00];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ApigeeClientResponse *response = [appDelegate.dataClient getEntities:type query:qs];
    
    NSDictionary * allData = [[NSDictionary alloc] initWithDictionary:response.response];
    NSArray * entities = [[NSArray alloc] initWithArray:[allData objectForKey:@"entities"]];
    
    @try {
        if ([entities count] != 0){
            self.userQuerry = entities;
        }
        else{
            UIAlertView *cantLogin = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No HouseHolds around you" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
            [cantLogin show];
        }
    }
    @catch (NSException * e) {}
}

-(void)getEntityWithName: (NSString *)name {
    //specify the entity type to be retrieved
    NSString *type = @"household";
    NSString *query = [NSString stringWithFormat: @"name = '%@'", name];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    ApigeeClientResponse *response = [appDelegate.dataClient getEntities:type queryString:query];
    NSDictionary * allData = [[NSDictionary alloc] initWithDictionary:response.response];
    NSArray * entities = [[NSArray alloc] initWithArray:[allData objectForKey:@"entities"]];
    
    @try {
        if ([entities count] != 0){
            //retrieve password
            NSDictionary * firstDataInQuerry = [[NSDictionary alloc] initWithDictionary:[entities objectAtIndex:0]];
            self.passwordReal = [[NSString alloc] initWithString:[firstDataInQuerry objectForKey:@"password"]];
            self.userHouseHold.houseHold = firstDataInQuerry;
            
            //password check
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter password" message:@"  " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alert show];
        }
        else{
            UIAlertView *cantLogin = [[UIAlertView alloc] initWithTitle:@"Error" message:@"HouseHold doesn't exist" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
            [cantLogin show];
        }
    }
    @catch (NSException * e) {}
}

-(void) newEntityWithPass:(NSString *) pass{
    //create an entity object
    NSMutableDictionary *houseHold = [[NSMutableDictionary alloc] init];
    NSMutableArray *notifications = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *locationData = [[NSMutableDictionary alloc] init];
    [locationData setObject:self.latitude forKey:@"latitude"];
    [locationData setObject:self.longitude forKey:@"longitude"];

    //Set entity properties
    [houseHold setObject:self.textInput.text forKey:@"name"];
    [houseHold setObject:@"household" forKey:@"type"];
    [houseHold setObject:pass forKey:@"password"]; //Required. New entity type to create
    [houseHold setObject:locationData forKey:@"location"];
    [houseHold setObject:notifications forKey:@"notifications"];
    
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    ApigeeClientResponse *response = [appDelegate.dataClient createEntity:houseHold];
    NSDictionary * allData = [[NSDictionary alloc] initWithDictionary:response.response];
    self.userHouseHold.houseHold = allData;
    @try {}
    @catch (NSException * e) {}
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"login"]){
        self.navigationController.navigationBarHidden = false;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *text = [alertView textFieldAtIndex:0].text;
        if(self.isMakingNewHouseHold){
            [self newEntityWithPass:text];
            
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else{
            if([text isEqualToString:self.passwordReal]){
                //login
                
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            else{
                //incorrect password
                UIAlertView *incorrectPass = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect password" delegate:self cancelButtonTitle:@"Exit" otherButtonTitles: nil];
                [incorrectPass show];
            }
        }
    }
}

/////////////////TABLE VIEW///////////////////////

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView{
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section{
    NSLog(@"%lu",(unsigned long)[self.userQuerry count]);
    return [self.userQuerry count];
}

- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath{
    static NSString * CellIdentifier = @"householdCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [[self.userQuerry objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    //NSLog(@"%@",cell.textLabel.text);
    return cell;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete){
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(editingStyle==UITableViewCellEditingStyleInsert){}

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isMakingNewHouseHold = false;
    [self getEntityWithName:[[self.userQuerry objectAtIndex:indexPath.row] objectForKey:@"name"]];
}



/////////////////END TABLE VIEW///////////////////


/////////////////LOCATION/////////////////////////

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        self.location = _locationManager.location;
        self.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
        self.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
        [self getEntityByLocation];
    }
}
/////////////////END LOCATION/////////////////////


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //table view
    self.tableView.delegate = self;
    
    self.userHouseHold = [KCDMyHouseHold sharedModel];
    
    //location updates
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500; // meters
    [self.locationManager startUpdatingLocation];
    
    //setup initial location
    self.location = [[CLLocation alloc] init];
    self.location = _locationManager.location;
    
    self.latitude = [NSNumber numberWithDouble:self.location.coordinate.latitude];
    self.longitude = [NSNumber numberWithDouble:self.location.coordinate.longitude];
    [self getEntityByLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
