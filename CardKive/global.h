//
//  global.h
//  CardKive
//
//  Created by Mini on 8/16/15.
//  Copyright (c) 2015 99Ideas. All rights reserved.
//

#import <Foundation/Foundation.h>

//global variables
extern NSString *userName;
extern NSString *password;
extern NSString *eMail;
extern NSString *keepLogin;
extern NSString *image;

@interface global : NSObject{
    NSString *var1; //singleton
}

@property(nonatomic, retain) NSString *var1;
+(global *)sharedSingleton;
+(NSString *)myData;

@end
