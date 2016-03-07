//
//  GPAPIHeader.h
//  GraduationProject
//
//  Created by CoDancer on 15/12/13.
//  Copyright © 2015年 onwer. All rights reserved.
//


#ifndef GPAPIHeader_h
#define GPAPIHeader_h

typedef void (^GPHTTPClientSuccessBlock)(id responseObject);
typedef void (^GPHTTPClientFailureBlock)(NSError *error);


#define GP_HTTP_FAILURE ^(AFHTTPRequestOperation *operation, NSError *error) { \
if (failure) { \
failure(error); \
}\
}

#define GP_DEFAULT_API(METHOD) \
- (NSOperation*)METHOD ## Success:(GPHTTPClientSuccessBlock)success failure:(GPHTTPClientFailureBlock)failure
#define GP_DEFAULT_PARAMS_API(METHOD) \
- (NSOperation*)METHOD success:(GPHTTPClientSuccessBlock)success failure:(GPHTTPClientFailureBlock)failure


#endif /* GPAPIHeader_h */
