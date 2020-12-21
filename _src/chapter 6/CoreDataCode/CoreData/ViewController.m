//
//  ViewController.m
//  Storyboard
//
//  Created by Gibson Tang on 30/6/13.
//  Copyright (c) 2013 Gibson Tang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize searchTxtField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) searchByName:(id)sender {
    NSLog(@"Searching by name");
    
    if ([[searchTxtField text] length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                        message:@"Text field must not be empty" delegate:self
                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        return;
    }
    else
    {
        NSManagedObjectContext *context = nil;
        id delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate performSelector:@selector(managedObjectContext)]) {
            context = [delegate managedObjectContext];
        }//prepare the context for saving
        
        NSString *strSearch = [searchTxtField text];
        NSLog(@"Searching for name '%@'", strSearch);
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
        [fetchRequest setSortDescriptors:nil];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",
                                  strSearch];
        [fetchRequest setPredicate:predicate];
         NSError *error = nil;

         NSArray *fetchResults = [context executeFetchRequest:fetchRequest error:&error];
        int count = [fetchResults count];
        
        NSLog(@"Found %d records", count);
        if (count == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"No results found" delegate:self
                                cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];

        }
        else
        {
            customer = [fetchResults objectAtIndex:0];//get the 1st record
            [self performSegueWithIdentifier:@"AddCustomer" sender:self];
        }
    }
}

- (void) goAddRecord:(id)sender
{
    customer = nil;
    [self performSegueWithIdentifier:@"AddCustomer" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddCustomer"]) {
        NSLog(@"prepareForSegue calling AddCustomer");
        AddRecordViewController *controller = [segue destinationViewController];
        controller.customer = customer;
    }
}

@end
