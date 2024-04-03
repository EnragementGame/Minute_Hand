extends OmniLight3D

func _on_light_trigger_trigger_activate() -> void:
	light_color = Color.RED


func _on_blue_trigger_trigger_activate() -> void:
	light_color = Color.BLUE
