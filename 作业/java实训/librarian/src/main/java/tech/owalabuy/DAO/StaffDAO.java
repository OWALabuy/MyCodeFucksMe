package tech.owalabuy.DAO;

import tech.owalabuy.entity.Staff;

public interface StaffDAO {

    // 根据员工 ID 获取员工信息
    Staff getStaffById(String staffId);

    // 获取所有员工信息
    Staff[] getAllStaff();

    // 新增员工
    void insertStaff(Staff staff);

    // 更新员工信息
    void updateStaff(Staff staff);

    // 删除员工
    void deleteStaffById(String staffId);
}

