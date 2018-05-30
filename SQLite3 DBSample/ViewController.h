//
//  ViewController.h
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 29/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;

- (IBAction)addNewRecord:(UIBarButtonItem *)sender;

@end

