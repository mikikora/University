import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MagazineInterface extends JPanel implements ActionListener{
    Magazine m;
    JTextField title;
    JTextField author;
    JTextField pages;
    JTextField category;
    JTextField  price;
    JTextField readers;
    JPanel tit;
    JPanel aut;
    JPanel pag;
    JPanel cat;
    JPanel pri;
    JPanel rea;
    JLabel ltit;
    JLabel laut;
    JLabel lpag;
    JLabel lcat;
    JLabel lpri;
    JLabel lrea;
    JButton svbut;
    Saving<Magazine> save;
    /*public BookInterface()
    {
        b = new Book();
        title = new JTextField();
        author = new JTextField();
        pages = new JTextField();
        this.add(title);
        this.add(author);
        this.add(pages);
    }*/
    public MagazineInterface( String filename ){
        save = new Saving<Magazine>(filename);
        m = save.Read();
        if( m == null )
        {
            m = new Magazine();
        }
        title = new JTextField(m.title,30);
        ltit = new JLabel("Tytuł");
        tit = new JPanel();
        tit.add(ltit);
        tit.add(title);
        author = new JTextField(m.author,30);
        laut = new JLabel("Autor");
        aut = new JPanel();
        aut.add(laut);
        aut.add(author);
        pages = new JTextField(Integer.toString(m.pages),10);
        lpag = new JLabel("Ilość Stron");
        pag = new JPanel();
        pag.add(lpag);
        pag.add(pages);
        category = new JTextField(m.category,30);
        lcat = new JLabel("Kategoria");
        cat = new JPanel();
        cat.add(lcat);
        cat.add(category);
        price = new JTextField(Integer.toString(m.price),10);
        lpri = new JLabel("Cena");
        pri = new JPanel();
        pri.add(lpri);
        pri.add(price);
        readers = new JTextField(m.readers,30);
        lrea = new JLabel("Czytelnicy");
        rea = new JPanel();
        rea.add(lrea);
        rea.add(readers);
        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        this.add(tit);
        this.add(aut);
        this.add(pag);
        this.add(cat);
        this.add(pri);
        this.add(rea);
        svbut = new JButton("Zapisz");
        svbut.addActionListener(this);
        this.add(svbut);
    }

    public void actionPerformed(ActionEvent ev)
    {
        m.title = title.getText();
        m.author = author.getText();
        m.pages = Integer.valueOf(pages.getText());
        m.category = category.getText();
        m.price = Integer.valueOf(price.getText());
        m.readers = readers.getText();
        System.out.println(m);
        save.Save(m);
    }
}

