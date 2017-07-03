//
//  Login+CoreDataProperties.h
//  YueTing
//
//  Created by lanouhn on 16/3/18.
//  Copyright © 2016年 Orange. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Login.h"

NS_ASSUME_NONNULL_BEGIN

@interface Login (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *zhubo;
@property (nullable, nonatomic, retain) NSString *jishu;
@property (nullable, nonatomic, retain) NSString *renqi;
@property (nullable, nonatomic, retain) NSString *state;
@property (nullable, nonatomic, retain) NSString *idC;

@end

NS_ASSUME_NONNULL_END
