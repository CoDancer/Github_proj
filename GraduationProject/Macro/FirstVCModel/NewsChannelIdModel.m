//
//  NewsChannelIdModel.m
//  GraduationProject
//
//  Created by onwer on 16/2/20.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "NewsChannelIdModel.h"

@implementation NewsChannelIdModel

- (NSDictionary *)getDic {
    
    return @{@"channelId":self.channelIdArray,@"channelName":self.nameArray};
}

- (NSArray *)channelIdArray {
    
    if (!_channelIdArray) {
        _channelIdArray = @[@"5572a109b3cdc86cf39001e5",@"5572a108b3cdc86cf39001d5",
                            @"5572a108b3cdc86cf39001d7",@"5572a109b3cdc86cf39001df",
                            @"5572a108b3cdc86cf39001d1",@"5572a109b3cdc86cf39001e1",
                            @"5572a109b3cdc86cf39001db",@"5572a10bb3cdc86cf39001f8",
                            @"5572a109b3cdc86cf39001e6",@"5572a10ab3cdc86cf39001f3",
                            @"5572a10bb3cdc86cf39001f8",@"5572a109b3cdc86cf39001e4"];
    }
    return _channelIdArray;
}

- (NSArray *)nameArray {
    
    if (!_nameArray) {
        _nameArray = @[@"汽车",@"娱乐",@"时尚",@"军事",@"生活",@"财经",
                       @"人文",@"社会",@"体育",@"旅游",@"科技",@"房产"];
    }
    return _nameArray;
}

@end
