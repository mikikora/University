import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TrojkatInterface extends JLabel implements ActionListener{
    Trojkat t;
    JTextField Pole;
    JTextField Obwod;
    JTextField Nazwa;
    JButton save_button;
    Saving<Trojkat> save;
    JFrame frame;
    Container kontener;
    GridBagLayout layout;
    JLabel Pole_etykieta;
    JLabel Obwod_etykieta;
    JLabel Nazwa_etykieta;
    JTextField wysokosc;
    JTextField x1;
    JTextField x2;
    JTextField x3;
    JTextField y1;
    JTextField y2;
    JTextField y3;
    JLabel Wysokosc_etykieta;
    JLabel Wierzcholki_etykieta;
    GridBagConstraints c;

    public TrojkatInterface (String file) {
        save = new Saving<>(file);
        t = save.Read();
        if (t == null) {
            t = new Trojkat();
        }
        Pole = new JTextField(Integer.toString(t.Pole), 10);
        Obwod = new JTextField(Integer.toString(t.Obwod), 10);
        Nazwa = new JTextField(t.Nazwa, 10);
        frame = new JFrame("Edycja trojkata");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        kontener = frame.getContentPane();
        layout = new GridBagLayout();
        kontener.setLayout(layout);
        Pole_etykieta = new JLabel("Pole: ");
        Obwod_etykieta = new JLabel("Obwod: ");
        Nazwa_etykieta = new JLabel("Nazwa");
        wysokosc = new JTextField(Integer.toString(t.h), 10);
        x1 = new JTextField(Integer.toString(t.x1), 10);
        x2 = new JTextField(Integer.toString(t.x2), 10);
        x3 = new JTextField(Integer.toString(t.x3), 10);
        y1 = new JTextField(Integer.toString(t.y1), 10);
        y2 = new JTextField(Integer.toString(t.y2), 10);
        y3 = new JTextField(Integer.toString(t.y3), 10);
        Wysokosc_etykieta = new JLabel("Wysokosc: ");
        Wierzcholki_etykieta = new JLabel("Wspolrzedne wierzcholkow: ");
        save_button = new JButton("Zapisz");
        save_button.addActionListener(this);
        c = new GridBagConstraints();

        c.fill = GridBagConstraints.HORIZONTAL;
        c.gridx = 0;
        c.gridy = 0;
        kontener.add(Pole_etykieta, c);

        c.gridx = 1;
        kontener.add(Pole, c);

        c.gridx = 0;
        c.gridy = 1;
        kontener.add(Obwod_etykieta, c);

        c.gridx = 1;
        kontener.add(Obwod, c);

        c.gridx = 0;
        c.gridy = 2;
        kontener.add(Nazwa_etykieta, c);

        c.gridx = 1;
        kontener.add(Nazwa, c);

        c.gridx = 0;
        c.gridy = 3;
        kontener.add(Wysokosc_etykieta, c);

        c.gridx = 1;
        kontener.add(wysokosc, c);

        c.gridx = 0;
        c.gridy = 4;
        c.gridwidth = 2;
        kontener.add(Wierzcholki_etykieta, c);

        c.gridy = 5;
        c.gridwidth = 1;
        kontener.add(x1, c);

        c.gridy = 6;
        kontener.add(x2, c);

        c.gridy = 7;
        kontener.add(x3, c);

        c.gridx = 1;
        c.gridy = 5;
        kontener.add(y1, c);

        c.gridy = 6;
        kontener.add(y2, c);

        c.gridy = 7;
        kontener.add(y3, c);

        c.gridy = 8;
        c.gridx = 0;
        c.gridwidth = 2;
        c.ipady = 20;
        kontener.add(save_button, c);

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
        try {
            Integer.parseInt(wysokosc.getText());
        }
        catch (NumberFormatException ex) {
            System.out.println("W polu 'Wysokosc' nie podano liczby");
        }
        try {
            Integer.parseInt(x1.getText());
            Integer.parseInt(x2.getText());
            Integer.parseInt(x3.getText());
            Integer.parseInt(y1.getText());
            Integer.parseInt(y2.getText());
            Integer.parseInt(y3.getText());
        }
        catch (NumberFormatException ex) {
            System.out.println("W jednym lub kilku polach wspolrzednych wierzcholkow podano nie liczbe");
        }
        t.Pole = Integer.parseInt(Pole.getText());
        t.Obwod = Integer.parseInt(Obwod.getText());
        t.Nazwa = Nazwa.getText();
        t.h = Integer.parseInt(wysokosc.getText());
        t.x1 = Integer.parseInt(x1.getText());
        t.x2 = Integer.parseInt(x2.getText());
        t.x3 = Integer.parseInt(x3.getText());
        t.y1 = Integer.parseInt(y1.getText());
        t.y2 = Integer.parseInt(y2.getText());
        t.y3 = Integer.parseInt(y3.getText());
        System.out.println(t);
        save.Save(t);
    }
}
