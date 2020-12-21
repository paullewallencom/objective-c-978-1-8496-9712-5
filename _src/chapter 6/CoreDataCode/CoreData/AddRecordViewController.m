//
//  AddRecordViewController.m
//  CoreData
//
//  Created by Gibson Tang on 20/3/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import "AddRecordViewController.h"

@interface AddRecordViewController ()

@end

@implementation AddRecordViewController
@synthesize nameTxtField, phoneTxtField, emailTxtField, addressTxtField,
ageTxtField;
@synthesize customer;

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
    if (customer) {
        [nameTxtField setText:[customer valueForKey:@"name"]];
        [addressTxtField setText:[customer valueForKey:@"address"]];
        [phoneTxtField setText:[customer valueForKey:@"phone_number"]];
        [emailTxtField setText:[customer valueForKey:@"email"]];
        NSString *strAge = [NSString stringWithFormat:@"%d",
                            [[customer valueForKey:@"age"] integerValue]];
        [ageTxtField setText:strAge];
    }
    else
    {
        [nameTxtField setText:@""];
        [addressTxtField setText:@""];
        [phoneTxtField setText:@""];
        [emailTxtField setText:@""];
        [ageTxtField setText:@""];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
    if ([nameTxtField text].length == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                message:@"Name must not be empty" delegate:self
                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSString *name = [nameTxtField text];
    NSString *phone = [phoneTxtField text];
    NSString *email = [emailTxtField text];
    NSString *address = [addressTxtField text];
    int age = [[ageTxtField text] intValue];
    
    //save using core data
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }//prepare the context for saving
    
    if (customer)//if we showing existing customer data
    {
        NSNumber *age = [NSNumber numberWithInt:[[ageTxtField text] intValue]];
        [customer setValue:[nameTxtField text] forKey:@"name"];
        [customer setValue:age forKey:@"age"];
        [customer setValue:[addressTxtField text] forKey:@"address"];
        [customer setValue:[emailTxtField text] forKey:@"email"];
        [customer setValue:[phoneTxtField text] forKey:@"phone_number"];
    }
    else
    {
        // Insert new object int the context
        NSManagedObject *newCustomer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:context];
        [newCustomer setValue:name forKey:@"name"];
        [newCustomer setValue:phone forKey:@"phone_number"];
        [newCustomer setValue:email forKey:@"email"];
        [newCustomer setValue:address forKey:@"address"];
        [newCustomer setValue:[NSNumber numberWithInteger:age] forKey:@"age"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    NSString *str;
    if (![context save:&error]) {
        str = [NSString stringWithFormat:@"Error saving %@ with localized description %@", error, [error localizedDescription]];
        NSLog(@"%@", str);
    }
    else
    {
        str = @"Customer record saved to persistent store";
        if (customer)
            str = @"Customer record updated to persistent store";
        NSLog(@"%@", str);
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                        message:str delegate:self
                                cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

//dismiss keyboard when touch anywhere on screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTxtField resignFirstResponder];
    [phoneTxtField resignFirstResponder];
    [emailTxtField resignFirstResponder];
    [addressTxtField resignFirstResponder];
    [ageTxtField resignFirstResponder];
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
