import javax.swing.*;

public class lista07{
    public static void main(String args[])
    {
        Book alicja = new Book("Alicja w krainie czarów","Lewis Carroll",537);
        System.out.println(alicja);
        JFrame frame = new JFrame("Books editing");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        //BookInterface bu = new BookInterface("save2.ser");
        //ContinuePublisherInterface bu = new ContinuePublisherInterface("save3.ser");
        //MagazineInterface bu = new MagazineInterface("save4.ser");
        switch(args[0]) {
            case "Book":
                BookInterface bu;
                bu = new BookInterface(args[1]);
                frame.add(bu);
                frame.pack();
                frame.setVisible(true);
                break;
            case "ContinualPublisher":
                ContinuePublisherInterface cpu;
                cpu = new ContinuePublisherInterface(args[1]);
                frame.add(cpu);
                frame.pack();
                frame.setVisible(true);
                break;
            case "Magazine":
                MagazineInterface mu;
                mu = new MagazineInterface(args[1]);
                frame.add(mu);
                frame.pack();
                frame.setVisible(true);
                break;
            default:
                System.out.println("Nieprawidłowy argumnet");
        }

        return;
    }
}
