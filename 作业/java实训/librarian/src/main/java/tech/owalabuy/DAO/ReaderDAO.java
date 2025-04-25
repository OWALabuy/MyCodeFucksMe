package tech.owalabuy.DAO;

import tech.owalabuy.entity.Reader;
import java.util.List;

public interface ReaderDAO {

    // 根据邮箱检索读者信息
    Reader getReader(String email);

    // 检查所有挂失借阅证的读者
    List<Reader> getReaderLosted();

    // 获取所有读者信息
    List<Reader> getAllReaders();

    // 新增读者
    void insertReader(Reader reader);

    // 修改读者信息
    void updateReader(Reader reader);

    // 通过邮箱删除读者
    void deleteReaderByEmail(String email);
}

