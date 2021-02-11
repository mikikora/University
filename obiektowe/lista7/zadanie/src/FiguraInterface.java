import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class FiguraInterface extends JPanel implements ActionListener {
    Figura f;
    JTextField Pole;
    JTextField Obwod;
    JTextField Nazwa;
    JButton save_button;
    Saving<Figura> save;
    JFrame frame;
    Container kontener;
    GridLayout layout;
    JLabel Pole_etykieta;
    JLabel Obwod_etykieta;
    JLabel Nazwa_etykieta;
    JLabel Zapisz_etykieta;

    public FiguraInterface (String filename) {
        save = new Saving<>(filename);
        f = save.Read();
        if (f == null) {
            f = new Figura();
        }
        Pole = new JTextField(Integer.toString(f.Pole), 10);
        Obwod = new JTextField(Integer.toString(f.Obwod), 10);
        Nazwa = new JTextField(f.Nazwa, 10);
        frame = new JFrame("Edycja figury");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        kontener = frame.getContentPane();
        layout = new GridLayout(4,2);
        kontener.setLayout(layout);
        Pole_etykieta = new JLabel("Pole: ");
        Obwod_etykieta = new JLabel("Obwod: ");
        Nazwa_etykieta = new JLabel("Nazwa");
        kontener.add(Pole_etykieta);
        kontener.add(Pole);
        kontener.add(Obwod_etykieta);
        kontener.add(Obwod);
        kontener.add(Nazwa_etykieta);
        kontener.add(Nazwa);
        save_button = new JButton("Zapisz");
        save_button.addActionListener(this);
        Zapisz_etykieta = new JLabel("Zapisz: ");
        kontener.add(Zapisz_etykieta);
        kontener.add(save_button);
        frame.pack();
        frame.setVisible(true);
    }

    public void actionPerformed (ActionEvent ev) {
        try {
            Integer.parseInt(Pole.getText());
        } catch (NumberFormatException ex) {
            System.out.println("W polu 'Pole' nie podano liczby");
        }
        catch (NullPointerException ex) {
            System.out.println("Pole 'Pole' jest puste");
        }
        try {
            Integer.parseInt(Obwod.getText());
        } catch (NumberFormatException ex) {
            System.out.println("W polu 'Obwod' nie podano liczby");
        }
        catch (NullPointerException ex) {
            System.out.println("Pole 'Obwod' jest puste");
        }
        f.Pole = Integer.parseInt(Pole.getText());
        f.Obwod = Integer.parseInt(Obwod.getText());
        f.Nazwa = Nazwa.getText();
        System.out.println(f);
        save.Save(f);
    }
}
