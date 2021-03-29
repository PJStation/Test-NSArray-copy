//
//  TestCopyArray.m
//  Test-NSArray-copy
//
//  Created by 孙鹏举 on 2021/3/23.
//

#import "TestCopyArray.h"

@interface TestCopyArray ()

@property (nonatomic, copy) NSArray *array;

@property (nonatomic, copy) NSArray *array2;
// !!!: 不可变对象禁止使用strong修饰，有可能会导致array3指向可变对象，导致危险操作
@property (nonatomic, strong) NSArray *array3;

@property (nonatomic, strong) NSMutableArray *array4;

// !!!: 可变对象禁止使用copy，本身就是可变对象，如果setter方法里传入mutable对象的copy操作导致自己变成新的对象
@property (nonatomic, copy) NSMutableArray *array5;

@end

@implementation TestCopyArray

- (instancetype)init{
    if (self = [super init]) {
        NSObject *obj = [NSObject new];
        _array = @[obj];
        
        self.array4 = [NSMutableArray arrayWithArray:_array];
        // !!!: array4是可变对象，array5只需引用即可（指针指向array4），setter方法里的mutable对象copy操作生成了新的对象
        self.array5 = self.array4;
        // !!!: 不可变对象指向了可变的引用，array4会导致array3的改变，危险操作
        self.array3 = self.array4;
        
        
       
        [_array5 release];
        [_array4 release];
        [_array3 release];
//        [_array2 release];
        [_array release];
    }
    
    return self;
}
- (void)dealloc {
    [super dealloc];
    NSLog(@"dealloc");
}
// 先copy
- (void)setArray:(NSArray *)array{
    id t = [array copy];
    [_array release];
    _array = t;
}

- (void)setArray2:(NSArray *)array2{
    //有可能传入的是array2是mutable对象，copy会分配新的内存，新的对象
    id t = [array2 copy];
    [_array2 release];
    _array2 = t;
}

- (void)setArray3:(NSArray *)array3 {
    [array3 retain];
    [_array3 release];
    _array3 = array3;
}

// 先retain
-(void)setArray4:(NSMutableArray *)array4{
    [array4 retain];
    [_array4 release];
    _array4 = array4;
}

- (void)setArray5:(NSMutableArray *)array5{
    id t = [array5 copy];
    [_array5 release];
    _array5 = t;
}
@end
