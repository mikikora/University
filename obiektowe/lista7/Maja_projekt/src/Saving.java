import java.io.*;

public class Saving<T extends Serializable>{
    String filename;

    public Saving(String filename){
        this.filename = filename;
    }


    public void Save(T toSave){
        try
        {
            FileOutputStream file = new FileOutputStream(filename);
            ObjectOutputStream out = new ObjectOutputStream(file);
            out.writeObject(toSave);

            out.close();
            file.close();
        }
        catch(IOException ex)
        {
            System.out.println("Saving failed.");

        }
    }
    public T Read(){
        try
        {
            FileInputStream file = new FileInputStream(filename);
            ObjectInputStream in = new ObjectInputStream(file);
            T read;
            read = (T)in.readObject();
            in.close();
            file.close();
            return read;
        }
        catch(IOException ex)
        {
           return null;
        }
        catch(ClassNotFoundException ex)
        {
            return null;
        }
    }
}
