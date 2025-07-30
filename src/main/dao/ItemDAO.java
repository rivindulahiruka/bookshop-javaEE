package main.dao;


import main.model.Item;
import java.util.List;

public interface ItemDAO {
    void save(Item item);
    List<Item> findAll();
    Item findByCode(String itemCode);
    void update(Item item);

    void deleteById(int id);

}

