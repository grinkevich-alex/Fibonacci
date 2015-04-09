//
//  BigNumberUtils.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "BigNumberUtils.h"

int const kDecimalBase = 10;

@implementation BigNumberUtils

+ (NSString *)stringForNumber:(mpz_t)number {
    char *charValue = mpz_get_str(NULL, kDecimalBase, number);
    
    NSString *returnValue = [NSString stringWithUTF8String:charValue];
    
    free(charValue);
    
    return returnValue;
}

+ (void)number:(mpz_t *)number forString:(NSString *)string {
    const char *cString = [string cStringUsingEncoding:NSASCIIStringEncoding];
    mpz_set_str(*number, cString, kDecimalBase);
}

@end
