# 对各个实体类进行dao接口的设计

> 为什么我在connectbot上使用fcitx5中文输入法会导致connectbot闪退啊啊
> 好像正常了 就连这输入法的框框都能正常显示了...之前还得依着感觉来打 但突然又闪退了 我再试试公网的 看看它能不能正常一点 不要再给我闪退了喵喵
> 我不想写作业！！我想回去玩饥荒联机！！

## Reader

### 根据邮箱检索读者信息

`Reader getReader(String email)`

邮箱是pk 注册的时候可以根据这个检查用户是否存在 登录的时候也可以用它来取得邮箱和密码 以验证登录信息的正确性

### 检查所有挂失借阅证的读者

`Reader[] getReaderLosted()`

我觉得这个接口是必要的... mysql里面的逻辑肯定比java中更高效的

返回值是一个数组

### 获取所有读者信息

`list<Reader> getAllReaders()`

无需解释

### 新增读者

`void insertReader(Reader reader)`

到时候获取的数据直接封装成一个对象就好了喵 不需要一个一个地扔（getter和setter是lombok弄的 java的lsp会报错awa）

### 修改读者信息

`void updateReader(Reader reader)`

修改前要先获取该读者的信息 没有被更改的信息按原来的样子填回就好了喵

### 通过邮箱删除读者

`void deleteReaderByEmail(Reader reader)`

删掉 删掉 一定要删掉...

注销账号的时候能用到这个接口

## Borrow

### 通过id查询借阅信息

`Borrow getBorrowById(int id)`

虽然这似乎没有什么用处...

### 通过读者邮箱查询借阅信息

`List<Borrow> getBorrowByEmail(String email)`

### 通过isbn查询借阅信息

`List<Borrow> getBorrowByIsbn(String isbn)`

### 查询所有未归还的借阅信息

`List<Borrow> getBorrowNotReturn()`

### 新增借阅信息

`void insertBorrow(Borrow borrow)`

一样是一个对象...

## Book
