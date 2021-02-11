import java.io.Serializable;

public class Book implements Serializable {
     public String title;
     public String author;
     public int pages;
     public Book(String title, String author, int pages) {
         this.title = title;
         this.author = author;
         this.pages = pages;
     }
     public Book(){}
     public String toString() {
         return "'" + title + "'" + " pages " + pages + " written by " + author;
     }
}

