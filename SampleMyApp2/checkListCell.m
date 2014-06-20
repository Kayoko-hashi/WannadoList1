//
//  checkListCell.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/13.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "checkListCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "ViewController.h"

@implementation checkListCell


- (void)awakeFromNib
{
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)checkBtnTap:(id)sender {
 

    if (self.checkBtn.tag == 0) {
        
        UIImage *img = [UIImage imageNamed:@"check-10.png"];
        
        [self.checkBtn setBackgroundImage:img forState:UIControlStateNormal];

        self.checkBtn.tag = 1;
        
        NSLog(@"aaaaaaaaaa");
    }else{
    
        UIImage *img2 = [UIImage imageNamed:@"check-09.png"];
        [self.checkBtn setBackgroundImage:img2 forState:UIControlStateNormal];
        
        self.checkBtn.tag = 0;
    
    }
   


    


 
    
    
}
@end
