package tech.owalabuy.entity;

import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Borrow {
    private int id;
    private String email;
    private String isbn;
    private LocalDate borrow_date;
    private LocalDate return_date;
}
