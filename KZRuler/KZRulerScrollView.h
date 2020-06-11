//
//  KZRulerScrollView.h
//
//  Created by KingZ on 2019/6/12.
//  Copyright © 2019 KingZ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KZRulerScrollView : UIScrollView

@property(nonatomic,assign)CGSize markSize; //中间mark size

@property(nonatomic,assign)NSInteger minValue; //最小值

@property(nonatomic,assign)NSInteger maxValue;//最大值

@property(nonatomic,assign)float perunit; //每刻度单位

@property(nonatomic,assign)CGSize smallScaleSize; //最小刻度尺尺寸

@property(nonatomic,strong)UIColor *smallScaleColor;//最小刻度尺颜色

@property(nonatomic,assign)CGSize maxScaleSize;//最大刻度尺尺寸

@property(nonatomic,strong)UIColor *maxScaleColor;//最大刻度尺颜色

@property(nonatomic,assign)NSUInteger scaleSpace;//刻度值间隔

//@property(nonatomic,assign)CGPoint markPoint;//数值坐标

@property(nonatomic,strong)UIFont* scaleFont;//刻度值Font

@property(nonatomic,assign)float currentValue;//当前数值

@property(nonatomic,assign,readonly)NSUInteger  rulerCount;//刻度尺总共的单位

@property(nonatomic,assign)NSUInteger scaleValueSpace; // 每多少间隔标数值

@property(nonatomic,assign,readonly)float  initialMoveX; //初始MoveX

- (void)drawRuler;

- (void)setCurrentValueOffsetAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
