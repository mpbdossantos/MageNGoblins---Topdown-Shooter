extends CanvasLayer
class_name Interface

onready var current_spell: Label = get_node("CurrentSpell")
onready var mp: Label = get_node("MP")

func set_spell_text(spell: String) -> void:
	current_spell.text = "Current Spell: " + spell

func set_spell_mp(current_mp: int, max_mp: int) -> void:
	mp.text = "MP: " + str(current_mp) + "/" + str(max_mp)
