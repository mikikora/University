import java.io.Serializable;

public class Magazine extends Book implements Serializable {
    String category;
    int price;
    String readers;
    public Magazine(){}
    public Magazine(String title, String author, int pages, String category, int price, String readers){
        super(title,author,pages);
        this.category = category;
        this.price = price;
        this.readers = readers;
    }
    public String toString(){
        return super.toString() + "\n" + "In category " + category + " for " + readers + " in price " + price;
    }
}
