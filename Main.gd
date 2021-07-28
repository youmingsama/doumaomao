extends Node

export (PackedScene) var Mob
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$music.stop()
	$game_over_music.play()
	get_tree().call_group("mobs","queue_free")
	

func new_game():
	score=0
	$Player.start($startpos.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Ready!!!")
	$music.play()
	

func _on_MobTimer_timeout():
	# Choose a random location on Path2D.
	$MobPath/MobSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var mob = Mob.instance()
	add_child(mob)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	mob.position = $MobPath/MobSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	# Set the velocity (speed & direction).
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)




func _on_startTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_scoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
