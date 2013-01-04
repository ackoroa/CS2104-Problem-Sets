-- Haskell program to simulate digital circuits
--
--  a signal is an infinite list of Bool; each element 
--     represents the value of the signal for a specific
--     clock cycle
--
--  logic gates are higher order functions that take
--     signals as arguments and output a signal ;
--     each gate also has a certain delay
--
--  complex circuits, like the /SR NAND latch given below
--     are obtained by connecting inputs and outputs of gates
--     through signals, which are transmitted by wires ;
--     thus, there will be a signal for every wire in the circuit

module Sim where

-- the signal that is always on "High"
high::[Bool]
high = True:high

-- the signal that is always on "Low"
low::[Bool]
low = False:low

-- create a limited list, of length "n", filled with logical value "fill"
-- useful to create signals by appending finite sequences
set :: Integer -> Bool -> [Bool]
set 0 _ = []
set n fill | n>0 = fill:(set (n-1) fill)

-- delay a signal by "n" clock cycles
--   prepends "n" instances of "fill" to the signal
delay :: Integer -> Bool -> [Bool] -> [Bool]
delay n fill s = (set n fill) ++ s

-- the inverter gate inverts every level for the entire signal,
-- and also delays the signal by one clock cycle
not_gate :: [Bool] -> [Bool]
not_gate s = delay 1 True (map not s)


-- a clock can be obtained by connecting an inverter's output to its input
--         |\       Clock
--      +--| >o----+--
--      |  |/      |
--      |          |
--      +----------+
clock :: [Bool]
clock = not_gate clock

-- and gate delays its output by 2 clock cycles
and_gate :: [Bool] -> [Bool] -> [Bool]
and_gate i1 i2 = delay 2 True (zipWith (&&) i1 i2)
                               -- "zipWith" is similar to map
							   -- but it takes a binary operator
							   -- and two lists, and produces
							   -- a list of results of the binary
							   -- operator being applied to corresponding
							   -- elements in the argument list
							   -- (&&) is the conjunction operator

--  A /SR latch (http://en.wikipedia.org/wiki/Latch_%28electronics%29)
--     is a device made up of 4 gates and 4 wires. Notice how the 
--     signals on the wires are defined in terms of outputs of the
--     corresponding gates.
--             ____
--     /S ----|    \   w1 |\       Q
--            |     |-----| >o----+--
--         +--|____/      |/      |
--         |                      |
--         +--------------------+ |
--                              | |
--         +-------------------- -+
--         |   ____             |
--         +--|    \   w2 |\    |  /Q
--            |     |-----| >o--+----
--     /R ----|____/      |/
--

srneg_latch :: [Bool]->[Bool]->[Bool]
srneg_latch s r = 
  let (q,qbar,w1,w2) = (not_gate w1,not_gate w2,and_gate s qbar,and_gate r q) in q

-- Consider now the following signals: (each dash represents 1 clock cycle)
--
--                +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
--  /S      6     |
--     -+-+-+-+-+-+  
--
--     -+-+-+-+-+-+-+-+-+-+-+-+-+-+-+           +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
--  /R            15                |     6     |
--                                  +-+-+-+-+-+-+
--
--  The following expression, when evaluated at the top level (you will have to cut and paste), 
--  will return the the Q signal of the latch for the first 40 clock cycles
--
--  take 40 (srneg_latch ((set 6 False)++high) ((set 15 True)++(set 6 False)++high)

or_gate :: [Bool] -> [Bool] -> [Bool]
or_gate i1 i2 = delay 2 True (zipWith (||) i1 i2)

nor_gate :: [Bool] -> [Bool] -> [Bool]
nor_gate i1 i2 = not_gate (or_gate i1 i2)

-- JK flip flop with delay of 8  
jk_flipflop :: [Bool]->[Bool]->[Bool]
jk_flipflop j k = 
  let (q,qbar,w1,w2) = (nor_gate w1 qbar,nor_gate q w2,and_gate k q,and_gate j qbar) in q

empty_list = []:empty_list
  
counter = 
	let (jk1,jk2,jk3,jk4) = (jk_flipflop high high, 
							jk_flipflop jk1 jk1, 
							jk_flipflop (and_gate jk3 (and_gate jk1 jk2)) (and_gate jk3 (and_gate jk1 jk2)),
							jk_flipflop (and_gate jk3 (and_gate jk1 jk2)) (and_gate jk3 (and_gate jk1 jk2)) ) in 
								zipWith (:) jk4 (zipWith (:) jk3 (zipWith (:) jk2 (zipWith (:) jk1 empty_list)))