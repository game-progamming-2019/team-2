extends Control

var _coin_count: int = 0
func _on_Coin_coin_collected():
	var label = $CanvasLayer/Label
	self._coin_count += 1
	label.text = "Coins: " + String(_coin_count)
	
	