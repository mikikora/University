import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ContinuePublisherInterface extends JPanel implements ActionListener {
    ContinualPublisher cp;
    JTextField title;
    JTextField author;
    JTextField pages;
    JTextField volumeNumber;
    JTextField  beginningDate;
    JTextField frequency;
    JPanel tit;
    JPanel aut;
    JPanel pag;
    JPanel vol;
    JPanel beg;
    JPanel fre;
    JLabel ltit;
    JLabel laut;
    JLabel lpag;
    JLabel lvol;
    JLabel lbeg;
    JLabel lfre;
    JButton svbut;
    Saving<ContinualPublisher> save;
    public ContinuePublisherInterface( String filename ){
        save = new Saving<ContinualPublisher>(filename);
        cp = save.Read();
        if( cp == null )
        {
            cp = new ContinualPublisher();
        }
        title = new JTextField(cp.title,30);
        ltit = new JLabel("Tytuł");
        tit = new JPanel();
        tit.add(ltit);
        tit.add(title);
        author = new JTextField(cp.author,30);
        laut = new JLabel("Autor");
        aut = new JPanel();
        aut.add(laut);
        aut.add(author);
        pages = new JTextField(Integer.toString(cp.pages),10);
        lpag = new JLabel("Ilość Stron");
        pag = new JPanel();
        pag.add(lpag);
        pag.add(pages);
        volumeNumber = new JTextField(Integer.toString(cp.volumesNumber),10);
        lvol = new JLabel("Ilość tomów");
        vol = new JPanel();
        vol.add(lvol);
        vol.add(volumeNumber);
        beginningDate = new JTextField(Integer.toString(cp.beginningDate),10);
        lbeg = new JLabel("Data rozpoczęcia");
        beg = new JPanel();
        beg.add(lbeg);
        beg.add(beginningDate);
        frequency = new JTextField(cp.frequency,30);
        lfre = new JLabel("Częstotliwość wydawania");
        fre = new JPanel();
        fre.add(lfre);
        fre.add(frequency);
        this.setLayout(new BoxLayout(this, BoxLayout.Y_AXIS));
        this.add(tit);
        this.add(aut);
        this.add(pag);
        this.add(vol);
        this.add(beg);
        this.add(fre);
        svbut = new JButton("Zapisz");
        svbut.addActionListener(this);
        this.add(svbut);
    }

    public void actionPerformed(ActionEvent ev)
    {
        cp.title = title.getText();
        cp.author = author.getText();
        cp.pages = Integer.valueOf(pages.getText());
        cp.volumesNumber = Integer.valueOf(volumeNumber.getText());
        cp.beginningDate = Integer.valueOf(beginningDate.getText());
        cp.frequency = frequency.getText();
        System.out.println(cp);
        save.Save(cp);
    }
}

