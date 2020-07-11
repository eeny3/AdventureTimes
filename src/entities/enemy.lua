return function(x,y, pic)
return {
	x = x,
	y = y,
	w = 20,
	h = 24,
	state = idle,
	texture = pic,
	dead = false,
	collidable = true
}
end