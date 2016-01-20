//
//  CustomBookCell.h
//  PopViewController
//
//  Created by onwer on 16/1/11.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookView.h"

@protocol CustromBookCellDelegate <NSObject>

- (void)bookViewDidTapBookView:(BookView *)bookView;

@end

@interface CustomBookCell : UITableViewCell

@property (nonatomic, strong) BookView *leftBookView;
@property (nonatomic, strong) BookView *centerBookView;
@property (nonatomic, strong) BookView *rightBookView;
@property (nonatomic, weak)   id<CustromBookCellDelegate> bookDelegate;

@property (nonatomic, strong) NSArray *bookModels;

@end
