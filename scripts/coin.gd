extends Area2D
var coin=0


func _on_body_entered(body: Node2D) -> void:
	coin+=1
	print(coin)
	queue_free()
