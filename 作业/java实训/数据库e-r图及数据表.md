### 图书管理系统数据库设计

#### 图书信息表 (Book)
| 字段中文名  | 字段代码名 | 类型         | 空/非空  | pk? | fk | 说明              |
|------------|------------|--------------|----------|-----|----|-------------------|
| ISBN号     | isbn       | varchar(17)  | non-null | yes |    | 图书的ISBN号，唯一标识 |
| 书名       | title      | varchar(255) | non-null |     |    | 图书的书名        |
| 作者       | author     | varchar(255) | non-null |     |    | 作者              |
| 价格       | price      | decimal(10,2)| non-null |     |    | 图书的价格        |
| 库存总量   | total_stock| int          | non-null |     |    | 图书的库存总量    |
| 现存量     | available_stock | int      | non-null |     |    | 当前可借的书本数量 |
| 借出次数   | borrow_count| int         | non-null |     |    | 借书次数          |

#### 读者表 (Reader)
| 字段中文名    | 字段代码名     | 类型         | 空/非空  | pk? | fk | 说明            |
|--------------|----------------|--------------|----------|-----|----|-----------------|
| 邮箱         | email          | varchar(255) | non-null | yes |    | 唯一标识读者    |
| 姓名         | name           | varchar(255) | non-null |     |    | 读者姓名        |
| 最长借阅天数 | max_borrow_days| int          | non-null |     |    | 最长借阅天数    |
| 是否挂失     | lost_flag      | boolean      | non-null |     |    | 是否挂失（true/false）|

#### 借阅表 (Borrow)
| 字段中文名  | 字段代码名 | 类型         | 空/非空  | pk? | fk | 说明                |
|------------|------------|--------------|----------|-----|----|---------------------|
| 读者邮箱   | email      | varchar(255) | non-null | yes | yes | 外键，指向读者表     |
| ISBN号     | isbn       | varchar(17)  | non-null | yes | yes | 外键，指向图书表     |
| 借书日期   | borrow_date| date         | non-null |     |    | 借书日期            |
| 还书日期   | return_date| date         | nullable |     |    | 还书日期（若有）    |

#### 内部人员表 (Staff)
| 字段中文名    | 字段代码名   | 类型         | 空/非空  | pk? | fk | 说明              |
|--------------|--------------|--------------|----------|-----|----|-------------------|
| 工号         | staff_id     | varchar(10)  | non-null | yes |    | 唯一标识员工      |
| 姓名         | name         | varchar(255) | non-null |     |    | 员工姓名          |
| 身份         | role         | varchar(50)  | non-null |     |    | 员工身份（管理员/图书管理员） |

### Mermaid ER 图
```mermaid
erDiagram
BOOK {
    varchar isbn*PK
        varchar title
        varchar author
        decimal price
        int total_stock
        int available_stock
        int borrow_count
}

READER {
    varchar email*PK
        varchar name
        int max_borrow_days
        boolean lost_flag
}

BORROW {
    varchar email*FK*PK
        varchar isbn*FK*PK
        date borrow_date
        date return_date
}

STAFF {
    varchar staff_id*PK
        varchar name
        varchar role
}

BOOK ||--o{ BORROW
    READER ||--o{ BORROW
        ```
