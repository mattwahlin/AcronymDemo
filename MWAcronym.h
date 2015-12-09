//
//  MWAcronym.h
//  AcronymDemo
//
//  Created by Matthew Wahlin on 12/8/15.
//  Copyright © 2015 Wahlin Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWAcronym : NSObject

@property (nonatomic,copy) NSString *shortForm;
@property (nonatomic,strong) NSMutableArray *definitions;
@end
