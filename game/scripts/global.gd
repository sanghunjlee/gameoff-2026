extends Node

var default_patience: int = 1000

var score: int = 0
var patience: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func add_score(points: int) -> void:
    score += points
    print("Score updated. Current score: %d" % score)

func decrease_patience(amount: int) -> void:
    patience -= amount
    # print("Patience decreased. Current patience: %d" % patience)

func reset_patience() -> void:
    patience = default_patience

func reset_game() -> void:
    score = 0
    reset_patience()