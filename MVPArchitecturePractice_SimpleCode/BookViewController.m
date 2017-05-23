//
//  BookViewController.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookViewController.h"
#import "BookPresenter.h"

@interface BookViewController () <BookViewDelegate,UITableViewDataSource,UITableViewDelegate,WKUIDelegate> {
    BookPresenter *bookPresenter;
    NSMutableArray *booksToDisplay;
    NSMutableDictionary * bookInfo;
}

@end

@implementation BookViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate = self;
    bookPresenter = [BookPresenter new];
    //以下方法皆可讓 bookPresenter delegate 設成 BookViewController
    [bookPresenter attachView:self];  // custom method
    //    bookPresenter.delegate = self;
    //    [bookPresenter setDelegate:self];
    [bookPresenter getBooks];
    bookInfo = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return booksToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    bookInfo = booksToDisplay[indexPath.row];
    cell.textLabel.text = [bookInfo valueForKey:internetInfo];
    cell.detailTextLabel.text = @"3";
    //    cell.textLabel.text = [bookInfo valueForKey:BOOK_NAME];
    //    cell.detailTextLabel.text = [bookInfo valueForKey:PRICE];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    bookInfo = booksToDisplay[indexPath.row];
    
    UIAlertController *editAlert = [UIAlertController alertControllerWithTitle:@"資料更改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"書名";
        textField.text = [bookInfo valueForKey:internetInfo];
        //        textField.text = [bookInfo valueForKey:BOOK_NAME];
    }];
    [editAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"書價";
        textField.text = @"3";
        //        textField.text = [bookInfo valueForKey:PRICE];
    }];
    UIAlertAction *editSend = [UIAlertAction actionWithTitle:@"Send" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [bookInfo setObject:editAlert.textFields.firstObject.text forKey:BOOK_NAME];
        [bookInfo setObject:editAlert.textFields.lastObject.text forKey:PRICE];
        booksToDisplay[indexPath.row] = bookInfo;
        [bookPresenter bookPresenterChangeDB:bookPresenter withArray:booksToDisplay withCompletion:^(bool isSucces, id result) {
            
            if (isSucces) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }];
    UIAlertAction *editCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [editAlert addAction:editCancel];
    [editAlert addAction:editSend];
    [self presentViewController:editAlert animated:true completion:nil];
}

#pragma  mark - BookViewDelegate
- (void) bookPresenterStartLoading:(BookPresenter*_Nullable)present {
    
    [_activityIndicator startAnimating];
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}
- (void) bookPresenterFinishLoading:(BookPresenter*_Nullable)present {
    
    [_activityIndicator stopAnimating];
    [_tableView setHidden:false];
    [_emptyView setHidden:true];
    [_activityIndicator setHidden:true];
}
- (void) bookPresenterSetBooks:(BookPresenter*_Nullable)present withArray:(NSMutableArray*_Nullable) books {
    
    booksToDisplay = books;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_tableView reloadData];
    });
}
- (void) bookPresenterSetEmptyBooks:(BookPresenter*_Nullable)present {
    
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}

@end


