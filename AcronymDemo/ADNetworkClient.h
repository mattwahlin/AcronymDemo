//
//  ADNetworkClient.h
//  AcronymDemo
//
//  Created by Matthew Wahlin on 12/8/15.
//  Copyright © 2015 Wahlin Consulting. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "MWAcronym.h"


typedef void (^ServiceSuccessBlock)(NSURLSessionDataTask *task, MWAcronym *acronym);
typedef void (^ServiceFailureBlock)(NSURLSessionDataTask *task, NSError *error);

@interface ADNetworkClient : AFHTTPSessionManager

/*
 * @discussion
 * @return SingleTon instance of AINetworkClient
 */
+(ADNetworkClient *) sharedManager;

/*
 * @discussion - This method makes a GET request to the given URL.
 * @param urlString url string of webservice
 * @parameters Dictionary of parameters to be sent
 * @success Successblock to be called on service success
 * @failure FailureBlock to be called on service failure
 *
 *  *** Sample usage ***
 * GET webservice : http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=usa
 * urlstring : http://www.nactem.ac.uk/software/acromine/dictionary.py?
 * parameters: @{@"sf": @"usa"}
 *
 */
- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(ServiceSuccessBlock) success failure:(ServiceFailureBlock) failure;

@end
