//
//  LeftViewController.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "LeftViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "AddNewCategoryCell.h"
#import "RemovableCell.h"

@interface LeftViewController ()

@end

@implementation LeftViewController{
    
    NSString *_CategoryFilepath;
    NSString *_WannadoFilepath;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //ここでエラーが出てた
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //テーブルビューのためのあれ
    [self setUpTableView];
    
    //カテゴリーリストの読み込み 書き込むまえにやるの！！！
    [self SelctCategoryPlist];
    _CategoryArray = [NSMutableArray arrayWithContentsOfFile:_CategoryFilepath];
    
    //カテゴリーリストの配列を定義
    [self setUpCategoryList];
   
    //カスタムセルを使うためのnib登録
    [self setUpNibForCustomCell];
    
     self.view.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];

}


-(void)viewWillAppear:(BOOL)animated{
    
    
    
    //テーブルビューの再読み込み
    [self.LeftTable reloadData];
    
}


-(void)setUpNibForCustomCell{

    UINib *nib = [UINib nibWithNibName:@"AddNewCategoryCell" bundle:nil];
    [self.LeftTable registerNib:nib forCellReuseIdentifier:@"LastCell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"RemovableCell" bundle:nil];
    [self.LeftTable registerNib:nib2 forCellReuseIdentifier:@"RemovableCell"];

}

//カテゴリーリスト用のパスを準備する。
- (void)SelctCategoryPlist{
    //plistのディレクトリを指定
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    //指定されたディレクトリ配下から指定のplist
    _CategoryFilepath = [documentsDirectory stringByAppendingPathComponent:@"Category.plist"];
    
}

- (void)SelectWannadoPlist{
    
    //WannadoList用のパスを作る準備。
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    
    //指定されたディレクトリ配下から指定のplist
    _WannadoFilepath = [documentsDirectory stringByAppendingPathComponent:@"wannadoList2.plist"];
    
}


-(void)setUpCategoryList{
    
    //カテゴリーリストの配列
    if (_CategoryArray == nil) {
        
        _CategoryArray = [[NSMutableArray alloc]init];
        [_CategoryArray addObject:@"すべて"];
        [_CategoryArray addObject:@"無分類"];
        [_CategoryArray addObject:@"ライフイベント"];
        
        //カテゴリー用のplistのディレクトリを指定し、カテゴリーリストの配列を書き込む
        [self SelctCategoryPlist];
        [_CategoryArray writeToFile:_CategoryFilepath atomically:YES];

    }
    
    

}

#pragma tableView

-(void)setUpTableView{

    self.LeftTable.dataSource = self;
    self.LeftTable.delegate = self;
    self.LeftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.LeftTable.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:0.3];
    self.LeftTable.sectionHeaderHeight = 40;
   
    
}

//セクションの数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;

}

//セクションタイトル
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    sectionView.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:0.3];
    sectionView.frame = CGRectMake(0.0f, 0.0f, 320.0f, 64.0f);
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 40)];
    sectionLabel.textColor = [UIColor whiteColor];
    [sectionView addSubview:sectionLabel];
    
    if ( section == 0){
    
        sectionLabel.text = @"  新規カテゴリーを追加";
        return sectionView;
        
        }else{
    
        sectionLabel.text = @"  カテゴリー";
            return sectionView;
            
    }
    
}




//各セクションごとの行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if ( section == 0) {
        
        return 1;
        
        
            }else{
    
                return _CategoryArray.count;
        
     }
}


//カテゴリー用の配列をセルに返す
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //セクションが１のとき
    if ( indexPath.section == 1) {
        
    
        if (indexPath.row <= 2) {
            
            static NSString *CellIdentifer = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
            
            if (cell == nil){
                
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@",_CategoryArray[indexPath.row]];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:0.3];
            
            return cell;
            
            
        }else{
            
            
            RemovableCell *removableCell = [tableView dequeueReusableCellWithIdentifier:@"RemovableCell"
                                                                           forIndexPath:indexPath];
            removableCell.removableLabel.text = [NSString stringWithFormat:@"%@",_CategoryArray[indexPath.row]];
            
            //カスタムセルに行数を覚えさせる
            removableCell.indicateRow = indexPath.row;
            
            return removableCell;
            
            
        }

    
            }else{
        
        
                AddNewCategoryCell *lastCell = [tableView dequeueReusableCellWithIdentifier:@"LastCell"
                                                                       forIndexPath:indexPath];
        
        
                lastCell.row = indexPath.row;
        
                return lastCell;
        
        
            }

}


//セルが選択されとき
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //アップデリゲートをインスタンス化
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //LeftTableの何行目が押されて、その行に何が入っているのか判断する。
    NSString *CategoryName;
    CategoryName = [_CategoryArray objectAtIndex:[self.LeftTable indexPathForSelectedRow].row];
    
    //↑をViewContorollerに保存しておく。
    appdelegate.tmpViewContoroller.CategoryNamefromLeft = CategoryName;

    //ライブラリの機能で画面遷移。
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        }];
    
    //MainViewのテーブルビューを再読み込み。
    [appdelegate.tmpViewContoroller.myList reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
