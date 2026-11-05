extends Control

signal pick_up_item(item)
signal new_customer

var held_item: String = ""
var burger_items: Array = []
var current_order: Array = []
var selected_item: String = "" #Currently not 

@onready var buns_list: CanvasItem = %BunList
@onready var condiments_list: CanvasItem = %CondimentsList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pick_up_item.connect(_on_pick_up_item)
    new_customer.connect(_on_new_customer)

    buns_list.visible = false
    condiments_list.visible = false

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
    else:
        print("Incorrect order. Prepare to be eaten!")
    burger_items.clear()

# Called when the burger is thrown in the trash
func _on_trash_button_pressed() -> void:
    print("Discarded burger: ", burger_items)
    burger_items.clear()

# Placeholder for generating a new order
# Ideally, this would be automatically generated when a new customer arrives and not via clicking a button
func _on_generate_order_button_pressed() -> void:
    current_order = generate_order()

# Helper function to generate a random order for the customer
func generate_order() -> Array:
    var order: Array = []
    var num_items: int = randi() % 6 + 1 # Up to Six Ingredients, Between 1 and 6 items
    var possible_items: Array = ["top_bun", "bottom_bun", "pickle", "patty", "lettuce", "cheese", "mayo", "mustard", "ketchup"]
    
    for i in range(num_items):
        var item: String = possible_items[randi() % possible_items.size()]
        order.append(item)
    
    print("Customer ordered: ", order)
    return order

# Functions to handle selected ingredients from UI button elements

# Toggle the list of selectable bun items upon clicking the buns
func _on_buns_button_pressed() -> void:
    if buns_list.visible:
        buns_list.visible = false
    else:
        buns_list.visible = true

func _on_pickle_button_pressed() -> void:
    pick_up_item.emit("pickle")

func _on_patty_button_pressed() -> void:
    pick_up_item.emit("patty")

func _on_lettuce_button_pressed() -> void:
    pick_up_item.emit("lettuce")

func _on_cheese_button_pressed() -> void:
    pick_up_item.emit("cheese")

func _on_mayo_button_pressed() -> void:
    # pick_up_item.emit("mayo")
    condiments_list.visible = true

func _on_mustard_button_pressed() -> void:
    # pick_up_item.emit("mustard")
    condiments_list.visible = true

func _on_ketchup_button_pressed() -> void:
    # pick_up_item.emit("ketchup")
    condiments_list.visible = true

# Functions to handle selection of items from a possible list of ingredients

func _on_bun_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    selected_item = buns_list.get_item_text(index)
    pick_up_item.emit(selected_item)
    buns_list.visible = false

func _on_condiments_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    selected_item = condiments_list.get_item_text(index)
    pick_up_item.emit(selected_item)
    condiments_list.visible = false