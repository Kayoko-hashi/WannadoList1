//
//  checkListCell.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/06/13.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkListCell : UITableViewCell
@property (nonatomic) NSInteger indicateRow;
@property (weak, nonatomic) IBOutlet UILabel *todoTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnTap:(id)sender event:(id)event;

@end
