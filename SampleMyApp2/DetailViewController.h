//
//  DetailViewController.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,assign)NSInteger myCount;
@property (weak, nonatomic) IBOutlet UITableView *DetailTable;
@property (strong, nonatomic)NSMutableArray *getArray;
@property (nonatomic) NSString *selectedAge;
@property (retain) NSString *sikanai_CategoryNamefromLeft;
-(NSInteger) PlaceEstimate;
@property (weak, nonatomic) IBOutlet UILabel *AgeLable;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *UpperView;




@end
