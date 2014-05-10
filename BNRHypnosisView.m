//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Anthony Armstrong on 5/1/14.
//  Copyright (c) 2014 iamtonyarmstrong. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (nonatomic, strong)UIColor *circleColor;

@end


@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        self.circleColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Current drawing context for the drop shadow...
    //CGContextRef currentContext = UIGraphicsGetCurrentContext();

    // Drawing code
    CGRect bounds = self.bounds;

    //where's the center of the bounds rectangle?
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    //circle will be largest that will fit in the view
    //float radius = MIN(bounds.size.width, bounds.size.height) / 2.0;
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;

    for(float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20){
        UIBezierPath *path = [[UIBezierPath alloc]init]; 
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:2.0 * M_PI
                     clockwise:YES ];

        //set the line width and color
        [path setLineWidth:10];
        [self.circleColor setStroke];
        
        //Draw the line;
        [path stroke];
    }

    /*
    //To create the drop shadow, draw with a shadow...
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);

    //add in an image to composite
    UIImage *img = [UIImage imageNamed:@"memo_logo.png"];
    float height = [img size].height;
    float width = [img size].width;


    CGRect imgRect = CGRectMake(10, height / 2.0, width, height);
    [img drawInRect: imgRect];

    //...then resume drawing without one...
    CGContextRestoreGState(currentContext);
     */

}

//when a finger touches the screen...
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);

    //Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;

    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];

    self.circleColor = randomColor;
    [self setNeedsDisplay];
}


@end
