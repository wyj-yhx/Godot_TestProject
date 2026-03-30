@tool
extends EditorPlugin

# 作为插件的场景.并且做实例化
var control = preload("uid://1p42rhnb68lb").instantiate()


func _enable_plugin() -> void:
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	# 在左侧的右下方添加一个自己的插件场景
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, control)
	pass


func _exit_tree() -> void:
	remove_control_from_docks(control)
	pass
