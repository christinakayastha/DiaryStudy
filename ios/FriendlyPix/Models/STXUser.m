//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "STXUser.h"
#import <KZPropertyMapper.h>

@interface STXUser ()

@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *fullname;
@property (copy, nonatomic) NSURL *profilePictureURL;

@end

@implementation STXUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSArray *errors;
        NSDictionary *mappingDictionary = @{ @"id": KZProperty(userID),
                                             @"username": KZProperty(username),
                                             @"full_name": KZProperty(fullname),
                                             @"profile_picture": KZBox(URL, profilePictureURL) };
        
        [KZPropertyMapper mapValuesFrom:dictionary toInstance:self usingMapping:mappingDictionary errors:&errors];
    }
    
    return self;
}

- (NSUInteger)hash
{
    return [_userID hash];
}

- (BOOL)isEqualToUser:(STXUser *)user
{
    return [user.userID isEqualToString:_userID];
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[STXUser class]]) {
        return NO;
    }
    
    return [self isEqualToUser:(STXUser *)object];
}

- (NSString *)description
{
    NSDictionary *dictionary = @{ @"userID": self.userID ? : @"",
                                  @"username": self.username ? : @"",
                                  @"fullname": self.fullname ? : @"",
                                  @"profilePictureURL": self.profilePictureURL ? : @"" };
    return [NSString stringWithFormat:@"<%@: %p> %@", NSStringFromClass([self class]), self, dictionary];
}

@end