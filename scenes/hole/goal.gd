extends Area3D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		get_tree().reload_current_scene()
