//setup
// 1
class Item {
  //Create an Item class
  String name;
  double price; //Attributes: String name, double price
  Item(this.name, this.price); //Item item (an object of type Item)
  String displayItem() {
    return "$name - $price\$";
  }
}

//2
class ItemStock {
  Item item;
  int stock;
  ItemStock(this.item, this.stock);
  bool isInStock() {
    return stock > 0;
  }
}

//3
class VendingMachine {
  List<ItemStock> items;
  double balance = 0.0;
  VendingMachine(this.items); // to initialize items

//vMachine
//1
  void addItem(Item item, int stock) {
    items.add(ItemStock(item, stock));
  } //stock

//2
  void selectItem(String itemName) {
    ItemStock selectedItem =
        items.firstWhere((itemStock) => itemStock.item.name == itemName);

    if (selectedItem.isInStock()) {
      print("Selected: ${selectedItem.item.displayItem()}");
      print("Price: ${selectedItem.item.price}\$");
    } else {
      print("Item unuvilable");
    }
  }

//3
  void insertMoney(double amount) {
    balance += amount;
    print("Inserted $amount\$. your balance: $balance\$");
  }

//4
  void dispenseItem(String itemName) {
    ItemStock selectedItem =
        items.firstWhere((itemStock) => itemStock.item.name == itemName);

    if (selectedItem.isInStock() && balance >= selectedItem.item.price) {
      print("Dispensing ${selectedItem.item.displayItem()}");
      balance -=
          selectedItem.item.price; //Deducts the price from the user’s balance
      selectedItem.stock--; //reduces the stock of the item.
      double change = balance; //- Returns change if necessary.
      balance = 0.0;
      print("Returning changes: $change\$");
    } else {
      print("Insufficient");
    }
  }

  dynamic getTheChange() {
    //main(); //calling the main function to declair (getTheChange())
    double change = balance;
    balance = 0.0;
    return change;
  }
} // Returns the remaining balance to the user

void main() {
  print("Welcome to the Vending Machine!");
  print("Items Available:");

  List<ItemStock> items = [
    ItemStock(Item("Soda", 2.50), 10),
    ItemStock(Item("Chips", 1.50), 5),
    ItemStock(Item("Candy", 1.00), 0),
  ]; //  list of items
  VendingMachine vendingMachine = VendingMachine(items);

  //available items
  int itemNumber = 1;
  for (ItemStock itemStock in items) {
    print(
        "$itemNumber. ${itemStock.item.displayItem()} (Stock: ${itemStock.stock})");
    itemNumber++;
  } //its giving infinit loop(OVERFLOW STACK)... couldnt find out what is the issue

  vendingMachine.insertMoney(3.00);
  vendingMachine.selectItem("Soda");
  vendingMachine.dispenseItem("Soda");

  // Get remaining balance and change
  double change = vendingMachine.getTheChange();
  print("Remaining balance: ${change}\$");

  print("Do you want another item? (yes/no): no");

  print("Returning change: $change\$");
  print("Thank you for using the vending machine!");
}
