shootOffRange = 0;

//When Destroy; don't save name. Destroy self when memory is gotten.
saveToPersistence = false;
var mem = instance_nearest(x, y, oMemory);
storename = mem.map_id;
