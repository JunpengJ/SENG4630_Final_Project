with Shared_Data;

package Driver_Input_Task is
   task type Driver_Input(Shared_Obj : access Shared_Data.Shared);
end Driver_Input_Task;