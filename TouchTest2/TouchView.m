//
//  TouchView.m
//  TouchTest2
//
//  Created by 池田昂平 on 2014/10/15.
//  Copyright (c) 2014年 池田昂平. All rights reserved.
//

#import "TouchView.h"

@implementation TouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //現在のタッチ数の表示
    NSInteger tCount = [touchObjects count];
    NSString *countText = [NSString stringWithFormat: @"タッチ数: %d", tCount];
    CGPoint point = CGPointMake(50, 50);
    UIFont *font = [UIFont systemFontOfSize:20];
    [countText drawAtPoint:point withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    for (UITouch *touch in touchObjects){
        CGPoint location = [touch locationInView:self];
        NSLog(@"x:%f y:%f", location.x, location.y);
        
        //接地面積の取得
        CGFloat majorRadi = [[touch valueForKey:@"pathMajorRadius"] floatValue];
        NSLog(@"接地面積: %f", majorRadi);
        
        //円の描画
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIColor *color = [UIColor yellowColor];
        CGContextSetFillColor(context, CGColorGetComponents(color.CGColor));
        CGContextFillEllipseInRect(context, CGRectMake(location.x, location.y, 30, 30));
        
        //テキスト表示
        NSString *text = [NSString stringWithFormat: @"%0.1f, %0.1f", location.x, location.y];
        CGPoint point = CGPointMake(location.x, location.y);
        [text drawAtPoint:point withAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // マルチタッチの場合
    for (UITouch *touch in touches) {
        location = [touch locationInView:self];
        NSLog(@"x:%f y:%f", location.x, location.y);
        [self setNeedsDisplay];
    }
    
    
    //全てのタッチを取得
    NSSet *touchSet = [event allTouches];
    NSLog(@"allTouches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touchSet count]);

 
    for(UITouch *touch in touchSet){
        location = [touch locationInView:self];
        NSLog(@"x:%f y:%f", location.x, location.y);
    }
 
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // マルチタッチの場合
    /*
    for (UITouch *touch in touches) {
        location = [touch locationInView:self];
        NSLog(@"x:%f y:%f", location.x, location.y);
    }
    [self setNeedsDisplay];
    
    NSLog(@"allTouches count : %d (touchesBegan:withEvent:)", [[event allTouches] count]);
    */
    [self showTouchPoint:[event allTouches]];
}

- (void)showTouchPoint:(NSSet *)allTouches{
    /*
    for (UITouch *touch in allTouches){
        location = [touch locationInView:self];
        NSLog(@"x:%f y:%f", location.x, location.y);
    }
     */
    
    //配列に保存
    touchObjects = [allTouches allObjects];
    
    NSLog(@"allTouches count : %d (touchesBegan:withEvent:)", [allTouches count]);
    
    //一度だけ描画
    [self setNeedsDisplay];
    [self discrimPatt];
}

//向き固定のパターン
- (void)discrimPatt{
    /*
    NSInteger tObjSize = [touchObjects count];
    NSString *text;
    CGPoint point = CGPointMake(100, 100);
     */
    
    /*
    switch (tObjSize) {
        case 1:
            //text = @"パターン 1";
            //[text drawAtPoint:point withAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
            self.backgroundColor = [UIColor brownColor];
            break;
            
        case 2:
            //text = @"パターン 2";
            self.backgroundColor = [UIColor cyanColor];
            break;
            
        case 3:
            //text = @"パターン 3";
            self.backgroundColor = [UIColor grayColor];
            break;
            
        case 4:
            //text = @"パターン 4";
            self.backgroundColor = [UIColor greenColor];
            break;
            
        case 5:
            //text = @"パターン 5";
            self.backgroundColor = [UIColor orangeColor];
            break;
            
        default:
            self.backgroundColor = [UIColor purpleColor];
            break;
    }
    */
}

@end
