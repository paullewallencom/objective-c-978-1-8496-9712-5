//
//  ViewController.m
//  Instruments
//
//  Created by Gibson Tang on 28/5/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int catImageWidth = 254;
    int catImageHeight = 198;
    
    int count = 0;
    //this will cause a spike in memory usage to show you how memory allocation is visualised in Instruments
    while(true)
    {
        count++;
        UIImageView *cat =[[UIImageView alloc] initWithFrame:CGRectMake(0,0,catImageWidth,catImageHeight)];
        cat.image=[UIImage imageNamed:@"cat.png"];
        [self.view addSubview:cat];
        NSLog(@"Loading cat image #%d", count);
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
