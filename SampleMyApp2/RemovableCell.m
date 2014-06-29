//
//  RemovableCell.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/30.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "RemovableCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"


@implementation RemovableCell{

    NSString *wannadoFilepath;
    AppDelegate *appdelegate;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.deleteBtn.tintColor = [UIColor colorWithRed:0.60 green:0.740 blue:0.639 alpha:1.0];
    self.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];

    // Configure the view for the selected state
}

- (void)SelectWannadoPlist{
    
    //WannadoList用のパスを作る準備。
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    
    //指定されたディレクトリ配下から指定のplist
    wannadoFilepath = [documentsDirectory stringByAppendingPathComponent:@"wannadoList2.plist"];

    
}

-(AppDelegate *)appdelegatemethod{

    //アップデリゲートをインスタンス化
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    return appdelegate;
}

- (IBAction)deleteTap:(id)sender {
    
    [self replaceToNonCategory];
    //該当セルをカテゴリー配列とテーブルから削除
    [self deleteCellFromTableAndArray];
    
    //該当セルにカテゴライズされていた項目を"無分類"に書き換える
    
    [self didselecetrowatIndexpath];

}

-(void)replaceToNonCategory{

    [self SelectWannadoPlist];
    //アップデリゲートをインスタンス化
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //カスタムセルのボタンが押された時の
    NSString *CategoryShouldDelete;
    CategoryShouldDelete = app.leftMenuViewContoroller.CategoryArray[self.indicateRow];
    NSLog(@"CategoryShouldDelete====%@",app.leftMenuViewContoroller.CategoryArray);
    
    
    NSMutableArray *getArray;
    getArray = [NSMutableArray arrayWithContentsOfFile:wannadoFilepath];
    NSLog(@"%@",getArray);

    NSInteger count;
    count = 0;
    NSMutableArray *getArrayCopy;
    getArrayCopy = [[NSMutableArray alloc]init];
    
    
    for(NSMutableDictionary* temp in getArray ){
        
        //もし、新カテゴリーとの元配列getArrayの子ディクショナリのカテゴリーが一緒だったら
        if ([[temp objectForKey:@"Category"] isEqualToString:CategoryShouldDelete]) {
            
            [temp setObject:@"無分類" forKey:@"Category"];
            [getArrayCopy setObject:temp atIndexedSubscript:count];
            
        }else{
        
            [getArrayCopy setObject:temp atIndexedSubscript:count];
        
        }
        
        count++;
    
    }

    [getArrayCopy writeToFile:wannadoFilepath atomically:YES];
    [app.leftMenuViewContoroller.LeftTable reloadData];
    [app.detailViewContoroller.DetailTable reloadData];
    [app.tmpViewContoroller.myList reloadData];
    
    
}

-(void)didselecetrowatIndexpath{
    
    [self appdelegatemethod];
    
    //LeftTableの何行目が押されて、その行に何が入っているのか判断する。
    
    
    NSString *CategoryName;
    CategoryName = [appdelegate.leftMenuViewContoroller.CategoryArray objectAtIndex:[appdelegate.leftMenuViewContoroller.LeftTable indexPathForSelectedRow].row];
    
    //↑をViewContorollerに保存しておく。
    appdelegate.tmpViewContoroller.CategoryNamefromLeft = CategoryName;
    
    
    //MainViewのテーブルビューを再読み込み。
    [appdelegate.tmpViewContoroller.myList reloadData];
    
    
    
}



-(void)deleteCellFromTableAndArray{
    
    [self appdelegatemethod];
    
    [appdelegate.leftMenuViewContoroller.CategoryArray removeObjectAtIndex:self.indicateRow];
    NSLog(@"%d",self.indicateRow);
    
    //plistのディレクトリを指定
    
    NSString *Filepath;
    Filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Category.plist"];
    
    
    [appdelegate.leftMenuViewContoroller.CategoryArray writeToFile:Filepath atomically:YES];
    
    [appdelegate.leftMenuViewContoroller.LeftTable reloadData];
    
}


@end
