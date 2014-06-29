//
//  ViewController.m
//  SampleMyApp2
//
//  Created by 橋香代子 on 2014/05/16.
//  Copyright (c) 2014年 Kayoko Hashi. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "checkCell.h"


@interface ViewController ()

@end


//各種インスタンス変数の宣言
@implementation ViewController{
    
    NSDictionary *_listcontent;
    NSString *_text;
    NSString *_wannadoFilepath;
    NSString *_categoryFilepath;
    BOOL _compFlag;
    NSMutableArray *FilteredArray;
    BOOL filter_flag;
    NSString *sortKeyword;
    NSInteger targetAge;
    
}


//これは何をしているんだっけ。。。？
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//これがないとViewが表示されない
-(void)loadView{
    [super loadView];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //wannadoPlistから_myArrayに読み込む
    self.myArray = [NSMutableArray arrayWithContentsOfFile:_wannadoFilepath];
    
    [self.myList reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    filter_flag = NO;
    
    //テーブルビューの呪文など
    [self TableviewSetUp];
    
    //ナビゲーションバーのボタン部分
    [self setupMenuBarButtonItems];
    
    //ナビゲーションバーのスタイルを設定
    [self StyleOfNavigationBar];
    
    //タブバーのスタイルを設定
    [self StyleOfTabBar];
    
    //テキストフィールドのスタイルを設定
    [self StyleOfTextField];
    
    //ステータスバーのスタイルを指定
    [self StyleOfStatusBar];
    
    
    //plistのディレクトリを指定し、その配下から特定のplistをさらに指定する。
    [self SelctPlist];
    [self SelctCategoryPlist];
    
    //テーブルビューにカスタムセルを返すためのやつ
    UINib *nib = [UINib nibWithNibName:@"checkCell" bundle:nil];
    [self.myList registerNib:nib forCellReuseIdentifier:@"checkCell"];

    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma SetUpNavigationBar

///////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setupMenuBarButtonItems {
    
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
   

    
}


- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"resizedMenu-09.png"]
            style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
    
}


- (void)leftSideMenuButtonPressed:(id)sender {
   AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    ViewController *ViewContoroller = self;
    appdelegate.tmpViewContoroller = ViewContoroller;
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma StyleOfEachObject

///////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)StyleOfTabBar{
    
    //self.tabBarController.delegate = self;

    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    ViewController *ViewContoroller = self;
    appdelegate.tmpViewContoroller = ViewContoroller;
    
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];
    self.tabBarController.tabBar.barStyle = UIBarStyleBlackOpaque;

 
}


-(void)StyleOfNavigationBar{
    
    //NavigationBarの設定
    self.title = @"WannaDoList";

    [UINavigationBar alloc];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Futura" size:20];
    titleLabel.text = @"wannadoList";
    titleLabel.textColor = [UIColor whiteColor];
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
     //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
}


-(void)StyleOfTextField{
    

    self.myTextField.borderStyle = UITextBorderStyleNone;

    self.myTextField.backgroundColor = [UIColor colorWithRed:0.69 green:0.702 blue:0.631 alpha:0.5];
    self.myTextField.textColor = [UIColor darkGrayColor];
    self.myTextField.delegate = self;
    self.addBtn.tintColor = [UIColor colorWithRed:0.60 green:0.740 blue:0.639 alpha:1.0];
    
    // 角の丸め
    self.myTextField.layer.cornerRadius = 10.0f;



}

-(void)StyleOfStatusBar{
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            //viewControllerで制御することを伝える。iOS7 からできたメソッド
            [self setNeedsStatusBarAppearanceUpdate];
        }
    
    [self prefersStatusBarHidden];
    [self preferredStatusBarStyle];

}


    
- (BOOL)prefersStatusBarHidden {
        //YESでステータスバーを非表示（NOなら表示）
        return YES;
    }


- (UIStatusBarStyle)preferredStatusBarStyle {
        //文字を白くする
        return UIStatusBarStyleLightContent;
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma Pilst

///////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)SelctPlist{
    
    _wannadoFilepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"wannadoList2.plist"];
    
    NSLog(@"wannadoList2の場所====%@",_wannadoFilepath);
    
    
}

- (void)SelctCategoryPlist{

    _categoryFilepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Category.plist"];

    NSLog(@"カテゴリーリストの場所====%@",_categoryFilepath);
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma TextField

///////////////////////////////////////////////////////////////////////////////////////////////////////////


//テキストフィールドEnterされた時のメソッド
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //リターンを押したらテキストフィールドが閉じる
    [self.myTextField resignFirstResponder];
    return YES;
    
}

//テキストフィールド編集中のメソッド
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    NSLog(@"テキスト編集中");
    
    //ナビゲーションバーを無効にする
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
  

    return YES;
}

