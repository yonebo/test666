//
//  EntTableA.m
//  test666
//
//  Created by MacPro01 on 2013/11/05.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import "EntTableA.h"

@implementation EntTableA

@synthesize key;
@synthesize textData;
@synthesize intData;
@synthesize boolData;

/**
 * イニシャライザ
 **/
- (id)init
{
    if (self){
        self.key = 2;
        self.textData = @"";
        self.intData = -1;
        self.boolData = NO;
    }
    
    return self;
}

/**
 * データ表示
 */
- (void) showData{
    
    //　todo
    NSLog(@"key : %ld", (long) self.key);
    
}
@end
