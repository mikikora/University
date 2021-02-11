import java.io.Serializable;

public class ContinualPublisher extends Book implements Serializable{
    int volumesNumber;
    int beginningDate;
    String frequency;
    public ContinualPublisher(){}
    public ContinualPublisher(String title, String author, int pages, int volumesNumber, int beginningDate, String frequency){
        super(title,author,pages);
        this.volumesNumber =  volumesNumber;
        this.beginningDate = beginningDate;
        this.frequency = frequency;
    }
    public String toString(){
        return super.toString() + "\n" + "Number of volumes is " + volumesNumber + "\n" + "Publishing started in" + beginningDate + "an it has frequency " + frequency;
    }
}
