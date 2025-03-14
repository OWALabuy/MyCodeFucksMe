package tech.owalabuy.entity;
import lombox.Getter
import lombox.Setter

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
    //你知道为什么我不想写getter和setter么
}
