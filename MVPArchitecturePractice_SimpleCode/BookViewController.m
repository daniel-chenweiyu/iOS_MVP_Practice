//
//  BookViewController.m
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "BookViewController.h"
#import "BookPresenter.h"
#import "Book.h"


@interface BookViewController () <BookPresenterDelegate,UITableViewDataSource> {
    BookPresenter *bookPresenter;
    NSArray *booksToDisplay;
}

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    bookPresenter = [BookPresenter new];
    [bookPresenter attachView:self];
    [bookPresenter getBooks];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return booksToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Book *bookIfo = [Book new];
    bookIfo = booksToDisplay[indexPath.row];
    NSString *priceString = [NSString stringWithFormat:@"%d",bookIfo.price];
    
    cell.textLabel.text = bookIfo.bookName;
    cell.detailTextLabel.text = priceString;
    return cell;
}
- (void)startLoading {
    
    [_activityIndicator startAnimating];
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}

- (void)finishLoading {
    
    [_activityIndicator stopAnimating];
    [_tableView setHidden:false];
    [_emptyView setHidden:true];
    [_activityIndicator setHidden:true];
}

- (void)setBooksWithArray:(NSArray *)books {
    
    booksToDisplay = books;
    [_tableView reloadData];
}

- (void)setEmptyBooks {
    
    [_tableView setHidden:true];
    [_emptyView setHidden:false];
}

@end


