//
//  KZRulerView.h
//  KZRulerScrollView.h KZRulerScrollViewDemo
//
//  Created by KingZ on 2019/6/12.
//  Copyright © 2019 KingZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZRulerScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@class KZRulerView;

@protocol KZRulerViewDelegate <NSObject>

@optional
- (void)KZRulerView:(KZRulerView*)rulerView CurentValue:(float)currentValue;

@end

@interface KZRulerView : UIView

@property(nonatomic,assign)CGPoint markPoint;

@property (nonatomic, weak) id <KZRulerViewDelegate> rulerDeletate;

@property(nonatomic,assign)CGSize markSize;

@property(nonatomic,strong)UIColor* markColor;

@property(nonatomic,strong,readonly)KZRulerScrollView * rulerScrollView;

- (void)drawRuler;

@end

NS_ASSUME_NONNULL_END
