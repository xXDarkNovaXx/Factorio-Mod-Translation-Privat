require("prototypes/recipe/recipe-final")
require("prototypes/recipe/recipe-vehicle-fuel")

-- if another mod has changed labs but not burner lab
data.raw.lab["burner-lab"].inputs = data.raw.lab["lab"].inputs


if data.raw.item["electronics-machine-1"] and data.raw.recipe["electronic-circuit-stone"] then
  data.raw.recipe["electronic-circuit-stone"].category = "electronics"
end
