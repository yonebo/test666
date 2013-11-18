//
//  EntTableA.h
//  test666
//
//  Created by MacPro01 on 2013/11/05.
//  Copyright (c) 2013年 eyoneya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntTableA : NSObject
{
    NSInteger key;
    NSString *textData;
    NSInteger intData;
    BOOL *boolData;
}

@property(nonatomic, assign)NSInteger key;
@property(nonatomic, retain)NSString *textData;
@property(nonatomic, assign)NSInteger  intData;
@property BOOL *boolData;

- (id)init;
- (void)showData;

@end
