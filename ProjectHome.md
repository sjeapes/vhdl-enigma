At the time of writing Wikipedia states "There currently are no known open source projects to implement the Enigma in logic gates using either RTL or VHDL logic gate markup languages."
It seems like time to remedy this.


What now exists is a VHDL implementation which, whilst missing some bells and whistles, does operate correctly (having been checked against other simulators).

The project is now at the point where a PCB is being created to bring the code to the real world (rather than a simulation which is all it's had a the moment).

A few things will be happening in parallel for the next phase of the project
  1. Parts are being chosen
  1. A schematic is being created
  1. Some code refinements to the existing code (listed as enhancements in the issue list)
  1. Additional code to support the hardware (listed as new tasks in issue list)

Once the schematic is finished there will also need to be some footprint creation and then PCB layout

I'm expecting to make a small (<5) number of boards as an intial batch to test and complete coding on.

Beyond that there are a number of other devices which could be build into the base design
-Lorenz
-TypeX

and even looking at implementations of Colossus, Tunney and the Bombe