$bat =  (get-item $PSCommandPath) -replace ".ps1$", ".bat"
& cmd /c $bat $args
