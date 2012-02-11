// Generated by O/R mapper generator ver 1.1

#import "Database.h"
#import "TransactionBase.h"

@implementation TransactionBase

@synthesize asset = mAsset;
@synthesize dstAsset = mDstAsset;
@synthesize date = mDate;
@synthesize type = mType;
@synthesize category = mCategory;
@synthesize value = mValue;
@synthesize description = mDescription;
@synthesize memo = mMemo;

- (id)init
{
    self = [super init];
    return self;
}


/**
  @brief Migrate database table

  @return YES - table was newly created, NO - table already exists
*/

+ (BOOL)migrate
{
    NSArray *columnTypes = [NSArray arrayWithObjects:
        @"asset", @"INTEGER",
        @"dst_asset", @"INTEGER",
        @"date", @"DATE",
        @"type", @"INTEGER",
        @"category", @"INTEGER",
        @"value", @"REAL",
        @"description", @"TEXT",
        @"memo", @"TEXT",
        nil];

    return [super migrate:columnTypes primaryKey:@"key"];
}

#pragma mark Read operations

/**
  @brief get the record matchs the id

  @param pid Primary key of the record
  @return record
*/
+ (Transaction *)find:(int)pid
{
    Database *db = [Database instance];

    dbstmt *stmt = [db prepare:@"SELECT * FROM Transactions WHERE key = ?;"];
    [stmt bindInt:0 val:pid];

    return [self find_first_stmt:stmt];
}

