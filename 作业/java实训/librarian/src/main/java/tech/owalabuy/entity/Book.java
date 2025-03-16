package tech.owalabuy.entity;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Book{
    private String isbn;
    private String title;
    private String author;
    private float price;
    private int total_stock;
    private int available_stock;
    private int borrow_count;
}
