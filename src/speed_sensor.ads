with Shared_Data;

package Speed_Sensor is
   task type Speed_Task(Shared_Obj : access Shared_Data.Shared);
end Speed_Sensor;