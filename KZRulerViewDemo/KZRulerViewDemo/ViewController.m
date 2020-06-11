//
//  ViewController.m
//  KZRulerViewDemo
//
//  Created by KingZ on 2020/6/11.
//  Copyright © 2020 KingZ. All rights reserved.
//

#import "ViewController.h"
#import "KZRulerView.h"
@interface ViewController ()<KZRulerViewDelegate>

@property(nonatomic,weak)IBOutlet KZRulerView * rulerView;

@property(nonatomic,weak)IBOutlet KZRulerView * weightRuler;

@property(nonatomic,weak)IBOutlet KZRulerView * heightRuler;

@property(nonatomic,weak)IBOutlet UILabel * weightLabel;

@property(nonatomic,weak)IBOutlet UILabel * heightLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rulerView.rulerScrollView.minValue = 1;
    self.rulerView.rulerScrollView.maxValue = 999;
    self.rulerView.rulerScrollView.perunit = 1;
    self.rulerView.rulerScrollView.scaleSpace = 20;
    self.rulerView.rulerScrollView.scaleValueSpace = 5;
    self.rulerView.rulerScrollView.currentValue = 1;
    self.rulerView.rulerDeletate = self;
    self.rulerView.markColor = [UIColor redColor];
    
 
    self.heightRuler.tag = 10;
    self.heightRuler.rulerScrollView.minValue = 100;
    self.heightRuler.rulerScrollView.maxValue = 230;
    self.heightRuler.rulerScrollView.currentValue = 165;
    self.heightRuler.rulerDeletate = self;
    self.heightRuler.markColor = [UIColor blueColor];
    
    self.weightRuler.tag = 20;
    self.weightRuler.rulerScrollView.minValue = 30;
    self.weightRuler.rulerScrollView.maxValue = 200;
    self.weightRuler.rulerScrollView.currentValue = 65;
    self.weightRuler.rulerDeletate = self;
    self.weightRuler.markColor = [UIColor greenColor];
    
    
}

-(void)KZRulerView:(KZRulerView *)rulerView CurentValue:(float)currentValue{
    
    if(rulerView.tag == 10){
        self.heightLabel.text = [NSString stringWithFormat:@"%.2f",currentValue];
    }
    if(rulerView.tag == 20){
        self.weightLabel.text = [NSString stringWithFormat:@"%.2f",currentValue];
    }
}


@end
