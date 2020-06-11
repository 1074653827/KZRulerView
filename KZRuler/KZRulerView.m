//
//  KZRulerView.m
//  KZRulerScrollView.h KZRulerScrollViewDemo
//
//  Created by KingZ on 2019/6/12.
//  Copyright © 2019 KingZ. All rights reserved.
//

#import "KZRulerView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface KZRulerView ()<UIScrollViewDelegate>


@end

@implementation KZRulerView

-(instancetype)init{
    if(self == [super init]){
        [self initialize];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self == [super initWithCoder:coder]){
        [self initialize];
    }
    return self;
}

-(void)initialize{
    _markSize = CGSizeMake(2, 22);
    _markColor = [UIColor redColor];
    
    _rulerScrollView = [[KZRulerScrollView alloc]init];
    //        _rulerScrollView.markPoint = self.markPoint;
    _rulerScrollView.delegate = self;

}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.markPoint = CGPointMake(self.frame.size.width/2, 0);
    [self addSubview:self.rulerScrollView];
    [self.rulerScrollView setFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [self drawRuler];
}



#pragma mark - ScrollView Delegate


- (void)scrollViewDidScroll:(KZRulerScrollView *)scrollView {
    
    CGFloat offSetX = scrollView.contentOffset.x + scrollView.frame.size.width / 2 - scrollView.scaleSpace;
    
    CGFloat oneBigUnitWidth = (10*scrollView.scaleSpace + 2 * scrollView.maxScaleSize.width + 8 * scrollView.smallScaleSize.width) / (10 * scrollView.perunit);
    
    CGFloat ruleValue = ((offSetX - scrollView.initialMoveX + scrollView.scaleSpace) / oneBigUnitWidth) ;
    if (ruleValue < 0.f) {
        return;
    } else if (ruleValue > scrollView.rulerCount * scrollView.perunit) {
        return;
    }
    
    
    if (self.rulerDeletate) {
        
        scrollView.currentValue = ruleValue + scrollView.minValue;
        if([self.rulerDeletate respondsToSelector:@selector(KZRulerView:CurentValue:)])
        
            [self.rulerDeletate KZRulerView:self CurentValue:scrollView.currentValue];
    }
}

- (void)scrollViewDidEndDecelerating:(KZRulerScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(KZRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(KZRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - scrollView.scaleSpace;
    
    CGFloat oneBigUnitWidth = (10*scrollView.scaleSpace + 2 * scrollView.maxScaleSize.width + 8 * scrollView.smallScaleSize.width) / (10 * scrollView.perunit);
    
    CGFloat oX = ((offSetX - scrollView.initialMoveX + scrollView.scaleSpace) / oneBigUnitWidth) ;
#ifdef DEBUG
    NSLog(@"ago*****************ago:oX:%f",oX);
#endif
    
    oX = [KZRulerView roundRuleralue:oX WithDigit:scrollView.perunit];
    
#ifdef DEBUG
    NSLog(@"after*****************after:oX:%f",oX);
#endif
    scrollView.currentValue = oX + scrollView.minValue;
    [scrollView setCurrentValueOffsetAnimated:YES];
    
}

- (void)drawRacAndLine {
    
    // 渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.6f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    
    CGMutablePathRef pathArc = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathArc, NULL, 0, 20);
    CGPathAddQuadCurveToPoint(pathArc, NULL, self.frame.size.width / 2, - 20, self.frame.size.width, 20);
    
    [self.layer addSublayer:gradient];
    
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = _markColor.CGColor;
    shapeLayerLine.fillColor = _markColor.CGColor;
    shapeLayerLine.lineWidth = _markSize.width;
    shapeLayerLine.lineCap = kCALineCapSquare;
    
//    UIView * markView = [[UIView alloc]initWithFrame:CGRectMake(_markPoint.x, _markPoint.y, _markSize.width, _markSize.height)];
//    markView.backgroundColor = _markColor;
//    markView.layer.cornerRadius = _markSize.width/2;
//    [self addSubview:markView];
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.markPoint.x, self.markPoint.y);
    CGPathAddLineToPoint(pathLine, NULL, self.markPoint.x, _markSize.height);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
}

- (void)drawRuler{
    _rulerScrollView.markSize = self.markSize;
    [_rulerScrollView drawRuler];
    [self drawRacAndLine];
}


#pragma mark - tool method

+(double)roundRuleralue:(double)rulerValue WithDigit:(float)digit{
    
    return round(rulerValue / digit) * digit;
}

@end
