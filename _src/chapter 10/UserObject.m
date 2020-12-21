//
//
//  Created by Gibson Tang on 4/4/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject
@synthesize age, name;

#pragma mark ==KVO stuff==
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Triggered when value changes");
    
    NSString *str = [NSString stringWithFormat:@"KVO triggered. Old name is %@ and updated name is %@",
                     [change objectForKey:NSKeyValueChangeOldKey],
                     [change objectForKey:NSKeyValueChangeNewKey]];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:str delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void) setAge:(int)aAge;
{
    int MIN_AGE = 20;//add in our validation logic for our setter here
    if (aAge < MIN_AGE)
        age = 20;
    else
        age = aAge;
}

-(int) getAge
{
    return age;
}
@end
