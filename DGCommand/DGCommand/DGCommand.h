//
// DGCommand.h
// DGCommand
//
// Copyright (c) 2014 Devin Gund. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface DGCommand : NSObject <NSCopying> {
	@private NSMutableDictionary *_retainer;
	@private NSMutableDictionary *_container;
}

// Singleton initializer
+ (id)sharedCommand;

// Initializers
- (id)init;
- (id)initFromFile:(NSString *)fileName;
+ (instancetype)command;
+ (instancetype)commandFromFile:(NSString *)fileName;

// Setting objects
- (void)setObject:(NSObject *)object forKey:(NSString *)key retained:(BOOL)retained;
- (void)setInt:(int)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setShort:(short)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setLong:(long)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setLongLong:(long long)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setFloat:(float)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setDouble:(double)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setChar:(char)character forKey:(NSString *)key retained:(BOOL)retained;
- (void)setBool:(BOOL)boolean forKey:(NSString *)key retained:(BOOL)retained;
- (void)setInteger:(NSInteger)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedInt:(unsigned int)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedShort:(unsigned short)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedLong:(unsigned long)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedLongLong:(unsigned long long)number forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedChar:(unsigned char)character forKey:(NSString *)key retained:(BOOL)retained;
- (void)setUnsignedInteger:(NSUInteger)number forkey:(NSString *)key retained:(BOOL)retained;

// Getting objects
- (id)objectForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (short)shortForKey:(NSString *)key;
- (long)longForKey:(NSString *)key;
- (long long)longLongForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (double)doubleForKey:(NSString *)key;
- (char)charForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key;
- (unsigned int)unsignedIntForKey:(NSString *)key;
- (unsigned short)unsignedShortForKey:(NSString *)key;
- (unsigned long)unsignedLongForKey:(NSString *)key;
- (unsigned long long)unsignedLongLongForKey:(NSString *)key;
- (unsigned char)unsignedCharForKey:(NSString *)key;
- (NSUInteger)unsignedIntegerForKey:(NSString *)key;

// Checking for objects
- (BOOL)objectExistsForKey:(NSString *)key;

// Removing objects
- (void)removeObjectForKey:(NSString *)key;
- (void)removeUnretainedObjects;
- (void)removeRetainedObjects;
- (void)removeAllObjects;

// Saving and restoring state
- (void)saveToFile:(NSString *)fileName;
- (void)restoreFromFile:(NSString *)fileName;

@end
