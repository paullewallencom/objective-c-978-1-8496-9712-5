//
//  AddRecordViewController.h
//  CoreData
//
//  Created by Gibson Tang on 20/3/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddRecordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *ageTxtField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxtField;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtField;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtField;
@property (strong) NSManagedObject *customer;
- (IBAction)save:(id)sender;
@end
