extends Node

var itemsCollected : float
var maxItems : float
var secretsFound : float
var maxSecrets : float
var bonusScenesFound : float
var maxScenes : float
var otherSecrets : float
var maxOther : float
var gameState : int
var completionPercent : float

#func _process(delta):
#    completionPercent = completion_calculate()

#func completion_calculate() -> float:
#    return (float(maxItems/itemsCollected)/100 + float(maxSecrets/secretsFound)/100 + float(maxScenes/bonusScenesFound)/100 + float(maxOther/otherSecrets)/100)/4