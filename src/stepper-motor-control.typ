#import "@preview/simple-plot:1.1.0": plot, line-plot

= Notes on stepper motor control

== Moving a stepper motor by a given displacement

We wish to move a stepper motor by a total displacement $s_"total"$, with an
acceleration during speed-up of $a_1 > 0$ and during slow-down of $-a_2 < 0$.
The maximum permitted velocity is $v_"max"$.  Deceleration begins at a
displacement $s_"decel"$.

There are two cases to consider, depending on whether the total displacement is
sufficient to reach the maximum velocity.  These are considered in turn below.

=== Case 1: Maximum velocity is reached

#align(center)[
  #plot(
    xmin: 0, xmax: 24, ymin: 0, ymax: 10, width: 10, height: 3,
    xlabel: [Time], ylabel: [Velocity],
    xtick: (4, 12, 20),
    xtick-labels: (
      $frac(v_"max", a_1, style: "horizontal")$,
      $t_"total" - frac(v_"max", a_2, style: "horizontal")$,
      $t_"total"$,
    ),
    xlabel-anchor: "west",
    ytick: (0, 9),
    ytick-labels: ("", $v_"max"$),
    ylabel-anchor: "south",
    show-grid: "major",
    axis-x-pos: "bottom", axis-y-pos: "left",
    line-plot(
      ((0,0), (4,9), (12,9), (20,0)),
      stroke: blue + 1pt,
      mark: none,
    )
  )
]

In this case, the change in displacement during the deceleration phase is given
by $frac(v_"max"^2, 2 a_2, style: "horizontal")$.  Therefore, the total
displacement reached at the start of the deceleration phase is:

$
s_"decel" = s_"total" - v_"max"^2 / (2 a_2) .
$

The total time taken for the operation is given by:

$
t_"total" &= s_"total" / v_"max" + v_"max" / 2 (1/a_1 + 1/a_2) .
$

=== Case 2: Maximum speed is not reached

#align(center)[
  #plot(
    xmin: 0, xmax: 24, ymin: 0, ymax: 10, width: 10, height: 3,
    xlabel: [Time], ylabel: [Velocity],
    xtick: (8, 20),
    xtick-labels: (
      $frac(v_"peak", a_1, style: "horizontal")$,
      $frac(v_"peak", a_1, style: "horizontal")
        + frac(v_"peak", a_2, style: "horizontal")$,
    ),
    xlabel-anchor: "west",
    ytick: (0, 7, 9),
    ytick-labels: ("", $v_"peak"$, $v_"max"$),
    ylabel-anchor: "south",
    show-grid: "major",
    axis-x-pos: "bottom", axis-y-pos: "left",
    line-plot(
      ((0,0), (8,7), (8,7), (20,0)),
      stroke: blue + 1pt,
      mark: none,
    )
  )
]

In this case, the total displacement is given by the sum of the displacements
during the acceleration and deceleration phases.  Letting $v_"peak"$ be the
peak velocity reached, we have:

$
s_"decel" &= v_"peak"^2 / (2 a_1) \
s_"total" &= v_"peak"^2 / 2 (1 / a_1 + 1 / a_2) .
$

Eliminating $v_"peak"$ between these, the total displacement reached at the
start of the deceleration phase is:

$
s_"decel" = s_"total" / (1 + frac(a_1, a_2, style: "horizontal")) .
$

The total time taken for the operation is given by:

$
t_"total" = sqrt(2 s_"total" (1/a_1 + 1/a_2)) .
$

=== Determining whether the maximum velocity is reached

The maximum velocity is reached if the total displacement is greater than or
equal to the sum of the displacements during the acceleration and deceleration
phases at maximum velocity. This condition can be expressed as:

$
1/a_1 + 1/a_2 <= (2 s_"total") / v_"max"^2 .
$

=== Plot of $s_"decel"$ versus $a_2$ for fixed $s_"total"$, $a_1$, and $v_"max"$

#align(center)[
  #plot(
    xmin: 0.0, xmax: 10.0,
    ymin: 0.0, ymax: 6.0,
    width: 10, height: 5,
    xlabel: [$a_2$],
    ylabel: [$s_"decel"$],
    show-grid: "major",
    axis-x-pos: "bottom",
    axis-y-pos: "left",
    xtick: (0, 1.667),
    xtick-labels: ("", [$a_2^"(crit)"$]),
    ytick: (0, 3.125, 5.0),
    ytick-labels: ("", [$s_"decel"^"(crit)"$], [$s_"total"$]),
    (
      fn: x => {
        let s_total = 5.0
        let a_1 = 1.0
        let v_max = 2.5

        if x < 0.05 {
          none
        } else if s_total < (v_max * v_max / 2.0) * (1.0 / a_1 + 1.0 / x) {
          // Max velocity is not reached
          s_total / (1.0 + a_1 / x)
        } else {
          none
        }
      },
      stroke: (paint:blue, thickness:1pt),
      samples: 1000,
    ),
    (
      fn: x => {
        let s_total = 5.0
        let a_1 = 1.0
        let v_max = 2.5

        if s_total < (v_max * v_max / 2.0) * (1.0 / a_1 + 1.0 / x) {
          none
        } else {
          // Max velocity is reached
          s_total - v_max * v_max / (2.0 * x)
        }
      },
      stroke: (paint:blue, thickness:1pt),
      samples: 1000,
    ),
  )
]

=== Plot of $t_"total"$ versus $a_2$ for fixed $s_"total"$, $a_1$, and $v_"max"$

#align(center)[
  #plot(
    xmin: 0.0, xmax: 10.0,
    ymin: 0.0, ymax: 10.0,
    width: 10, height: 5,
    xlabel: [$a_2$],
    ylabel: [$t_"total"$],
    show-grid: "major",
    axis-x-pos: "bottom",
    axis-y-pos: "left",
    xtick: (0, 1.0, 1.667),
    xtick-labels: ("", [$a_1$], [$a_2^"(crit)"$]),
    ytick: (0, 3.250, 4.5),
    ytick-labels: ("", [$t_"min"$], ""),
    (
      fn: x => {
        let s_total = 5.0
        let a_1 = 1.0
        let v_max = 2.5

        if x < 0.05 {
          none
        } else if s_total < (v_max * v_max / 2.0) * (1.0 / a_1 + 1.0 / x) {
          // Max velocity is not reached
          calc.sqrt(2.0 * s_total * (1.0 / a_1 + 1.0 / x))
        } else {
          none
        }
      },
      stroke: (paint:blue, thickness:1pt),
      samples: 1000,
    ),
    (
      fn: x => {
        let s_total = 5.0
        let a_1 = 1.0
        let v_max = 2.5

        if s_total < (v_max * v_max / 2.0) * (1.0 / a_1 + 1.0 / x) {
          none
        } else {
          // Max velocity is reached
          s_total / v_max + v_max / 2.0 * (1.0 / a_1 + 1.0 / x)
        }
      },
      stroke: (paint:blue, thickness:1pt),
      samples: 1000,
    ),
  )
]

