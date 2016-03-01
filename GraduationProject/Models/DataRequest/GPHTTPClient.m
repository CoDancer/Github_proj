//
//  GPHTTPClient.m
//  GraduationProject
//
//  Created by CoDancer on 15/12/12.
//  Copyright © 2015年 onwer. All rights reserved.
//



#import "GPHTTPClient.h"
#import "WebApi.h"

@interface GPHTTPClient()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end



@implementation GPHTTPClient

+ (instancetype)sharedClient
{
    static dispatch_once_t once;
    static GPHTTPClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc] init];
    });
    return __singleton__;
}
-(AFHTTPRequestOperationManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer
                                       serializerWithReadingOptions:NSJSONReadingMutableContainers];
        _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    }
    return _manager;
}

#pragma mark - Inherited Methods

- (AFHTTPRequestOperation *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    __weak typeof(self) weakSelf = self;
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    return [super GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            //[responseObject removeNulls];
            success(operation, responseObject);
        }
        else if (!available) {
            failure(operation, [weakSelf.class errorWithResponse:responseObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        if (failure) {
            failure(operation, error);
        }
    }];
    
    
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    __weak typeof(self) weakSelf = self;
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    // Hijack the API.
    return [super POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            //[responseObject removeNulls];
            success(operation, responseObject);
        }
        else if (!available) {
            failure(operation, [weakSelf.class errorWithResponse:responseObject]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        if (failure) {
            failure(operation, error);
        }
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSMutableDictionary *parm = [NSMutableDictionary new];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [parm setObject:obj forKey:key];
    }];
    [WebApi tagParams:parm];
    NSLog(@"%@",parm);
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_ADD,URLString];
    return [self.manager POST:url parameters:parm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

- (BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject
{
    BOOL availabel = responseObject && [responseObject[@"ok"] boolValue];
    if (responseObject[@"servertime"]) {
        NSDate *standardDate = [NSDate dateWithTimeIntervalSince1970:[responseObject[@"servertime"] integerValue]];
        //[NSDate setStandardDate:standardDate currentDate:[NSDate date]];
    }
    return availabel;
}

+ (NSError *)errorWithResponse:(NSDictionary *)response
{
    NSError *error = nil;
    NSString *errorDescription = response[@"error"];
    NSInteger code = [response[@"errorid"] integerValue];
    BOOL ok = [response[@"ok"] boolValue];
    if (!ok) {
        NSDictionary *userInfo = @{@"description": errorDescription ?: @"未知错误"};
        error = [NSError errorWithDomain:@"" code:code userInfo:userInfo];
    }
    return error;
}

@end
