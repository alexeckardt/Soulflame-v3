/// @desc Create Non-Persistance Required Meta

meta_object_create(Camera, 200000);
//meta_object_create(World, 4);
meta_object_create(Controller, 5);
meta_object_create(EnvironmentInit, 10);
meta_object_create(Paths, 10);
meta_object_create(Background, 20000);

Game.particleController = meta_object_create(ParticleController, 6);
