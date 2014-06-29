//
//  AddNewCategoryCell.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/27.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "AddNewCategoryCell.h"
#import "LeftViewController.h"
#import "AppDelegate.h"

@implementation AddNewCategoryCell{

    NSString *_CategoryFilePath;

}

- (void)awakeFromNib
{
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self StyleOfTextField];
     self.AddNCTextField.delegate = self;
    self.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];


    // Configure the view for the selected state
}

//カテゴリーリスト用のパスを準備する。
- (void)SelctCategoryPlist{
    //plistのディレクトリを指定
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    //指定されたディレクトリ配下から指定のplist
    _CategoryFilePath = [documentsDirectory stringByAppendingPathComponent:@"Category.plist"];
    
}


- (IBAction)addBtn:(id)sender {
    
    
    if ([self.AddNCTextField.text isEqual:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            
                            initWithTitle:@"テキストが空です。"
                            message:@"文字を入力してください。"
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil, nil];
        
        [alert show];
        
    }else{
        
        NSString *text = self.AddNCTextField.text;
        
        //アップデリゲートをインスタンス化
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        //leftViewのカテゴリー配列に入力された文字列を要素として追加
        [appdelegate.leftMenuViewContoroller.CategoryArray addObject:text];
        
        //plistのディレクトリを指定
        [self SelctCategoryPlist];
        
        //カテゴリplistへ書き込み
        [appdelegate.leftMenuViewContoroller.CategoryArray writeToFile:_CategoryFilePath atomically:YES];
        
        //leftTableの再読み込み
        [appdelegate.leftMenuViewContoroller.LeftTable reloadData];

        
    }

    
    
}
 


//テキストフィールド編集中のメソッド
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"テキスト編集中");
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //ナビゲーションバーを無効にする
    app.tmpViewContoroller.navigationItem.leftBarButtonItem.enabled = NO;
    app.tmpViewContoroller.navigationItem.rightBarButtonItem.enabled = NO;
    
    return YES;
}


//テキストフィールド編集後に呼ばれる
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSLog(@"テキスト編集終了");
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //ナビゲーションバーを有効にする
    app.tmpViewContoroller.navigationItem.leftBarButtonItem.enabled = YES;
    app.tmpViewContoroller.navigationItem.rightBarButtonItem.enabled = YES;
    
    return YES;
    
}


-(void)StyleOfTextField{
    
    self.AddNCTextField.delegate = self;
       
    
}


- (IBAction)TFReturn:(id)sender {
    
    
}
@end
