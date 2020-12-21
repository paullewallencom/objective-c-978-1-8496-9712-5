//
//  CustomerRecordsViewController.m
//  CoreData
//
//  Created by Gibson Tang on 20/3/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import "CustomerRecordsViewController.h"

@interface CustomerRecordsViewController ()
@property (strong) NSMutableArray *customers;
@end

@implementation CustomerRecordsViewController
@synthesize tblView;

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
    // Do any additional setup after loading the view.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Get the context first
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    //load data from Customer entity
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Customer"];
    self.customers = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [tblView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.customers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSManagedObject *customer = [self.customers objectAtIndex:indexPath.row];
    NSLog(@"Age is %d", [[customer valueForKey:@"age"] intValue]);
        
    UILabel *nameLbl = (UILabel *)[cell viewWithTag:1];
    [nameLbl setText:[NSString stringWithFormat:@"%@ : %@", [nameLbl text],
                      [customer valueForKey:@"name"]]];
    
    
    int age = [[customer valueForKey:@"age"] integerValue];
    UILabel *ageLbl = (UILabel *)[cell viewWithTag:2];
    [ageLbl setText:[NSString stringWithFormat:@"%@ : %d", [ageLbl text], age]];
    
    
    UILabel *addressLbl = (UILabel *)[cell viewWithTag:3];
    [addressLbl setText:[NSString stringWithFormat:@"%@ : %@", [addressLbl text],
                     [customer valueForKey:@"address"]]];
    
    UILabel *phoneLbl = (UILabel *)[cell viewWithTag:5];
    [phoneLbl setText:[NSString stringWithFormat:@"%@ : %@", [phoneLbl text],
                         [customer valueForKey:@"phone_number"]]];

                     
    UILabel *emailLbl = (UILabel *)[cell viewWithTag:4];
    [emailLbl setText:[NSString stringWithFormat:@"%@ : %@", [emailLbl text],
                       [customer valueForKey:@"email"]]];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO as you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObject *obj = [self.customers objectAtIndex:indexPath.row];
        [context deleteObject: obj];
        
        NSError *error = nil;
        NSString *str;
        // Attempt to delete record from database
        if (![context save:&error]) {
            str = @"Cannot delete record! %@", [error localizedDescription];
            NSLog(@"%@", str);
        }
        else
        {
            // Remove customer from table view
            [self.customers removeObject:obj];
            
            //update tableview
            [tblView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                           withRowAnimation:UITableViewRowAnimationNone];
            str = @"Record removed";
            NSLog(@"%@", str);
        }
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                        message:str delegate:self
                                cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
