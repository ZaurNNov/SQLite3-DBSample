//
//  ViewController.m
//  SQLite3 DBSample
//
//  Created by Zaur Giyasov on 29/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ViewController.h"
#import "DBManager.h"

@interface ViewController ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSArray *arrPeopleInfo;

@property (nonatomic) int recordIDToEdit;

-(void)loadData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Make self the delegate
    self.tblPeople.delegate = self;
    self.tblPeople.dataSource = self;
    
    // init dataBase
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"sampledb.sql"];
    
    // load the data
    [self loadData];
}

-(void)addNewRecord:(UIBarButtonItem *)sender {
    // before performing the seque. set -1 value
    self.recordIDToEdit = -1;
    
    // perform the seque
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

-(void)loadData {
    // Form the query
    NSString *query = @"select * from peopleInfo";
    
    // get the results
    if (self.arrPeopleInfo != nil) {
        self.arrPeopleInfo = nil;
    }
    self.arrPeopleInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // reload the tableView
    [self.tblPeople reloadData];
}

// TableView general methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrPeopleInfo.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    NSInteger indexOfFirstname = [self.dbManager.arrColumnNames indexOfObject:@"firstname"];
    NSInteger indexOfLastname = [self.dbManager.arrColumnNames indexOfObject:@"lastname"];
    NSInteger indexOfAge = [self.dbManager.arrColumnNames indexOfObject:@"age"];
    
    // Set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",
                           [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfFirstname],
                           [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfLastname]];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@",
                                 [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfAge]];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Age: %@",
//                                 [[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:3]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // Get the record ID
    self.recordIDToEdit = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // perform the seque
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // delete the selected record
        // find the record
        int recordIDToDelete = [[[self.arrPeopleInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query
        NSString *query = [NSString stringWithFormat:@"delete from peopleInfoID=%d", recordIDToDelete];
        
        // Execute the query
        [self.dbManager executeQuery:query];
        
        // reload the tableView
        [self loadData];
        
    }
}

-(void)editingInfoWasFinished {
    // Reload the data
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EditInfoViewController *eiVC = [segue destinationViewController];
    eiVC.selfDelegate = self;
    eiVC.recordIDToEdit = self.recordIDToEdit;
}

@end


