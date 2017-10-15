local function replace(str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    return string.gsub(str, what, with)
end

for _, picture in pairs(data.raw.wall["stone-wall"].pictures) do
  if picture.layers then
    for _, layer in pairs(picture.layers) do
      layer.filename = replace(layer.filename, "__base__", "__aai-industry__")
    end
  else
    for _, variations in pairs(picture) do
      for _, layer in pairs(variations.layers) do
        layer.filename = replace(layer.filename, "__base__", "__aai-industry__")
      end
    end
  end
end

for _, picture in pairs(data.raw.tile["stone-path"].variants) do
  if picture.count then
    picture.picture = replace(picture.picture, "__base__", "__aai-industry__")
  else
    for _, variations in pairs(picture) do
      variations.picture = replace(variations.picture, "__base__", "__aai-industry__")
    end
  end
end

data.raw.wall["stone-wall"].max_health = 350

local concrete = table.deepcopy(data.raw.wall["stone-wall"])
concrete.name = "concrete-wall"
concrete.minable.result = "concrete-wall"

for _, picture in pairs(concrete.pictures) do
  if picture.layers then
    for _, layer in pairs(picture.layers) do
      layer.filename = replace(layer.filename, "stone-wall", "concrete-wall")
    end
  else
    for _, variations in pairs(picture) do
      for _, layer in pairs(variations.layers) do
        layer.filename = replace(layer.filename, "stone-wall", "concrete-wall")
      end
    end
  end
end
concrete.max_health = 1000
data:extend({concrete})
