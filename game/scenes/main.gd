extends Control

signal pick_up_item(item)
signal new_customer

var held_item: String = ""
var burger_items: Array = []
var current_order: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pick_up_item.connect(_on_pick_up_item)
    new_customer.connect(_on_new_customer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

# Called when an item is picked up
func _on_pick_up_item(item: String) -> void:
    held_item = item
    print("Picked up item: %s" % held_item)

# Currently in used
func _on_new_customer() -> void:
    # Generate a new order
    # Display the order
    # Reset count down timer
    pass

# Called when adding an item to the burger by pressing on the assembly area
func _on_wrap_button_pressed() -> void:
    if held_item == "":
        return
    burger_items.push_front(held_item)
    print("Adding %s to burger" % held_item)
    held_item = ""

# Called when the burger is completed by pressing the done button
func _on_done_button_pressed() -> void:
    print("Burger completed: ", burger_items)
    if burger_items == current_order:
        print("Order completed correctly!")
    burger_items.clear()

# Called when the burger is thrown in the trash
func _on_trash_button_pressed() -> void:
    print("Discarded burger: ", burger_items)
    burger_items.clear()

# Helper function to generate a random order for the customer
func generate_order() -> Array:
    var order: Array = []
    var num_items: int = randi() % 6 + 1 # Up to Six Ingredients, Between 1 and 6 items
    var possible_items: Array = ["buns", "pickle", "patty", "lettuce", "cheese", "mayo", "mustard", "ketchup"]
    
    for i in range(num_items):
        var item: String = possible_items[randi() % possible_items.size()]
        order.append(item)
    
    print("Customer ordered: ", order)
    return order

# Placeholder for generating a new order
func _on_generate_order_button_pressed() -> void:
    current_order = generate_order()

func _on_buns_button_pressed() -> void:
    pick_up_item.emit("buns")

func _on_pickle_button_pressed() -> void:
    pick_up_item.emit("pickle")

func _on_patty_button_pressed() -> void:
    pick_up_item.emit("patty")

func _on_lettuce_button_pressed() -> void:
    pick_up_item.emit("lettuce")

func _on_cheese_button_pressed() -> void:
    pick_up_item.emit("cheese")

func _on_mayo_button_pressed() -> void:
    pick_up_item.emit("mayo")

func _on_mustard_button_pressed() -> void:
    pick_up_item.emit("mustard")

func _on_ketchup_button_pressed() -> void:
    pick_up_item.emit("ketchup")