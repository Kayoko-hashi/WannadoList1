//
//  checkCell.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/29.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkCell : UITableViewCell
@property (nonatomic) int indicatedRow; //ボタンが押されたときの行数
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UILabel *todoLabel;
- (IBAction)checkBtnTap:(id)sender event:(id)event;


@end
