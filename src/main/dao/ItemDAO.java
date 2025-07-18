package main.dao;
import main.model.Item;
import main.model.User;

import java.util.List;

public interface ItemDAO {
    void addItem(Item item);
    void updateItem(Item item);
    void deleteItem(String itemCode);
    List<Item> getAllItems();
    Item getItemByCode(String itemCode);
}
