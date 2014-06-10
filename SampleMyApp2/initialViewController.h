//
//  initialViewController.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/28.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface initialViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *BirthDayPicker;
- (IBAction)ChangeDate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
- (IBAction)TapDone:(id)sender;
@property (nonatomic) NSUserDefaults *ud;
@property (weak, nonatomic) IBOutlet UILabel *myLabel;



@end
