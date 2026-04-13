with Shared_Data;

package Lane_Sensor is
   task type Lane_Task(Shared_Obj : access Shared_Data.Shared);
end Lane_Sensor;