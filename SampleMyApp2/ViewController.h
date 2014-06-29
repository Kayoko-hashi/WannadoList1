//
//  ViewController.h
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate/*,UITabBarControllerDelegate*/>
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITableView *myList;
- (IBAction)myTextReturn:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBtn;
- (IBAction)AddBtnTap:(id)sender;
@property (assign, nonatomic) NSString *CategoryNamefromLeft;
@property (strong, nonatomic)     NSMutableArray *myArray;
@property (assign, nonatomic) NSInteger categoryInt;
@property (nonatomic)NSMutableArray *FilteredArray;
@property (nonatomic)NSMutableArray *checkedArray;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (void)setupMenuBarButtonItems;
@property (nonatomic) BOOL launchFlag;



@end
