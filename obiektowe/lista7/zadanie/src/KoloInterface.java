import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class KoloInterface extends JPanel implements ActionListener {
    Kolo k;
    JTextField Pole;
    JTextField Obwod;
    JTextField Nazwa;
    JTextField srodek_x;
    JTextField srodek_y;
    JTextField promien;
    JButton save_button;
    Saving<Kolo> save;
    JFrame frame;
    Container kontener;
    GridBagLayout layout;
    JLabel Pole_etykieta;
    JLabel Obwod_etykieta;
    JLabel Nazwa_etykieta;
    JLabel srodek;
    JLabel promien_etykieta;
    GridBagConstraints c;

    public KoloInterface (String file) {
        save = new Saving<>(file);
        k = save.Read();
        if (k == null) {
            k = new Kolo();
        }
        frame = new JFrame("Edycja kola");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        kontener = frame.getContentPane();
        layout = new GridBagLayout();
        c = new GridBagConstraints();
        kontener.setLayout(layout);
        Pole = new JTextField(Integer.toString(k.Pole), 10);
        Obwod = new JTextField(Integer.toString(k.Obwod), 10);
        Nazwa = new JTextField(k.Nazwa, 10);
        Pole_etykieta = new JLabel("Pole: ");
        Obwod_etykieta = new JLabel("Obwod: ");
        Nazwa_etykieta = new JLabel("Nazwa");
        srodek_x = new JTextField(Integer.toString(k.x), 10);
        srodek_y = new JTextField(Integer.toString(k.y), 10);
        promien = new JTextField(Integer.toString(k.radiant), 10);
        srodek = new JLabel("Wspolrzedne srodka: ");
        save_button = new JButton("Zapisz");
        save_button.addActionListener(this);
        promien_etykieta = new JLabel("Promien: ");

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
        kontener.add(promien_etykieta, c);

        c.gridx = 1;
        kontener.add(promien, c);

        c.gridx = 0;
        c.gridy = 4;
        c.gridwidth = 2;
        kontener.add(srodek, c);

        c.gridwidth = 1;
        c.gridy = 5;
        kontener.add(srodek_x, c);

        c.gridx = 1;
        kontener.add(srodek_y, c);

        c.gridx = 0;
        c.gridy = 6;
        c.gridwidth = 2;
        c.ipady = 20;
        kontener.add(save_button, c);

        frame.pack();
        frame.setVisible(true);
    }

    public void actionPerformed(ActionEvent ev) {
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
            Integer.parseInt(srodek_x.getText());
        } catch (NumberFormatException ex) {
            System.out.println("W polu 'Srodek x' nie podano liczby");
        }
        catch (NullPointerException ex) {
            System.out.println("Pole 'Srodek x' jest puste");
        }
        try {
            Integer.parseInt(srodek_y.getText());
        } catch (NumberFormatException ex) {
            System.out.println("W polu 'Srodek y' nie podano liczby");
        }
        catch (NullPointerException ex) {
            System.out.println("Pole 'Srodek y' jest puste");
        }
        try {
            Integer.parseInt(promien.getText());
        } catch (NumberFormatException ex) {
            System.out.println("W polu 'Promien' nie podano liczby");
        }
        catch (NullPointerException ex) {
            System.out.println("Pole 'Promien' jest puste");
        }
        k.Pole = Integer.parseInt(Pole.getText());
        k.Obwod = Integer.parseInt(Obwod.getText());
        k.Nazwa = Nazwa.getText();
        k.radiant = Integer.parseInt(promien.getText());
        k.x = Integer.parseInt(srodek_x.getText());
        k.y = Integer.parseInt(srodek_y.getText());
        System.out.println(k);
        save.Save(k);
    }
}
