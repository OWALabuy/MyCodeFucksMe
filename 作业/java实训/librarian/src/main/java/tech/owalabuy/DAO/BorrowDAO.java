package tech.owalabuy.DAO;

import java.util.List;

import tech.owalabuy.entity.Borrow;

public interface BorrowDAO {

    // 根据 ID 获取借阅记录
    Borrow getBorrowById(int id);

    // 获取某个读者的所有借阅记录
    List<Borrow> getBorrowsByEmail(String email);

    // 新增借阅记录
    void insertBorrow(Borrow borrow);

    // 更新借阅记录
    void updateBorrow(Borrow borrow);

    // 根据 ID 删除借阅记录
    void deleteBorrowById(int id);

    // 查询某个图书的借阅记录
    List<Borrow> getBorrowsByIsbn(String isbn);
}

