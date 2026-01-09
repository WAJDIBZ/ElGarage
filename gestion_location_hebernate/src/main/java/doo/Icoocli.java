package doo;

import java.util.List;

import entity.Client;

public interface Icoocli {
    void ajouterClient(Client c);
    List<Client> getAllClients();
    void modifierClient(Client c);
    void supprimerClient(int codeClient);
    Client getClientById(String codeClient);
}
