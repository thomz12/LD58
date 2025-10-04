extends Resource
class_name FishType


@export var identifier := 'Goldfish' ## The type of fish
@export var sprite : AtlasTexture

@export_group('Catching', 'catch_')
@export var catch_base_value := 100
@export var catch_range := Vector2(0, 20) ## X is min, Y is max

@export_group('Length', 'base_')
@export var base_length := 1.0
@export var base_length_modifier := Vector2(.5, 2.0) ## X is min, Y is max

@export_group('Weight', 'base_')
@export var base_weight := 1.0
@export var base_weight_modifier := Vector2(.5, 2.0) ## X is min, Y is max
