//
//  BigNumber.h
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"

// BigNumber class to work operate huge numbers
@interface BigNumber : NSObject

- (instancetype)initWithStringRepresentation:(NSString *)stringRepresentation;
- (instancetype)initWithMPZNumber:(mpz_t *)number;

- (NSString *)stringValue;
- (mpz_t *)number;

- (void)increment;
- (void)decrement;

- (BOOL)isZero;

@end