//テキストフィールド編集後に呼ばれる
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    NSLog(@"テキスト編集終了");
    
     //ナビゲーションバーを有効にする
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    
    return YES;

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 最大入力文字数
    int maxInputLength = 28;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [self.myTextField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    if ([str length] > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        
        return NO;
    }
    
    return YES;
}

//リターンを押した時の処理。
- (IBAction)myTextReturn:(id)sender {
    
    NSLog(@"ReturnTap!");
    
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma TapedButton

///////////////////////////////////////////////////////////////////////////////////////////////////////////


- (IBAction)AddBtnTap:(id)sender {
    
    //テキストフィールドが空だったら以下のアラートビューを出す。
    if ([self.myTextField.text isEqual:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]
                            
                            initWithTitle:@"テキストが空です。"
                            message:@"文字を入力してください。"
                            delegate:self
                            cancelButtonTitle:@"OK"
                            otherButtonTitles:nil, nil];
        
        [alert show];
        
        }else{
    
            [self ProcessOfBtnAction];
        
            }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"%d",buttonIndex);
    
}


-(void)ProcessOfBtnAction{

    
    //compFlagの初期値はNOにしておく。
    _compFlag = NO;
    
    //ボタン押したらキーボードが閉じる
    [self.myTextField resignFirstResponder];
    
    //テキストフィールドに入力された文字
    _text =self.myTextField.text;
    
    //重要！_myArrayに何も入っていない時だけ初期化
    if (_myArray == nil){
        _myArray = [[NSMutableArray alloc]init];
    }
    
    //myArrayに書き込まれるディクショナリを定義
    [self setDictionary];
    
    // _myArrayをplistへ上書き
    [_myArray writeToFile:_wannadoFilepath atomically:YES];

    //テーブルビューをリロード
    [self.myList reloadData];
    

}

-(void)setDictionary{
    
    //カテゴリーリストを読み込む。
    NSMutableArray *receivedCategoryArray = [[NSMutableArray alloc]init];
    receivedCategoryArray = [NSMutableArray arrayWithContentsOfFile:_categoryFilepath];
    _categoryInt = 1;
    NSString *Category;

    //初期画面から入力したときはカテゴリーが無分類になるようにする
    //他カテゴリーから入力したときは該当カテゴリーにする
    
    if (_CategoryNamefromLeft == nil) {
        
        _categoryInt = 1;
        Category= [NSString stringWithFormat:@"%@",receivedCategoryArray[_categoryInt]];
        
    }else{
        
        Category = _CategoryNamefromLeft;
        if ([ _CategoryNamefromLeft isEqualToString:@"すべて"]) {
            Category = @"無分類";
        }
        
    }
    

    //_myArrayに書き込まれるディクショナリを定義！！！！！
    NSMutableDictionary *tmpDictionary =[NSMutableDictionary dictionary];
    targetAge = 0;
    [tmpDictionary setObject:_text forKey:@"TODO"];
    [tmpDictionary setObject:@"いつやるの？" forKey:@"Limit"];
    [tmpDictionary setObject:[NSNumber numberWithBool:_compFlag] forKey:@"Complete_flag"];
    [tmpDictionary setObject:Category forKey:@"Category"];
    [tmpDictionary setObject:@"memo" forKey:@"Memo"];
    
    //ディクショナリを_myArrayに追加
    [_myArray addObject:tmpDictionary];
    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma TableView

///////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)TableviewSetUp{

    //テーブルビューの設定
    self.myList.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myList.dataSource = self;
    self.myList.delegate = self;
    
    //セルの複数選択を許可しない
    self.myList.allowsMultipleSelectionDuringEditing = NO;


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    [self FilteredArrayMethod];
    

    //左画面をいじってない状態orカテゴリーメニューですべてが選ばれたら
    if( (!self.CategoryNamefromLeft) || ([self.CategoryNamefromLeft isEqualToString:@"すべて"])){
    
        //大元配列のカウントを返す。
        FilteredArray = _myArray;
        return FilteredArray.count;
    
        }else{
        
        
            BOOL flag;
            flag = [self.CategoryNamefromLeft isEqualToString:_CategoryNamefromLeft];
        
        
                if ( flag ) {
            
            
                    //フィルターのかかった配列のカウントを返す。
                    return FilteredArray.count;
            
            
                        }else{
            
                                //そうじゃなかったら元配列のカウントを返す。
                                FilteredArray = _myArray;
                                return FilteredArray.count;
                        }

                }

}
    


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 /*
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
        if(cell == nil){
        
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
                        }
  */
    
    checkCell *checkCell  = [tableView dequeueReusableCellWithIdentifier:@"checkCell"
                                                                    forIndexPath:indexPath];
    
    //カスタムセルに行数を覚えさせる
    checkCell.indicatedRow = indexPath.row;
    
    //配列の中の子ディクショナリにフィルターのかかった配列の中身を代入
    _listcontent = FilteredArray[indexPath.row];
    
    
    if( (!self.CategoryNamefromLeft) || ([self.CategoryNamefromLeft isEqualToString:@"すべて"])){
        
        //親配列の中の子ディクショナリを取り出す
        NSDictionary *listContents = _myArray[indexPath.row];
        
        //取り出した子ディクショナリの中からKeyがTODOの要素をセルに返す
        checkCell.todoLabel.text = [NSString stringWithFormat:@"%@",[listContents objectForKey:@"TODO"]];
        
            }else{
    
                BOOL flag;
                flag = [self.CategoryNamefromLeft isEqualToString:_CategoryNamefromLeft];
        
                    if ( flag ) {

            checkCell.todoLabel.text = [NSString stringWithFormat:@"%@",[_listcontent objectForKey:@"TODO"]];
            
            NSLog(@"FilteredArray=%@",FilteredArray);
    
                                }
                    }
     checkCell.todoLabel.textColor = [UIColor darkGrayColor];
     checkCell.todoLabel.font = [UIFont fontWithName:@"Hiragino Kaku Gothic Pro" size:16];
    return checkCell;
    
}


