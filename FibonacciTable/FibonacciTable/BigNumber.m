//
//  BigNumber.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "BigNumber.h"
#import "BigNumberUtils.h"

@interface BigNumber () {
    mpz_t _number;
}

@end

@implementation BigNumber

- (instancetype)initWithStringRepresentation:(NSString *)stringRepresentation {
    self = [super init];
    if (self) {
        mpz_init (_number);
        [BigNumberUtils number:&(_number) forString:stringRepresentation];
    }
    return self;
}

- (instancetype)initWithMPZNumber:(mpz_t *)number {
    self = [super init];
    if (self) {
        mpz_init (_number);
        mpz_set (_number, *number);
    }
    return self;
}

- (NSString *)stringValue {
    return [BigNumberUtils stringForNumber:_number];
}

- (mpz_t *)number {
    return &_number;
}

- (void)increment {
    mpz_add_ui (_number, _number, 1);
}

- (void)decrement {
    if (!self.isZero) {
        mpz_sub_ui (_number, _number, 1);
    }
}

- (BOOL)isZero {
    return !mpz_sgn(_number);
}

- (void)dealloc {
    mpz_clear(_number);
}

@end