/**
  finder with asset

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_asset:(int)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE asset = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE asset = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindInt:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_asset:(int)key
{
    return [self find_by_asset:key cond:nil];
}

/**
  finder with dst_asset

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_dst_asset:(int)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE dst_asset = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE dst_asset = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindInt:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_dst_asset:(int)key
{
    return [self find_by_dst_asset:key cond:nil];
}

/**
  finder with date

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_date:(NSDate*)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE date = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE date = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindDate:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_date:(NSDate*)key
{
    return [self find_by_date:key cond:nil];
}

/**
  finder with type

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_type:(int)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE type = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE type = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindInt:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_type:(int)key
{
    return [self find_by_type:key cond:nil];
}

/**
  finder with category

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_category:(int)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE category = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE category = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindInt:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_category:(int)key
{
    return [self find_by_category:key cond:nil];
}

/**
  finder with value

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_value:(double)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE value = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE value = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindDouble:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_value:(double)key
{
    return [self find_by_value:key cond:nil];
}

/**
  finder with description

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_description:(NSString*)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE description = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE description = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindString:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_description:(NSString*)key
{
    return [self find_by_description:key cond:nil];
}

/**
  finder with memo

  @param key Key value
  @param cond Conditions (ORDER BY etc)
  @note If you specify WHERE conditions, you must start cond with "AND" keyword.
*/
+ (Transaction*)find_by_memo:(NSString*)key cond:(NSString *)cond
{
    if (cond == nil) {
        cond = @"WHERE memo = ? LIMIT 1";
    } else {
        cond = [NSString stringWithFormat:@"WHERE memo = ? %@ LIMIT 1", cond];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    [stmt bindString:0 val:key];
    return [self find_first_stmt:stmt];
}

+ (Transaction*)find_by_memo:(NSString*)key
{
    return [self find_by_memo:key cond:nil];
}


/**
  Get first record matches the conditions

  @param cond Conditions (WHERE phrase and so on)
  @return array of records
*/
+ (Transaction *)find_first:(NSString *)cond
{
    if (cond == nil) {
        cond = @"LIMIT 1";
    } else {
        cond = [cond stringByAppendingString:@" LIMIT 1"];
    }
    dbstmt *stmt = [self gen_stmt:cond];
    return  [self find_first_stmt:stmt];
}

/**
  Get all records match the conditions

  @param cond Conditions (WHERE phrase and so on)
  @return array of records
*/
+ (NSMutableArray *)find_all:(NSString *)cond
{
    dbstmt *stmt = [self gen_stmt:cond];
    return  [self find_all_stmt:stmt];
}

/**
  @brief create dbstmt

  @param s condition
  @return dbstmt
*/
+ (dbstmt *)gen_stmt:(NSString *)cond
{
    NSString *sql;
    if (cond == nil) {
        sql = @"SELECT * FROM Transactions;";
    } else {
        sql = [NSString stringWithFormat:@"SELECT * FROM Transactions %@;", cond];
    }  
    dbstmt *stmt = [[Database instance] prepare:sql];
    return stmt;
}

/**
  Get first record matches the conditions

  @param stmt Statement
  @return array of records
*/
+ (Transaction *)find_first_stmt:(dbstmt *)stmt
{
    if ([stmt step] == SQLITE_ROW) {
        TransactionBase *e = [[self class] new];
        [e _loadRow:stmt];
        return (Transaction *)e;
    }
    return nil;
}

/**
  Get all records match the conditions

  @param stmt Statement
  @return array of records
*/
+ (NSMutableArray *)find_all_stmt:(dbstmt *)stmt
{
    NSMutableArray *array = [NSMutableArray new];

    while ([stmt step] == SQLITE_ROW) {
        TransactionBase *e = [[[self class] alloc] init];
        [e _loadRow:stmt];
        [array addObject:e];

    }
    return array;
}

- (void)_loadRow:(dbstmt *)stmt
{
    self.pid = [stmt colInt:0];
    self.asset = [stmt colInt:1];
    self.dstAsset = [stmt colInt:2];
    self.date = [stmt colDate:3];
    self.type = [stmt colInt:4];
    self.category = [stmt colInt:5];
    self.value = [stmt colDouble:6];
    self.description = [stmt colString:7];
    self.memo = [stmt colString:8];
}

#pragma mark Create operations

- (void)_insert
{
    Database *db = [Database instance];
    dbstmt *stmt;
    
    //[db beginTransaction];
    stmt = [db prepare:@"INSERT INTO Transactions VALUES(NULL,?,?,?,?,?,?,?,?);"];
    [stmt bindInt:0 val:mAsset];
    [stmt bindInt:1 val:mDstAsset];
    [stmt bindDate:2 val:mDate];
    [stmt bindInt:3 val:mType];
    [stmt bindInt:4 val:mCategory];
    [stmt bindDouble:5 val:mValue];
    [stmt bindString:6 val:mDescription];
    [stmt bindString:7 val:mMemo];
    [stmt step];

    self.pid = [db lastInsertRowId];

    //[db commitTransaction];

    [[Database instance] setModified];
}

#pragma mark Update operations

- (void)_update
{
    Database *db = [Database instance];
    //[db beginTransaction];

    dbstmt *stmt = [db prepare:@"UPDATE Transactions SET "
        "asset = ?"
        ",dst_asset = ?"
        ",date = ?"
        ",type = ?"
        ",category = ?"
        ",value = ?"
        ",description = ?"
        ",memo = ?"
        " WHERE key = ?;"];
    [stmt bindInt:0 val:mAsset];
    [stmt bindInt:1 val:mDstAsset];
    [stmt bindDate:2 val:mDate];
    [stmt bindInt:3 val:mType];
    [stmt bindInt:4 val:mCategory];
    [stmt bindDouble:5 val:mValue];
    [stmt bindString:6 val:mDescription];
    [stmt bindString:7 val:mMemo];
    [stmt bindInt:8 val:mPid];

    [stmt step];
    //[db commitTransaction];

    [[Database instance] setModified];
}

#pragma mark Delete operations

/**
  @brief Delete record
*/
- (void)delete
{
    Database *db = [Database instance];

    dbstmt *stmt = [db prepare:@"DELETE FROM Transactions WHERE key = ?;"];
    [stmt bindInt:0 val:mPid];
    [stmt step];

    [[Database instance] setModified];
}

/**
  @brief Delete all records
*/
+ (void)delete_cond:(NSString *)cond
{
    Database *db = [Database instance];

    if (cond == nil) {
        cond = @"";
    }
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM Transactions %@;", cond];
    [db exec:sql];

    [[Database instance] setModified];
}

+ (void)delete_all
{
    [TransactionBase delete_cond:nil];
}

/**
 * get table sql
 */
+ (void)getTableSql:(NSMutableString *)s
{
    [s appendString:@"DROP TABLE Transactions;\n"];
    [s appendString:@"CREATE TABLE Transactions (key INTEGER PRIMARY KEY"];

    [s appendFormat:@", asset INTEGER"];
    [s appendFormat:@", dst_asset INTEGER"];
    [s appendFormat:@", date DATE"];
    [s appendFormat:@", type INTEGER"];
    [s appendFormat:@", category INTEGER"];
    [s appendFormat:@", value REAL"];
    [s appendFormat:@", description TEXT"];
    [s appendFormat:@", memo TEXT"];
    
    [s appendString:@");\n"];

    NSMutableArray *ary = [self find_all:nil];
    for (TransactionBase *e in ary) {
        [e getInsertSql:s];
        [s appendString:@"\n"];
    }
}

/**
 * get "INSERT" SQL
 */
- (void)getInsertSql:(NSMutableString *)s
{
    [s appendFormat:@"INSERT INTO Transactions VALUES(%d", mPid];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[NSString stringWithFormat:@"%d", mAsset]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[NSString stringWithFormat:@"%d", mDstAsset]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[[Database instance] stringFromDate:mDate]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[NSString stringWithFormat:@"%d", mType]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[NSString stringWithFormat:@"%d", mCategory]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:[NSString stringWithFormat:@"%f", mValue]]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:mDescription]];
    [s appendString:@","];
    [s appendString:[self quoteSqlString:mMemo]];
    [s appendString:@");"];
}

#pragma mark Internal functions

+ (NSString *)tableName
{
    return @"Transactions";
}

@end
