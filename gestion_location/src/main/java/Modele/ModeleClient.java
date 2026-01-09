package Modele;

import entity.Client;
import doo.ClientDAO;

public class ModeleClient {
    private Client client;
    private ClientDAO daoClient = new ClientDAO();

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public void ajouterClient() {
        daoClient.ajouterClient(client);
    }
}
