extends Control

signal pick_up_item(item)
signal new_customer
signal order_completed(order)
signal patience_changed

var held_item: String = ""
var burger_items: Array = []
var current_order: Array = []
var selected_item: String = "" 

@onready var buns_list: CanvasItem = %BunList
@onready var condiments_list: CanvasItem = %CondimentsList
@onready var zombie: TextureRect = %Zombie
@onready var zombie_dialogue: Label = %ZombieDialogue
@onready var order_label: Label = %OrderLabel
@onready var score_label: Label = %ScoreLabel
@onready var patience_label: Label = %PatienceLabel
@onready var patience_timer: Timer = %PatienceTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pick_up_item.connect(_on_pick_up_item)
    new_customer.connect(_on_new_customer)
    order_completed.connect(_on_order_completed)
    patience_timer.timeout.connect(_on_patience_timer_run_out)

    buns_list.visible = false
    condiments_list.visible = false
    order_label.visible = false
    new_customer.emit() 

    zombie_dialogue.text = "Foood! Or you will be food."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    score_label.text = "Score: %d" % Global.score
    patience_label.text = "Time Left: %.1d" %patience_timer.time_left 


# Functions to handle game events such as item pickup and new customers

# Called when an item is picked up
func _on_pick_up_item(item: String) -> void:
    held_item = item
    print("Picked up item: %s" % held_item)

# Currently in used
func _on_new_customer() -> void:
    # zombie_dialogue.text = "Foood! Or you will be food."
    current_order = generate_order()
    show_order()
    Global.reset_patience()
    reset_patience_timer()
    patience_timer.start()

# Functions to handle burger assembly

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
        zombie_dialogue.text = "Yum! Safe for now."
        order_completed.emit(burger_items)
    else:
        print("Incorrect order. Expected: ", current_order)
        Global.patience = 0
    burger_items.clear()

# Called when the burger is thrown in the trash
func _on_trash_button_pressed() -> void:
    print("Discarded burger: ", burger_items)
    burger_items.clear()


# Functions to handle customer orders

# Called when the order is completed successfully
func _on_order_completed(order: Array) -> void:
    print("Order completed: ", order)
    var points: int = order.size() * 10 
    Global.add_score(points)
    new_customer.emit()

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

func show_order() -> void:
    order_label.visible = true
    order_label.text = "Order: \n" 
    for item in current_order:
        order_label.text += item + "\n"


# Functions to handle selected ingredients from UI button elements

# Toggle the list of selectable bun items upon clicking the buns
func _on_buns_button_pressed() -> void:
    buns_list.visible = not buns_list.visible

func _on_pickle_button_pressed() -> void:
    pick_up_item.emit("pickle")

func _on_patty_button_pressed() -> void:
    pick_up_item.emit("patty")

func _on_lettuce_button_pressed() -> void:
    pick_up_item.emit("lettuce")

func _on_cheese_button_pressed() -> void:
    pick_up_item.emit("cheese")

func _on_condiments_button_pressed() -> void:
    condiments_list.visible = not condiments_list.visible

# Functions to handle selection of items from a possible list of ingredients

func _on_bun_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    selected_item = buns_list.get_item_text(index)
    pick_up_item.emit(selected_item)
    buns_list.visible = false

func _on_condiments_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    selected_item = condiments_list.get_item_text(index)
    pick_up_item.emit(selected_item)
    condiments_list.visible = false


# Functions to handle patience and score updates

# Reset patience timer to global patience value, may decrease as game progress
func reset_patience_timer() -> void:
    patience_timer.set_wait_time(Global.patience)
    print("Timer reseted successfully. Time set to: ", patience_timer.get_wait_time())

func _on_patience_timer_run_out() -> void:
    patience_timer.stop()
    zombie_dialogue.text = "Game over!"

# Placeholder button for testing certain codes before implementing "Test" button
func _on_generate_order_button_pressed() -> void:
    print("Current Time Left: ", patience_timer.get_time_left())
    # new_customer.emit()