//
//  CardWith3DView.h
//  PopViewController
//
//  Created by onwer on 16/1/22.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondViewCellModel;

typedef void(^getMovieModelBlock) (SecondViewCellModel *movieModel);

@interface CardWith3DView : UIView

@property (nonatomic, strong) getMovieModelBlock modelBlock;

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)arr index:(NSInteger)index;

@end
