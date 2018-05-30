//
//  ViewController.h
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 29/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EditInfoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;

- (IBAction)addNewRecord:(UIBarButtonItem *)sender;

@end

