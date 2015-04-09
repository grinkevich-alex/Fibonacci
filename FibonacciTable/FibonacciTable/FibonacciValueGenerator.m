//
//  FibonacciValueGenerator.m
//  FibonacciTable
//
//  Created by Grinkevich, Alex on 4/8/15.
//  Copyright (c) 2015 Qulix. All rights reserved.
//

#import "FibonacciValueGenerator.h"

#import "BigNumber.h"
#import "BigNumberUtils.h"


@implementation FibonacciValueGenerator

- (BigNumber *)fibonacciValueForIndex:(BigNumber *)index {
    mpz_t      indexNumber, fibonacciNumber;
    mpz_inits (indexNumber, fibonacciNumber, nil);
    
    mpz_set (indexNumber, *index.number);
    
    [self fibonacciNumber:&fibonacciNumber atIndex:indexNumber];
    
    BigNumber *returnValue = [[BigNumber alloc] initWithMPZNumber:&fibonacciNumber];
    
    mpz_clears (indexNumber, fibonacciNumber, nil);
    
    return returnValue;
}

- (void)fibonacciNumber:(mpz_t *)fibonacciNumber atIndex:(mpz_t)index {
    mpz_t      a, ta, b, tb, c, rc, tc, d, rd;
    
    mpz_inits (a, ta, b, tb, c, rc, tc, d, rd, nil);
    
    mpz_set_d (a, 1);
    mpz_set_d (b, 1);
    mpz_set_d (c, 1);
    mpz_set_d (rd, 1);
    
    while (mpz_sgn(index)) { // check on zero
        
        if (mpz_tstbit(index, 0)) { // check on odd
            mpz_set (tc, rc);
            
            mpz_mul(rc, rc, a);
            mpz_addmul(rc, rd, c);
            
            mpz_mul(rd, rd, d);
            mpz_addmul(rd, tc, b);
        }
        
        mpz_set (ta, a);
        mpz_set (tb, b);
        mpz_set (tc, c);
        
        mpz_mul(a, a, a);
        mpz_addmul(a, b, c);
        
        mpz_t  summa;
        mpz_init (summa);
        mpz_add (summa, ta, d);
        
        mpz_mul(b, b, summa);
        
        mpz_mul(c, c, summa);
        
        mpz_clear(summa);
        
        mpz_mul(d, d, d);
        mpz_addmul(d, tc, tb);

        mpz_fdiv_q_2exp(index,index,1); // divide on 2

    }
    
    mpz_set(*fibonacciNumber, rc);
    mpz_clears(a, ta, b, tb, c, rc, tc, d, rd, nil);
}

@end
