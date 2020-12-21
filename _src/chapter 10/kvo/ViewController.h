//
//  ViewController.h
//  KVO
//
//  Created by Gibson Tang on 2/6/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"

@interface ViewController : UIViewController
{
    UITextField *txtName;
    UserObject *user;
}

- (IBAction)updateUser:(id)sender;

@end
