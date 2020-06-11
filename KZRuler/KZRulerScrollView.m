//
//  KZRulerScrollView.m
//
//  Created by KingZ on 2019/6/12.
//  Copyright © 2019 KingZ. All rights reserved.
//

#import "KZRulerScrollView.h"

@interface KZRulerScrollView ()

@property(nonatomic,assign)float targetMoveX;

@end

@implementation KZRulerScrollView

-(instancetype)init{
    if (self == [super init]) {
        _maxValue = 100;
        _minValue = 0;
        _perunit = 0.1;
        _smallScaleSize = CGSizeMake(1, 10);
        _maxScaleSize = CGSizeMake(1, 13);
        _smallScaleColor = [UIColor blackColor];
        _maxScaleColor = [UIColor blackColor];
        _scaleSpace = 10;
        _scaleValueSpace = 10;
        
        _scaleFont = [UIFont systemFontOfSize:14];
        
        _rulerCount = (_maxValue - _minValue)/_perunit;
    }
    return self;
}


-(void)setCurrentValue:(float)currentValue{
    if(currentValue != 0){
        _currentValue = currentValue;
    }
    
}


- (void)drawRuler{
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    _rulerCount = (_maxValue - _minValue)/_perunit;
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.lineWidth = _maxScaleSize.width;
    shapeLayer1.strokeColor = _maxScaleColor.CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.lineWidth = _smallScaleSize.width;
    shapeLayer2.strokeColor = _smallScaleColor.CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineCap = kCALineCapButt;
    
    
    _rulerCount = (_maxValue - _minValue)/_perunit;
    float moveX =  self.frame.size.width/2 - self.markSize.width / 2;
    _initialMoveX = moveX;
    
    for (int i = 0; i <= _rulerCount; i++) {
        float rulerReal = i * _perunit;
        float scaleSizeWidth = _maxScaleSize.width;
        if([NSString stringWithFormat:@"%.2f", rulerReal+_minValue] == [NSString stringWithFormat:@"%.2f", _currentValue]){
            _targetMoveX = moveX;
        }
        
        if(i%5 == 0){
            
            CGPathMoveToPoint(pathRef1, NULL, moveX, 3);
            CGPathAddLineToPoint(pathRef1, NULL, moveX, _maxScaleSize.height);
            
            scaleSizeWidth = _maxScaleSize.width;
            
        }else{
            
            CGPathMoveToPoint(pathRef2, NULL, moveX, 3);
            CGPathAddLineToPoint(pathRef2, NULL, moveX, _smallScaleSize.height);
            
            scaleSizeWidth = _smallScaleSize.width;
        }
        
        if(i%_scaleValueSpace == 0){
            NSString * scaleValueStr = [NSString stringWithFormat:@"%ld",(long)rulerReal + _minValue];
            
            CGSize textSize = [scaleValueStr sizeWithAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:_scaleFont.pointSize]}];
            
            CATextLayer * scaleValue = [[CATextLayer alloc]init];
            scaleValue.contentsScale = 3;
            [scaleValue setFont:(__bridge CFTypeRef _Nullable)(_scaleFont.fontName)];
            [scaleValue setFontSize:_scaleFont.pointSize];
            [scaleValue setForegroundColor:[[UIColor blackColor] CGColor]];
            [scaleValue setFrame:CGRectMake(moveX - textSize.width / 2, _maxScaleSize.height + 10, textSize.width, textSize.height)];
            [scaleValue setString:scaleValueStr];
            [scaleValue setAlignmentMode:kCAAlignmentCenter];
            [self.layer addSublayer:scaleValue];
        }
        
        
        moveX += scaleSizeWidth + _scaleSpace;
    }
    shapeLayer1.path = pathRef1;
    [self.layer addSublayer:shapeLayer1];
    
    shapeLayer2.path = pathRef2;
    [self.layer addSublayer:shapeLayer2];
    
    self.contentSize = CGSizeMake(moveX + self.frame.size.width/2 - self.scaleSpace , self.frame.size.height);

    self.contentOffset = CGPointMake(_targetMoveX - self.frame.size.width / 2, 0);
    
}

- (void)setCurrentValueOffsetAnimated:(BOOL)animated{
    
    float moveX =  self.frame.size.width/2 - self.markSize.width / 2;
    for (int i = 0; i <= _rulerCount; i++) {
        float rulerReal = i * _perunit;
        float scaleSizeWidth = _maxScaleSize.width;
        if([NSString stringWithFormat:@"%.2f", rulerReal+_minValue] == [NSString stringWithFormat:@"%.2f", _currentValue]){
            _targetMoveX = moveX;
        }
        if(i%5 == 0){
            scaleSizeWidth = _maxScaleSize.width;
            
        }else{
            scaleSizeWidth = _smallScaleSize.width;
        }
        moveX += scaleSizeWidth + _scaleSpace;
    }
    
    [self setContentOffset:CGPointMake(_targetMoveX - self.frame.size.width / 2, 0) animated:animated];
}

@end
