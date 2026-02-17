# False paths for asynchronous signals
set_false_path -from [get_ports start] -to [all_registers]
set_false_path -from [get_ports stop]  -to [all_registers]
