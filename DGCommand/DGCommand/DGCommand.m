//
// DGCommand.m
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

#import "DGCommand.h"

@interface DGCommand ()
@property (strong, nonatomic) NSMutableDictionary *retainer;
@property (strong, nonatomic) NSMutableDictionary *container;
@end

@implementation DGCommand
@synthesize retainer = _retainer;
@synthesize container = _container;

// Singleton initializer
+ (id)sharedCommand {
	static DGCommand *sharedCommand = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedCommand = [[self alloc] init];
	});
	return sharedCommand;
}

// Initializers
- (id)init {
    return [self initFromFile:nil];
}

- (id)initFromFile:(NSString *)fileName {
    self = [super init];
	if (self) {
        _container = [[NSMutableDictionary alloc] init];
		[self restoreFromFile:fileName];
	}
    return self;
}

+ (instancetype)command {
	return [[self alloc] init];
}

+ (instancetype)commandFromFile:(NSString *)fileName {
	return [[self alloc] initFromFile:fileName];
}

// Setting objects
- (void)setObject:(NSObject *)object forKey:(NSString *)key retained:(BOOL)retained {
    [self removeObjectForKey:key];
    if (retained) {
		// Only the following objects may be saved to a plist
        if ([object isKindOfClass:[NSArray class]] ||
            [object isKindOfClass:[NSDictionary class]] ||
            [object isKindOfClass:[NSData class]] ||
            [object isKindOfClass:[NSString class]] ||
            [object isKindOfClass:[NSNumber class]] ||
            [object isKindOfClass:[NSDate class]]) {
			[self.retainer setObject:object forKey:key];
			return;
		}
		NSLog(@"DGCommand: object type cannot be saved to a .plist and will not be retained");
	}
	[self.container setObject:object forKey:key];
}

- (void)setInt:(int)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithInt:number] forKey:key retained:retained];
}

- (void)setShort:(short)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithShort:number] forKey:key retained:retained];
}

- (void)setLong:(long)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithLong:number] forKey:key retained:retained];
}

- (void)setLongLong:(long long)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithLongLong:number] forKey:key retained:retained];
}

- (void)setFloat:(float)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithFloat:number] forKey:key retained:retained];
}

- (void)setDouble:(double)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithDouble:number] forKey:key retained:retained];
}

- (void)setChar:(char)character forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithChar:character] forKey:key retained:retained];
}

- (void)setBool:(BOOL)boolean forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithBool:boolean] forKey:key retained:retained];
}

- (void)setInteger:(NSInteger)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithInteger:number] forKey:key retained:retained];
}

- (void)setUnsignedInt:(unsigned int)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedInt:number] forKey:key retained:retained];
}

- (void)setUnsignedShort:(unsigned short)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedShort:number] forKey:key retained:retained];
}

- (void)setUnsignedLong:(unsigned long)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedLong:number] forKey:key retained:retained];
}

- (void)setUnsignedLongLong:(unsigned long long)number forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedLongLong:number] forKey:key retained:retained];
}

- (void)setUnsignedChar:(unsigned char)character forKey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedChar:character] forKey:key retained:retained];
}

- (void)setUnsignedInteger:(NSUInteger)number forkey:(NSString *)key retained:(BOOL)retained {
    [self setObject:[NSNumber numberWithUnsignedInteger:number] forKey:key retained:retained];
}

// Getting objects
- (id)objectForKey:(NSString *)key {
	return [self.retainer objectForKey:key] ? : [self.container objectForKey:key];
}

- (int)intForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] intValue];
}

- (short)shortForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] shortValue];
}

- (long)longForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] longValue];
}

- (long long)longLongForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] longLongValue];
}

- (float)floatForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] floatValue];
}

- (double)doubleForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] doubleValue];
}

- (char)charForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] charValue];
}

- (BOOL)boolForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] boolValue];
}

- (NSInteger)integerForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] integerValue];
}

- (unsigned int)unsignedIntForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedIntValue];
}

- (unsigned short)unsignedShortForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedShortValue];
}

- (unsigned long)unsignedLongForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedLongValue];
}

- (unsigned long long)unsignedLongLongForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedLongLongValue];
}

- (unsigned char)unsignedCharForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedCharValue];
}

- (NSUInteger)unsignedIntegerForKey:(NSString *)key {
    return [(NSNumber *)[self objectForKey:key] unsignedIntegerValue];
}

// Checking for objects
- (BOOL)objectExistsForKey:(NSString *)key {
    return [self.retainer objectForKey:key] || [self.container objectForKey:key];
}

// Removing objects
- (void)removeObjectForKey:(NSString *)key {
    [self.retainer removeObjectForKey:key];
    [self.container removeObjectForKey:key];
}

- (void)removeUnretainedObjects {
    [self.container removeAllObjects];
}

- (void)removeRetainedObjects {
    [self.retainer removeAllObjects];
}

- (void)removeAllObjects {
    [self removeUnretainedObjects];
	[self removeRetainedObjects];
}

// Saving and restoring state
- (void)saveToFile:(NSString *)fileName {
	@try {
		NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		[self.retainer writeToFile:[dir stringByAppendingPathComponent:fileName] atomically:YES];
	}
	@catch (NSException *exception) {
		NSLog(@"DGCommand: error in writing to file. %@",exception);
	}
}

- (void)restoreFromFile:(NSString *)fileName {
	@try {
		NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		self.retainer = [NSMutableDictionary dictionaryWithContentsOfFile:[dir stringByAppendingPathComponent:fileName]] ? : [NSMutableDictionary dictionary];
	}
	@catch (NSException *exception) {
		NSLog(@"DGCommand: error in reading from file. %@",exception);
	}
}

// NSCopying protocol
- (id)copyWithZone:(NSZone *)zone {
    DGCommand *copyCommand = [[DGCommand alloc] init];
    if (copyCommand) {
        copyCommand.retainer = [self.retainer mutableCopyWithZone:zone];
        copyCommand.container = [self.container mutableCopyWithZone:zone];
    }
    return copyCommand;
}

// Dealloc override
- (void)dealloc {
    [self removeAllObjects];
}

@end
