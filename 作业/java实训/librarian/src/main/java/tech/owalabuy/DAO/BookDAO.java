package tech.owalabuy.DAO;

import java.util.List;

import tech.owalabuy.entity.Book;

public interface BookDAO {

    // 根据 ISBN 获取图书
    Book getBookByIsbn(String isbn);

    // 获取所有图书信息
    List<Book> getAllBooks();

    // 新增图书
    void insertBook(Book book);

    // 更新图书信息
    void updateBook(Book book);

    // 删除图书
    void deleteBookByIsbn(String isbn);

    // 根据作者获取图书
    List<Book> getBooksByAuthor(String author);

    // 更新图书的库存
    void updateStock(String isbn, int availableStock);
}

