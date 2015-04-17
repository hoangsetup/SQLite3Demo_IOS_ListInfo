//
//  ViewController.h
//  SQLite3Demo_
//
//  Created by Đinh Văn Hoàng on 3/23/15.
//  Copyright (c) 2015 Hoang Dinh Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "EditInfoViewController.h"

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, EditInfoViewControlerDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tblPeople;
@property(nonatomic, strong) DBManager *dbManager;
@property(nonatomic,strong) NSArray *arrPeopleInfo;
@property(nonatomic) int recordIDToEdit;
- (IBAction)addNewRecord:(id)sender;
- (void)loadData;


@end

