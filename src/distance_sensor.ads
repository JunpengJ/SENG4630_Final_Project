with Shared_Data;

package Distance_Sensor is
   task type Distance_Task(Shared_Obj : access Shared_Data.Shared);
end Distance_Sensor;