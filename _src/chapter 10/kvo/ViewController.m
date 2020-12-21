//
//  ViewController.m
//  KVO
//
//  Created by Gibson Tang on 2/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    user = [[UserObject alloc] init];
    [user setValue:@"Joe" forKey:@"name"];//to illustrate KVO observer triggering
    [user setAge:12];

    
    //Create the KVO to trigger off when name is changed
    [user addObserver:user forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [txtName setText:[user name]];
}

- (void) dealloc{
    if (user != nil)
        [user removeObserver:user forKeyPath:@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateUser:(id)sender
{
    NSString *name = [txtName text];
    
    //The below line of code will trigger the KVO in UserObject class because
    //name has been changed in UserObject *user
    [user setValue:name forKey:@"name"];
    

}
@end
