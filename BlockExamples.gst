"Counts from 1 to 20"
1 to: 20 do: [:x | x printNl ]

"Count up by more than one"
1 to: 20 by: 2 do: [:x | x printNl ]

"Counting down by negative step"
20 to: 1 by: -1 do: [:x | x printNl ]

"You can also represent ranges as an object"
i := Interval from: 5 to: 10
i do: [:x | x printNl ]

"Count by works here too"
i := Interval from: 5 to: 10 by: 2
i do: [:x | x printNl
