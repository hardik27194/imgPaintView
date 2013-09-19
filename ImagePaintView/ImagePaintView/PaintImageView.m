//
//  PaintImageView.m
//  ImagePaintView
//
//  Created by Naresh Kumar D on 9/19/13.
//  Copyright (c) 2013 Naresh Kumar D. All rights reserved.
//

#import "PaintImageView.h"
@interface PaintImageView(){
    UIImage *baseRefImg;
}
@end;
@implementation PaintImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
      
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image])
    {
        //init here
        self.userInteractionEnabled = YES;
        baseRefImg = image;
          self.brushSize = 40.0f;
    }
    return self;
}
-(void)adjustTheFrame{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    baseRefImg = UIGraphicsGetImageFromCurrentImageContext();
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     
    
        mouseSwiped = NO;
        UITouch *touch = [touches anyObject];
        lastPoint = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
     
        mouseSwiped = YES;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self];
        
        if (self.editMode == PaintModeDrawMode)
        {
            UIGraphicsBeginImageContext(self.frame.size);
            //[self.image drawAtPoint:CGPointZero];
            
            [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            
            CGAffineTransform flipVertical = CGAffineTransformMake(
                                                                   1, 0, 0, -1, 0, self.brushSize
                                                                   );
            CGImageRef overlay =  CGImageCreateWithImageInRect (   [baseRefImg CGImage],   CGRectMake(currentPoint.x-(self.brushSize/2.0), currentPoint.y-(self.brushSize/2.0), self.brushSize, self.brushSize));
            
            
            
            CGContextConcatCTM(UIGraphicsGetCurrentContext(), flipVertical);
            CGContextBeginPath (UIGraphicsGetCurrentContext());
            CGContextAddArc(UIGraphicsGetCurrentContext(), currentPoint.x, -currentPoint.y+self.brushSize, self.brushSize/2.0, 0, 2*M_PI, 0);
            CGContextClosePath(UIGraphicsGetCurrentContext());
            CGContextClip(UIGraphicsGetCurrentContext());
            CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(currentPoint.x-(self.brushSize/2.0), -currentPoint.y+(self.brushSize/2.0), self.brushSize, self.brushSize), overlay);
            
           
            
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        else if (self.editMode == PaintModeEraseMode)
        {
            UIGraphicsBeginImageContext(self.frame.size);
            CGMutablePathRef erasePath = CGPathCreateMutable();
            CGPathAddEllipseInRect(erasePath, NULL, CGRectMake(currentPoint.x-(self.brushSize/2.0), currentPoint.y-(self.brushSize/2.0), self.brushSize, self.brushSize));
            CGContextAddPath(UIGraphicsGetCurrentContext(),erasePath);
            CGContextAddRect(UIGraphicsGetCurrentContext(),CGRectMake(0,0,self.image.size.width,self.image.size.height));
            CGContextEOClip(UIGraphicsGetCurrentContext());
            // [self.image drawAtPoint:CGPointZero];
            [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            self.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            CGPathRelease(erasePath);
        }
        lastPoint = currentPoint;
        
        mouseMoved++;
        
        if (mouseMoved == 10) {
            mouseMoved = 0;
        }
    
}


@end
