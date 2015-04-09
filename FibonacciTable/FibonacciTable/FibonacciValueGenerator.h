//
//  FibonacciValueGenerator.h
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gmp.h"

@class BigNumber;

@interface FibonacciValueGenerator : NSObject

// generates fibonacci value by index (both BigNumber values)
- (BigNumber *)fibonacciValueForIndex:(BigNumber *)index;

@end
