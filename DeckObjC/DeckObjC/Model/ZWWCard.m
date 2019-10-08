//
//  ZWWCard.m
//  DeckObjC
//
//  Created by Zebadiah Watson on 10/7/19.
//  Copyright © 2019 Zebadiah Watson. All rights reserved.
//
#import "ZWWCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ZWWCard
- (instancetype)initWithCardSuit:(NSString *)suit image:(NSString *)image
{
       self = [super init];
       if (self) {
           //What you are initializing example: _name = name
           _suit = suit;
           _image = image;
       }
       return self;
}
@end

@implementation ZWWCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString * ,id>* )dictionary
{
   NSString * suit = dictionary[@"suit"];
   NSString * image = dictionary[@"image"];
   return [self initWithCardSuit:suit image:image];
}
@end
NS_ASSUME_NONNULL_END
