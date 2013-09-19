//
//  PaintImageView.h
//  ImagePaintView
//
//  Created by Naresh Kumar D on 9/19/13.
//  Copyright (c) 2013 Naresh Kumar D. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{PaintModeDrawMode =0,PaintModeEraseMode=1} PaintMode;
@interface PaintImageView : UIImageView{
    CGPoint lastPoint;
	BOOL mouseSwiped;
	int mouseMoved;

}
@property (nonatomic,assign)PaintMode editMode;
@property (nonatomic,readwrite)float brushSize;
-(void)adjustTheFrame;


@end
