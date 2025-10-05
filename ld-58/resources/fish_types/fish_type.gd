extends Resource
class_name FishType

enum RARITY {
	COMMON,
	UNCOMMON,
	RARE,
	LEGENDARY,
	MYTHICAL,
	UPGRADE
}


@export var identifier := 'Goldfish' ## The type of fish
@export var sprite : AtlasTexture
@export var rarity : RARITY = RARITY.COMMON

@export_group('Catching', 'catch_')
@export var catch_base_value := 100
@export var catch_range := Vector2(0, 20) ## X is min, Y is max

@export_group('Length', 'base_')
@export var base_length := 1.0
@export_range(.5, 2.0, .01) var base_length_modifier := 1.0 ## X is min, Y is max

@export_group('Weight', 'base_')
@export var base_weight := 1.0
@export_range(.5, 2.0, .01) var base_weight_modifier := 1.0 ## X is min, Y is max

@export_group('Upgrade', 'upgrade_')
@export var upgrade_description := "This does something"
@export var upgrade_num = -1

func get_length() -> float:
	return base_length * base_length_modifier

func get_weight() -> float:
	return base_weight * base_weight_modifier

func get_score() -> float:
	return catch_base_value


func get_rarity_color(rarity: int) -> Color:
	var color := Color.WHITE
	match rarity:
		0:color = Color('#37946e')
		1:color = Color('#5b6ee1')
		2:color = Color('#ac3232')
		3: color = Color('#76428a')
		4: color = Color('#df7126')
	return color


func get_rarity_color_hex(rarity: int) -> String:
	var color := ""
	match rarity:
		0:color = '#37946e'
		1:color = '#5b6ee1'
		2:color = '#ac3232'
		3: color = '#76428a'
		4: color = '#df7126'
	return color
