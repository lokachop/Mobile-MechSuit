LvLK3D = LvLK3D or {}

LvLK3D.DO_SHADOWING = true
LvLK3D.DO_LIGHTING = true

-- non-live editable constants below:
LvLK3D.MAX_OBJECTS = 1024 -- higher = slightly slower but more objects are possible to be interacted with
-- INTERNAL:
-- the entire render loop works via doing a for i = 1, LvLK3D.MAX_OBJECTS (copied into a local first) so this limits
-- how many objects can be in the same universe but allows doing rendering without using pairs to iterate



LvLK3D.MAX_PHYSICS_OBJECTS = 256 -- higher = slightly slower but more objects
-- INTERNAL:
-- same as with max render objects but with ODE physics objects

LvLK3D.PHYSICS_STEPS = 2 -- 2 substeps