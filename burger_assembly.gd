extends Control

signal assemble_item(item)

enum ItemType {
    TOP_BUN,
    BOTTOM_BUN,
    CHEESE,
    LETTUCE,
    PATTY,
    PICKLE,
    KETCHUP,
    MUSTARD,
    MAYO,
}

@onready var top_bun: TextureRect = $TopBun
@onready var bottom_bun: TextureRect = $BottomBun
@onready var cheese: TextureRect = $Cheese
@onready var lettuce: TextureRect = $Lettuce
@onready var patty: TextureRect = $Patty
@onready var pickle: TextureRect = $Pickle
@onready var ketchup: TextureRect = $Ketchup
@onready var mustard: TextureRect = $Mustard
@onready var mayo: TextureRect = $Mayo

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    hide_all_items()
    # Global.current_item = 0
    # show_ingredient(Global.current_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func hide_all_items() -> void:
    top_bun.visible = false
    bottom_bun.visible = false
    cheese.visible = false
    lettuce.visible = false
    patty.visible = false
    pickle.visible = false
    ketchup.visible = false
    mustard.visible = false
    mayo.visible = false

func show_ingredient(current_item: int) -> void:
    hide_all_items()
    # print(ItemType.TOP_BUN)
    match current_item:
        ItemType.TOP_BUN:
            top_bun.visible = true
        ItemType.BOTTOM_BUN:
            bottom_bun.visible = true
        ItemType.CHEESE:
            cheese.visible = true
        ItemType.LETTUCE:
            lettuce.visible = true
        ItemType.PATTY:
            patty.visible = true
        ItemType.PICKLE:
            pickle.visible = true
        ItemType.KETCHUP:
            ketchup.visible = true
        ItemType.MUSTARD:
            mustard.visible = true
        ItemType.MAYO:
            mayo.visible = true
        _:
            pass
            
