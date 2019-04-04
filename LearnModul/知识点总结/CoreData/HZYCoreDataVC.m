//
//  HZYCoreDataVC.m
//  HZYToolBox
//
//  Created by hong  on 2018/12/29.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "HZYCoreDataVC.h"
#import "Student+CoreDataClass.h"
@interface HZYCoreDataVC ()

@end

@implementation HZYCoreDataVC
{
    NSManagedObjectContext * _context;
    NSMutableArray * _dataSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 创建数据库,添加关联类，
//点击Editor -> creatMangedModel sublass
- (void)creatSqlite{
    //1.创建模型对象
    // 获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataModel" withExtension:nil];
    
    // 根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] init];
    
    //2.创建持久化储存助理:数据库
    //利用模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] init];
    
    // 数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];
    NSLog(@"数据库 path = %@",sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;
    // 设置数据库相关信息 添加一个持久化储存库并设置储存类型和路径, NSSQLiteStoreType: SQLite作为储存库
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    if (error) {
        NSLog(@"添加数据库失败:%@",error);
    }else{
        NSLog(@"添加数据库成功");
    }
    
    // 3.创建上下文 保存信息 操作数据库
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 关联持久化助理
    context.persistentStoreCoordinator = store;
    
    _context  = context;
}


#pragma mark - 插入数据
- (void)insertData{
    // 1.根据Entity名称和NSManagerdObjectContext获取一个新的继承于NSmanagerdObject的子类Student
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"student" inManagedObjectContext:_context];
    
    // 2.根据表的Student中的键值，给NSManagedOBject对象赋值
    student.name = [NSString stringWithFormat:@"Mr-%d",arc4random()%100];
    student.age = arc4random()%20;
    student.sex = arc4random()%2 == 0 ? @"美女" : @"帅哥";
    student.height = arc4random()%180;
    student.number = arc4random()%100;
    
    
    // 查询所有数据的请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    _dataSource = [NSMutableArray arrayWithArray:resArray];
//    [self.table]
    
    // 3.保存插入的数据
    NSError *error = nil;
    if ([_context save:&error]) {
//        @"数据插入到数据库成功";
    }else{
//        @"失败";
    }
}

#pragma mark - 删除
- (void)deleteData{
    // 创建删除请求
    NSFetchRequest *deleRequst = [NSFetchRequest fetchRequestWithEntityName:@"student"];
    
    //删除条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"age < %d",10];
    
    //返回会需要删除的对象数组
    NSArray *deleArray = [_context executeFetchRequest:deleRequst error:nil];
    
    // 从数据库中删除
    for (Student *stu in deleArray) {
        [_context deleteObject:stu];
    }
    
    // 没有任何条件就是读取所有数据
    NSFetchRequest *requst = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *resArray = [_context executeFetchRequest:requst error:nil];
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    
    NSError *error = nil;
    // 保存--记住保存
    if ([_context save:&error]) {
        // 删除成功
    }else{
        // 删除失败
    }
}

#pragma mark - 更新
- (void)updateData{
    // 创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"student"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@",@"帅哥"];
    request.predicate = pre;
    
    // 发送请求
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    // 修改
    for (Student *stu in resArray) {
        stu.name = @"且行且珍惜_IOS";
    }
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    
    // 保存
    NSError *error = nil;
    if ([_context save:&error]) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
}


#pragma mark - 读取查询
- (void)readData{
    /**
      谓词的条件指令
     1.比较运算符>、<、==、>=、<=、!=
     例:@"nuber >=99"
     
     2.范围运算符:IN 、 BETWEEN
     例:@"bumber BETWEEN {1,5}"
     @"address In {'shanghai','nanjing'}"
     
     3.字符串本身:SELF
     例: @"SELF == 'APPLE'"
     
     4.字符串相关: BEGINSWITH、ENDSWITH、CONTAINS
     例: @"name CONTAIN[cd] 'ang'" // 包含某个字符串
     @"name BEGINSWITH[C] 'sh'" // 以某个字符串开头
     @"name ENDSWITH[d] 'ang'" // 以某个字符串结束
     
     5.通配符: LIKE
     例: @"name LIKE[cd] '*er*'" // *代表通配符，Like也接受[cd].
     @"name LIKE[cd] '???er'"
     
     *注*: 星号 "*" : 代表0个或多个字符
     问号 "?" : 代表一个字符
     
     6.正则表达式: MATCHES
     例:NSString *regex = @"^A.+e$";// 以A开头，e结尾
     @"name MATHES %@",regex
     
     注:[c]*不区分大小写,[d]不区分发音符合即没有重音符号,[cd]既不区分大小写，也不区分发音符号。
     
     7.合计操作
     ANY,SOME: 指定下列表达式中的任意元素.比如,ANY children.age < 18。
     ALL: 指定下列表达式中的所有元素。比如,ALL children.age < 18。
     NONE: 指定下列表达式中没有的元素。比如,NONE children.age < 18.它在逻辑上等于NOT (ANY ...).
     IN: 等于SQL的IN操作，左边的表达必须出现在右边指定的集合中。比如，name IN {'Ben','Melissa','Nick'}。
     
     提示:
     1.谓词中的匹配指令关键字通常使用大写字母
     2.谓词中可以使用格式字符串
     3.如果通过对象的key
     path指定匹配条件,需要使用%k
     
     */
    
    // 创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"sex = %@",@"美女"];
    request.predicate = pre;
    
    
    // 从第几页开始显示
    // 通过这个属性实现分页
    //request.fetchOffset = 0;
    
    // 每页显示多少条数据
    // request.fetchLimit = 6;
    
    // 发送查询请求,并返回结果
    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
}


// 排序
- (void)sort{
    
    // 创建排序请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"student"];
    
    // 实例化排序对象
    NSSortDescriptor *ageSort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    NSSortDescriptor *numberSort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
    request.sortDescriptors = @[ageSort,numberSort];
    
    // 发送请求
    NSError *error = nil;
    NSArray *resArray = [_context executeFetchRequest:request error:&error];
    
    _dataSource = [NSMutableArray arrayWithArray:resArray];
    if (error == nil) {
        // 按照age 和number 排序
    }else{
        // 排序失败
    }
}
@end
