package tech.owalabuy.entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Reader{
    private String email;
    private String name;
    private int max_borrow_days;
    private boolean lost_flag;
}
