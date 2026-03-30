with Shared_Data;

package Actuator_Task is
   task type Actuator(Shared_Obj : access Shared_Data.Shared);
end Actuator_Task;