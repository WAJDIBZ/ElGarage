package doo;

import entity.Client;

public class Test {
    public static void main(String[] args) {
        Icoocli clientDAO = new ClientDAO();
        Client client1 = new Client();
        client1.setNcin("11413422");
        client1.setNom("wajdi");
        client1.setPrenom("bz");
        client1.setNumTel("20887270");
        client1.setAdresse("7050");
        client1.setEmail("h5hnnn@gmail.com");
        clientDAO.ajouterClient(client1);
    }
}
