//
//  NSURLConnectionWithTag.m
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

#import "NSURLConnectionWithTag.h"

@implementation NSURLConnectionWithTag

@synthesize tag = _tag;

-(id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately WithTag: (NSInteger) tag{
    
    if(self = [super initWithRequest:request delegate:delegate startImmediately:startImmediately]){
        
        self.tag = tag;
    }
    
    return self;
}

@end