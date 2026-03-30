with Shared_Data;

package Control_Task is
   task type Control(Shared_Obj : access Shared_Data.Shared);
end Control_Task;