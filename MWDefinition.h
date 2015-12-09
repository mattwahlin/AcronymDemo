//
//  MWDefinition.h
//  AcronymDemo
//
//  Created by Matthew Wahlin on 12/8/15.
//  Copyright © 2015 Wahlin Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWDefinition : NSObject

@property (nonatomic, copy) NSString *meaning;
@property NSInteger frequency;
@property NSInteger since;
@property (nonatomic, copy) NSMutableArray *variations;

@end
