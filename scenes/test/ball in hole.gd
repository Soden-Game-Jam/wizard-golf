extends Node3D

func _process(delta: float) -> void:
	self.position = $"../Ball".position
