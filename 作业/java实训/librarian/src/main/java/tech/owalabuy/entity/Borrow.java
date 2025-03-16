package tech.owalabuy.entity;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Borrow {
    private String email;
    private String isbn;
    private String borrow_date;
    private String return_date;
}
