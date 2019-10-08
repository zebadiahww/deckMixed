//
//  ZWWCard.h
//  DeckObjC
//
//  Created by Zebadiah Watson on 10/7/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZWWCard : NSObject
//MARK: - Properties
@property (nonatomic, copy, readonly) NSString *suit;
@property (nonatomic, copy, readonly) NSString *image;

//MARK: - Initializer
- (instancetype)initWithCardSuit:(NSString *)suit
                           image:(NSString *)image;

//MARK: - Functions
@end

//MARK: - Basically an extension
@interface ZWWCard (JSONConvertable)
- (instancetype)initWithDictionary:(NSDictionary<NSString * , id>* )dictionary;
@end

NS_ASSUME_NONNULL_END
