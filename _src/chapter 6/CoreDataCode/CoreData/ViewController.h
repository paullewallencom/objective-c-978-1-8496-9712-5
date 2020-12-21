//
//  ViewController.h
//  Storyboard
//
//  Created by Gibson Tang on 30/6/13.
//  Copyright (c) 2013 Gibson Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddRecordViewController.h"

@interface ViewController : UIViewController
{
    NSManagedObject *customer;
}

@property (weak, nonatomic) IBOutlet UITextField *searchTxtField;
-(IBAction) searchByName:(id)sender;
-(IBAction) goAddRecord:(id)sender;
@end
