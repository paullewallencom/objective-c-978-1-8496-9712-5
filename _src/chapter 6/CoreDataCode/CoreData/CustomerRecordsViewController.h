//
//  CustomerRecordsViewController.h
//  CoreData
//
//  Created by Gibson Tang on 20/3/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CustomerRecordsViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@end