//行が選択された時のメソッド
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //ストーリーボードからDetailというIDがついてるViewControllerをインスタンス化
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    //どの行が押されたか、detailViewに伝えるために値を代入
    dvc.myCount = indexPath.row;
    dvc.getArray = self.myArray;
    
    dvc.sikanai_CategoryNamefromLeft = self.CategoryNamefromLeft;
    
    //ナビゲーションコントローラーの機能でDetailViewControllerに画面遷移
    [[self navigationController] pushViewController:dvc animated:YES];
    
    NSLog(@"CellTap!");
   
}

//テーブルビューが編集状態になっている時に呼ばれるメソッド
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //左カテゴリーメニューを何も選択していない状態か、すべてが押されたとき

    if( (!self.CategoryNamefromLeft) || ([self.CategoryNamefromLeft isEqualToString:@"すべて"])){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
        
            // 削除ボタンが押された行のデータを配列から削除します。
            [_myArray removeObjectAtIndex:indexPath.row];
            //消去ボタンが押された行をテーブルビューから削除します。
            [_myList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            //削除された情報をplistへ上書きする。
            [_myArray writeToFile:_wannadoFilepath atomically:YES];
        
                }else if (editingStyle == UITableViewCellEditingStyleInsert) {
                    // ここは空のままでOKです。
                                                                                }
                    }else{
        
                        // 削除ボタンが押された行のデータを配列から削除します。
        
                        int i = 0;
                        int count = 0;
                        NSMutableArray *tmpMyArray = [[NSMutableArray alloc]init];
                        tmpMyArray = _myArray;
        
                        for(NSMutableDictionary* temp in tmpMyArray){
            
                                if ([[temp objectForKey:@"Category"] isEqualToString:self.CategoryNamefromLeft]) {
                                        if(i == indexPath.row){
                                            
                                            NSIndexPath* tempindex = [[NSIndexPath alloc] init];
                                            tempindex = [NSIndexPath indexPathForRow:count inSection:0];
                    
                    
                                                //配列そのものから削除
                                                [_myArray removeObjectAtIndex:count];
                    
                                                //消去ボタンが押された行をテーブルビューから削除します。
                                                [_myList deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                                                //削除された情報をplistへ上書きする。
                                                [_myArray writeToFile:_wannadoFilepath atomically:YES];
                    
                                                                }
            
                                    i++;
                                }
            count++;
            break;
        }
    
        
    }
    

    
}


//編集モードかどうか判断するメソッド
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [_myList setEditing:editing animated:animated];
    
    if (editing) { // 現在編集モードです。;
        self.navigationItem.leftBarButtonItem.enabled = NO; //セルの編集中ナビバーの左ボタン無効
        self.myTextField.enabled = NO;
        
    } else { // 現在通常モードです。
        self.navigationItem.leftBarButtonItem.enabled = YES; //通常モードで有効
        self.myTextField.enabled = YES;
    }
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////


-(void)FilteredArrayMethod{
    
    
    //フィルター用の配列
    FilteredArray = [NSMutableArray array];
    
    //myArrayから一つずつ子ディクショナリをfiliterdDicとして取り出す
    for (NSMutableDictionary * FiltererdDic in _myArray){
        
        //もしfilteredDicのカテゴリーが左側の画面で押された行の中身と同じだったら。
        if( [[FiltererdDic objectForKey:@"Category"] isEqualToString:_CategoryNamefromLeft]){
            
            //フィルター用の配列にその子ディクショナリを入れていく。無分類じゃなかったら無視！
            [FilteredArray addObject:FiltererdDic];
    
        }
        
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
