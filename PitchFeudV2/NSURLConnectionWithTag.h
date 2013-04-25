//
//  NSURLConnectionWithTag.h
//  PitchFeudV2
//
//  Created by Michael Godlowski-Maryniak on 22/03/13.
//  Copyright (c) 2013 Never Kill A Customer. All rights reserved.
//

@interface NSURLConnectionWithTag : NSURLConnection


@property (assign) NSInteger tag;

-(id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate startImmediately:(BOOL)startImmediately WithTag: (NSInteger) tag;

@end