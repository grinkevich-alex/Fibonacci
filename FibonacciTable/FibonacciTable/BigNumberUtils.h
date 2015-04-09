//
//  BigNumberUtils.h
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"

@interface BigNumberUtils : NSObject

+ (NSString *)stringForNumber:(mpz_t)number;

+ (void)number:(mpz_t *)number forString:(NSString *)string;

@end
