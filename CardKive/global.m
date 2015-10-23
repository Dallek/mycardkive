//
//  global.m
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import "global.h"

//global variables
NSString *userName = NULL;
NSString *password = NULL;
NSString *eMail = NULL;
NSString *keepLogin = NULL;
NSUInteger *indexCell = NULL;
NSMutableArray *array = NULL;
NSMutableArray *array2 = NULL;

@implementation global

@synthesize var1;

static global *shared = NULL;

-(id) init
{
    if (self = [super init])
    {
        var1 = @"Singleton";
    }
    return self;
}

+(global *)sharedSingleton
{
    @synchronized(shared)
    {
        if (!shared || shared == NULL)
        {
            shared = [[global alloc]init];
        }
        return shared;
    }
}

//to share database throughout app
+(NSString *)myData{
    return @"myDataBase.db";
}

@end
