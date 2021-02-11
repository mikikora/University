import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class BookInterface extends JPanel implements ActionListener{
    Book b;
    JTextField title;
    JTextField author;
    JTextField pages;
    JPanel tit;
    JPanel aut;
    JPanel pag;
    JLabel ltit;
    JLabel laut;
    JLabel lpag;
    JButton svbut;
    Saving<Book> save;
    public BookInterface( String filename ) {
        save = new Saving<Book>(filename);
        b = save.Read();
        if( b == null )
        {
            b = new Book();
        }
        title = new JTextField(b.title,30);
        ltit = new JLabel("Tytuł");
        tit = new JPanel();
        tit.add(ltit);
        tit.add(title);
        author = new JTextField(b.author,30);
        laut = new JLabel("Autor");
        aut = new JPanel();
        aut.add(laut);
        aut.add(author);
        pages = new JTextField(Integer.toString(b.pages),10);
        lpag = new JLabel("Ilość Stron");
        pag = new JPanel();
        pag.add(lpag);
        pag.add(pages);
        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        this.add(tit);
        this.add(aut);
        this.add(pag);
        svbut = new JButton("Zapisz");
        svbut.addActionListener(this);
        this.add(svbut);
    }

    public void actionPerformed(ActionEvent ev)
    {
        b.title = title.getText();
        b.author = author.getText();
        b.pages = Integer.valueOf(pages.getText());
        System.out.println(b);
        save.Save(b);
    }
}
