//
//  BookPresenter.h
//  MVPArchitecturePractice_SimpleCode
//
//  Created by Daniel on 2017/4/20.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookPresenterDelegate <NSObject>

- (void) startLoading;
- (void) finishLoading;
- (void) setBooksWithArray:(NSObject*) books;
- (void) setEmptyBooks;

@end
@interface BookPresenter : NSObject
@property NSString *bookName;
@property int price;

- (void)attachView:(id<BookPresenterDelegate>)delegate;
- (void)getBooks;
@end
