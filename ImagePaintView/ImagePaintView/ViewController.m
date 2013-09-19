//
//  ViewController.m
//  ImagePaintView
//
//  Created by Naresh Kumar D on 9/19/13.
//  Copyright (c) 2013 Naresh Kumar D. All rights reserved.
//

#import "ViewController.h"
#import "PaintImageView.h"

@interface ViewController (){
    PaintImageView *baseImage ;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 baseImage = [[PaintImageView alloc]initWithImage:[UIImage imageNamed:@"sunshine.png"]];
    baseImage.frame = CGRectMake(10, 80, 300, 300);
    
    [baseImage adjustTheFrame]; // This line is important..
     
    baseImage.editMode =PaintModeEraseMode;
     
    [self.view addSubview:baseImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleMode:(id)sender {
    if (baseImage.editMode == PaintModeEraseMode) {
        baseImage.editMode = PaintModeDrawMode;
    }
    else{
        baseImage.editMode = PaintModeEraseMode;
    }
}
@end
