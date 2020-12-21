//
//
//  Created by Gibson Tang on 4/4/14.
//  Copyright (c) 2014 Gibson Tang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject
{
    int age;
    NSString *name;
}

@property (readwrite, nonatomic) int age;
@property (copy, nonatomic) NSString *name;
@end
