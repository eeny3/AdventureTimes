function loadMap(path)
	local map = require(path)

	map.quads = {}

	local tileset = map.tilesets[1]
	map.tileset = tileset
	map.image = love.graphics.newImage(tileset.image)

	for i = 1, #map.tilesets do
		for y = 0, map.tilesets[i].imageheight/map.tilesets[i].tileheight - 1 do
			for x = 0, map.tilesets[i].imagewidth/map.tilesets[i].tilewidth - 1 do
				local quad = love.graphics.newQuad(
					x*map.tilesets[i].tilewidth,
					y*map.tilesets[i].tileheight,
					map.tilesets[i].tilewidth,
					map.tilesets[i].tileheight,
					map.tilesets[i].imagewidth,
					map.tilesets[i].imageheight
				)
				table.insert(map.quads, quad)
			end
		end
	end

	for i, layer in ipairs(map.layers) do
		for y = 0, layer.height - 1 do
			for x = 0, (layer.width - 1) do
				local index = (x + y*layer.width) + 1
				local tid = layer.data[index]

				if tid ~= 0 then
					local xx = x * map.tileset.tilewidth
					local yy = y * map.tileset.tileheight

					if layer.id == 1 then
						thisTile = tile(xx,yy)
						if (((tid - 1) == 139) or ((tid - 1) == 140) or ((tid - 1) == 141) or ((tid - 1) == 153) or ((tid - 1) == 159)) then
							thisTile.tag = 2
							if (tid - 1) == 139 then
								thisTile.loot = 1
							end
							if (tid - 1) == 140 then
								thisTile.loot = 2
							end
							if (tid - 1) == 141 then
								thisTile.loot = 3
							end
							if (tid - 1) == 153 then
								thisTile.loot = 4
							end
							if (tid - 1) == 159 then
								thisTile.loot = 5
							end
						end
						world:add(thisTile, thisTile.x,thisTile.y,thisTile.w,thisTile.h)
					end
				end
			end
		end
	end

	function map:draw()
		for i, layer in ipairs(self.layers) do
			for y = 0, layer.height - 1 do
				local currentX = (player.x >= 320) and (math.floor(player.x / 32) + 1 - 10) or 0
				local currentXpW = (player.x <= 2800) and (currentX + 19) or (layer.width - 1)
				for x = currentX, currentXpW do
					local index = (x + y*layer.width) + 1
					local tid = layer.data[index]

					if tid ~= 0 then
						local xx = x * self.tileset.tilewidth
						local yy = y * self.tileset.tileheight

						if ((tid - 1) == 141) and loot3 == false then
						elseif ((tid - 1) == 140) and loot2 == false then
						elseif ((tid - 1) == 139) and loot1 == false then
						elseif ((tid - 1) == 153) and loot4 == false then
						elseif ((tid - 1) == 159) and loot5 == false then
						else
							love.graphics.draw(
								self.image,
								self.quads[tid],
								xx,
								yy
							)
						end
					end
				end
			end
		end
	end

	return map
end