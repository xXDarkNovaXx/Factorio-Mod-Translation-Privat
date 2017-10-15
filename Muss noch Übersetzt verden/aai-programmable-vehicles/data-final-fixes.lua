require("prototypes/item-projectiles")

-- TODO: don't use "*", only use the base vehicles (not -_- variants)
-- data_raw_require("car", ... moved to entity update

--data_raw_require("gun", "*", {"attack_parameters"})

-- TODO: is this actually required?
--data_raw_require("ammo", "*", {"ammo_type", "magazine_size"})

-- can use game prototypes for collision_box now
-- data_raw_require("projectile", "*", {"collision_box"})

--data_raw_compile()

--log( serpent.block( data.raw["projectile"], {comment = false, numformat = '%1.8g' } ) )
